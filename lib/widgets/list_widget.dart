import 'dart:async';

import 'package:avatar_letter/avatar_letter.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:message_app/common/showDialogSingleButton.dart';
import 'package:message_app/models/chat_room.dart';
import 'package:message_app/pages/chatting_page.dart';
import 'package:message_app/utils/http_chatrooms.dart';
import 'package:message_app/utils/internet_check.dart';

class ListWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MessageList();
  }
}

class MessageList extends StatefulWidget {
  @override
  _MessageListState createState() => _MessageListState();
}

class _MessageListState extends State<MessageList> {
  HttpChatrooms _httpChatrooms = HttpChatrooms();
  StreamController<List<ChatRoom>> _events;
  InternetCheck _internetCheck = InternetCheck();

  @override
  void initState() {
    super.initState();
    _events = StreamController<List<ChatRoom>>();
    _fetchChatList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Use a StreamBuilder here
      body: StreamBuilder<List<ChatRoom>>(
        stream: _events.stream,
        builder:
            (BuildContext context, AsyncSnapshot<List<ChatRoom>> snapshot) {
          if (snapshot.hasData) {
            return Container(
              child: ListView.builder(
                itemCount: snapshot.data.length,
                itemBuilder: (context, index) {
//                  ChatModel _model = ChatModel.dummyData[index];
                  return GestureDetector(
                    child: Column(
                      children: <Widget>[
                        Divider(
                          height: 12.0,
                        ),
                        ListTile(
                          leading: AvatarLetter(
                            size: 40,
                            backgroundColor: Colors.lightBlue,
                            textColor: Colors.white,
                            fontSize: 20,
                            upperCase: true,
                            numberLetters: 1,
                            letterType: LetterType.Circular,
                            text: snapshot.data[index].partnerName,
                            backgroundColorHex: null,
                            textColorHex: null,
                          ),
                          title: Row(
                            children: <Widget>[
                              Text(snapshot.data[index].partnerName),
                              SizedBox(
                                width: 16.0,
                              ),
                              snapshot.data[index].lastTime != null
                                  ? Text(
                                      "${DateFormat('kk:mm:a').format(snapshot.data[index].lastTime)}",
                                      style: TextStyle(fontSize: 12.0),
                                    )
                                  : Container(),
                            ],
                          ),
                          subtitle: Text(snapshot.data[index].lastMessage),
                          trailing: Icon(
                            Icons.arrow_forward_ios,
                            size: 14.0,
                          ),
                        ),
                      ],
                    ),
                    onTap: () async {
                      await Navigator.push(
                          context,
                          new MaterialPageRoute(
                              builder: (BuildContext context) =>
                                  new ChattingPage(
                                    endpoint:
                                        "${snapshot.data[index].endpoint}",
                                    partnerName:
                                        "${snapshot.data[index].partnerName}",
                                  )));
                      _fetchChatList();
                    },
                  );
                },
              ),
            );
          } else {
            return Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }

  _fetchChatList() async {
    bool isConnected = await _internetCheck.check();
    if (isConnected) {
      List<ChatRoom> listchat = await _httpChatrooms.fetchChats();
      _events.add(listchat);
    } else {
      showDialogSingleButton(context, "Please check your internet connection", "This app needs internet connection to work", "OK");
    }
  }
}
