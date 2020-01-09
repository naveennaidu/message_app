import 'dart:async';

import 'package:bubble/bubble.dart';
import 'package:flutter/material.dart';
import 'package:message_app/common/showDialogSingleButton.dart';
import 'package:message_app/models/message.dart';
import 'package:message_app/pages/chatting_page/messages_view_widget.dart';
import 'package:message_app/utils/api/http_messages.dart';
import 'package:message_app/utils/internet_check.dart';

class ChattingPage extends StatefulWidget {
  static const String routeName = 'chatting';
  final String endpoint;
  final String partnerName;

  const ChattingPage({Key key, this.endpoint, this.partnerName})
      : super(key: key);

  @override
  _ChattingPageState createState() => _ChattingPageState();
}

class _ChattingPageState extends State<ChattingPage> {
  final TextEditingController _textController = new TextEditingController();
  HttpMessages _httpMessages;
  bool _isComposing = false;
  ScrollController _scrollController = new ScrollController();
  Timer timer;
  StreamController<List<Message>> messages;
  InternetCheck _internetCheck = InternetCheck();
  bool isConnected;

  BubbleStyle styleMe = BubbleStyle(
    nip: BubbleNip.rightTop,
    color: Color.fromARGB(255, 225, 255, 199),
    margin: BubbleEdges.only(top: 8.0, left: 50.0),
    alignment: Alignment.topRight,
  );

  BubbleStyle styleOther = BubbleStyle(
    nip: BubbleNip.leftTop,
    color: Colors.white,
    margin: BubbleEdges.only(top: 8.0, right: 50.0),
    alignment: Alignment.topLeft,
  );

  @override
  void initState() {
    super.initState();
    _httpMessages = HttpMessages(widget.endpoint);
    messages = StreamController<List<Message>>();
    _makeFetchRequest();
    timer = Timer.periodic(Duration(seconds: 1), (Timer t) {
      _makeFetchRequest();
    });
  }

  @override
  void dispose() {
    timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final title = widget.partnerName;
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: <Widget>[
            CircleAvatar(
              backgroundColor: Colors.white,
              child: Text("${title[0].toUpperCase()}"),
            ),
            SizedBox(
              width: 10,
            ),
            Text(title),
          ],
        ),
      ),
      body: Container(
        color: Colors.yellow.withAlpha(64),
        child: Column(
          children: <Widget>[
            MessagesViewWidget(
                messages: messages,
                styleMe: styleMe,
                styleOther: styleOther,
                scrollController: _scrollController),
            SizedBox(height: 10),
            Divider(height: 1.0),
            _chatBoxWidget(),
          ],
        ),
      ),
    );
  }

  Container _chatBoxWidget() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      color: Colors.white,
      child: Row(
        children: <Widget>[
          Flexible(
            child: new TextField(
              controller: _textController,
              onChanged: (String text) {
                setState(() {
                  _isComposing = !_isBlank(text);
                });
              },
              onSubmitted: _handleSubmitted,
              decoration: InputDecoration(
                border: InputBorder.none,
                focusedBorder: InputBorder.none,
                contentPadding:
                    EdgeInsets.only(left: 15, bottom: 11, top: 11, right: 15),
                filled: true,
                fillColor: Colors.white10,
                hintText: "send a message",
              ),
            ),
          ),
          Container(
              margin: new EdgeInsets.symmetric(horizontal: 4.0),
              child: IconButton(
                icon: new Icon(Icons.send,
                    color: _isComposing ? Colors.blue : Colors.grey),
                onPressed: _isComposing
                    ? () => _handleSubmitted(_textController.text)
                    : null,
              )),
        ],
      ),
    );
  }

  void _makeFetchRequest() async {
    isConnected = await _internetCheck.check();
    if (isConnected) {
      List<Message> listmessage = await _httpMessages.fetchMessages();
      messages.add(listmessage);
    } else {
      showDialogSingleButton(context, "Please check your internet connection",
          "This app needs internet connection to work", "OK");
      timer.cancel();
    }
  }

  void _handleSubmitted(String text) {
    if (isConnected) {
      _httpMessages.postMessages(text);
      _textController.clear();
      _makeFetchRequest();
      setState(() {
        _isComposing = false;
      });
    } else {
      showDialogSingleButton(context, "Please check your internet connection",
          "This app needs internet connection to work", "OK");
      timer.cancel();
    }
  }

  bool _isBlank(String text) => text == null || text.trim().isEmpty;
}
