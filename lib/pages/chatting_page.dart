import 'dart:async';

import 'package:avatar_letter/avatar_letter.dart';
import 'package:bubble/bubble.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:message_app/models/message.dart';
import 'package:message_app/utils/http_messages.dart';
import 'package:shared_preferences/shared_preferences.dart';

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
  String token;
  ScrollController _scrollController = new ScrollController();
  Timer timer;
  StreamController<List<Message>> messages;

  BubbleStyle styleMe = BubbleStyle(
    nip: BubbleNip.rightTop,
    color: Color.fromARGB(255, 225, 255, 199),
    margin: BubbleEdges.only(top: 8.0, left: 50.0),
    alignment: Alignment.topRight,
  );

  BubbleStyle styleSomebody = BubbleStyle(
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
        leading: IconButton(
            icon: new Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.pop(context, true);
            }),
        title: Row(
          children: <Widget>[
            AvatarLetter(
              size: 40,
              backgroundColor: Colors.white,
              textColor: Colors.black,
              fontSize: 20,
              upperCase: true,
              numberLetters: 1,
              letterType: LetterType.Circular,
              text: title,
              backgroundColorHex: null,
              textColorHex: null,
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
              Flexible(
                // Use a StreamBuilder here. Then you also don't need
                // to store the value in its own variable, but can just read the
                // value from the streamed event
                child: StreamBuilder<List<Message>>(
                  stream: messages.stream,
                  builder: (BuildContext context,
                      AsyncSnapshot<List<Message>> snapshot) {
                    if (snapshot.hasData) {
                      var reversedList = snapshot.data.reversed.toList();
                      return ListView.builder(
                        itemBuilder: (context, index) {
                          return Bubble(
                            style: reversedList[index].belongsToCurrentUser == 1
                                ? styleMe
                                : styleSomebody,
                            child: RichText(
                              text: TextSpan(
                                  style: TextStyle(
                                      fontSize: 16, color: Colors.black),
                                  children: [
                                    TextSpan(
                                        text: "${reversedList[index].text}"),
                                    TextSpan(
                                      text:
                                          "${" " + DateFormat('kk:mm:a').format(DateTime.parse(reversedList[index].createdAt))}",
                                      style: TextStyle(
                                          fontSize: 10, color: Colors.black),
                                    ),
                                  ]),
                            ),
                          );
                        },
                        itemCount: snapshot.data.length,
                        controller: _scrollController,
                        reverse: true,
                      );
                    } else {
                      return CircularProgressIndicator();
                    }
                  },
                ),
              ),
              Divider(height: 1.0),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                color: Colors.white,
                child: Row(
                  children: <Widget>[
                    Flexible(
                      child: new TextField(
                        controller: _textController,
                        onChanged: (String text) {
                          setState(() {
                            _isComposing = text.length > 0;
                          });
                        },
                        onSubmitted: _handleSubmitted,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          focusedBorder: InputBorder.none,
                          contentPadding: EdgeInsets.only(
                              left: 15, bottom: 11, top: 11, right: 15),
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
              ),
            ],
          )),
    );
  }

  // In this case, this method should be private.
  // Also, store the URL in a const
  _makeFetchRequest() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    token = prefs.getString("token");
    List<Message> listmessage = await _httpMessages.fetchMessages(token);
    messages.add(listmessage);
  }

  // Move private methods to the bottom of the class.
  // Also implement a repository class that stores all messages, and accesses
  // the API from a separate class. No need to bother accessing the API from
  // the widget directly.
  // Also use const to specify the URLs used
  void _handleSubmitted(String text) {
    _httpMessages.postMessages(text, token);
    _textController.clear();
    _makeFetchRequest();
    setState(() {
      _isComposing = false;
    });
  }
}
