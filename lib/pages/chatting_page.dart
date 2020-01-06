import 'dart:async';

import 'package:bubble/bubble.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:message_app/models/message.dart';
import 'package:message_app/utils/http_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ChattingPage extends StatefulWidget {
  static const String routeName = 'chatting';
  final String endpoint;

  const ChattingPage({Key key, this.endpoint}) : super(key: key);

  @override
  _ChattingPageState createState() => _ChattingPageState();
}

class _ChattingPageState extends State<ChattingPage> {
  final TextEditingController _textController = new TextEditingController();
  HttpService _httpService = new HttpService();
  bool _isComposing = false;
  String token;
  ScrollController _scrollController = new ScrollController();
  Timer timer;
  Future<List<Message>> messages;

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

  void _handleSubmitted(String text) {
    _httpService.post(
        "https://stormy-savannah-90253.herokuapp.com/api/message/2?body=$text",
        token);
    _textController.clear();
    setState(() {
      _isComposing = false;
      messages = makeFetchRequest();
    });
    Timer(
        Duration(milliseconds: 500),
        () => _scrollController
            .jumpTo(0.0));
  }

  @override
  void initState() {
    super.initState();
    messages = makeFetchRequest();
    timer = Timer.periodic(Duration(seconds: 1), (Timer t) {
      setState(() {
        messages = makeFetchRequest();
      });
    });
  }

  @override
  void dispose() {
    timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final title = 'Chatting';
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: Container(
          color: Colors.yellow.withAlpha(64),
          child: Column(
            children: <Widget>[
              Flexible(
                child: FutureBuilder<List<Message>>(
                  future: messages,
                  builder: (BuildContext context,
                      AsyncSnapshot<List<Message>> snapshot) {
                    if (snapshot.hasData) {
                      var reversedList = snapshot.data.reversed.toList();
                      return ListView.builder(
                        itemBuilder: (context, index) {
                          return Bubble(
                            style: reversedList[index].user_id == 5
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
                                          "${" " + DateFormat('kk:mm:a').format(DateTime.parse(reversedList[index].created_at))}",
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
                        onTap: () {
                          Timer(
                              Duration(milliseconds: 300),
                              () => _scrollController.jumpTo(
                                  0.0));
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

  Future<List<Message>> makeFetchRequest() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    token = prefs.getString("token");
    List<Message> listmessage = await _httpService.fetchMessages(
        "https://stormy-savannah-90253.herokuapp.com/api/chatroom/2", token);
    return listmessage;
  }
}
