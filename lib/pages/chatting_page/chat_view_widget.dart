import 'dart:async';

import 'package:flutter/material.dart';
import 'package:message_app/models/message.dart';
import 'package:message_app/pages/chatting_page/messages_view_widget.dart';
import 'package:message_app/utils/api/http_connect.dart';
import 'package:message_app/utils/api/http_messages.dart';

class ChatViewWidget extends StatefulWidget {
  final String endpoint;

  const ChatViewWidget({Key key, @required this.endpoint}) : super(key: key);
  @override
  _ChatViewWidgetState createState() => _ChatViewWidgetState();
}

class _ChatViewWidgetState extends State<ChatViewWidget> {
  HttpMessages _httpMessages;
  HttpConnect _httpConnect = HttpConnect();
  bool _isComposing = false;
  StreamController<List<Message>> _messagesStream;
  final TextEditingController _textController = new TextEditingController();
  Timer _timer;

  @override
  void initState() {
    super.initState();
    _httpMessages = HttpMessages(widget.endpoint);
    _messagesStream = StreamController<List<Message>>();
    _makeFetchRequest();
    _timer = Timer.periodic(Duration(seconds: 1), (Timer t) {
      _makeFetchRequest();
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    Future.delayed(Duration(seconds: 2), () {
      _messagesStream.close();
    });
    _httpConnect.cancelConnection();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        MessagesViewWidget(
          messagesStream: _messagesStream,
        ),
        SizedBox(height: 10),
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
                      _isComposing = !_isBlank(text);
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
    );
  }

  void _makeFetchRequest() async {
    List<Message> messageList = await _httpMessages.fetchMessages();
    _messagesStream.add(messageList);
  }

  void _handleSubmitted(String text) {
    _httpMessages.postMessages(text);
    _textController.clear();
    _makeFetchRequest();
    setState(() {
      _isComposing = false;
    });
  }

  bool _isBlank(String text) => text == null || text.trim().isEmpty;
}
