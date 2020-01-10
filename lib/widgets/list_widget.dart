import 'dart:async';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:message_app/models/chat_room.dart';
import 'package:message_app/pages/chatting_page/chatting_page.dart';
import 'package:message_app/utils/api/http_chatrooms.dart';

class ListWidget extends StatefulWidget {
  @override
  _ListWidgetState createState() => _ListWidgetState();
}

class _ListWidgetState extends State<ListWidget> {
  HttpChatrooms _httpChatrooms = HttpChatrooms();
  StreamController<List<ChatRoom>> _events;

  @override
  void initState() {
    super.initState();
    _events = StreamController<List<ChatRoom>>();
    _fetchChatList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<List<ChatRoom>>(
        stream: _events.stream,
        builder:
            (BuildContext context, AsyncSnapshot<List<ChatRoom>> snapshot) {
          if (snapshot.hasData) {
            var orderedList = snapshot.data;
            orderedList.sort((a, b) =>
                b.lastTime.toString().compareTo(a.lastTime.toString()));
            orderedList.removeWhere((item) => item.lastTime == null);
            return ListView.builder(
              itemCount: orderedList.length,
              itemBuilder: (context, index) {
                return GestureDetector(
                  child: Column(
                    children: <Widget>[
                      ListTile(
                        leading: CircleAvatar(
                          backgroundColor: Colors.lightBlue,
                          child: Text(
                            "${orderedList[index].partnerName[0].toUpperCase()}",
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                        title: Row(
                          children: <Widget>[
                            Text(orderedList[index].partnerName),
                            SizedBox(
                              width: 16.0,
                            ),
                            orderedList[index].lastTime != null
                                ? Text(
                                    "${DateFormat('kk:mm:a').format(orderedList[index].lastTime)}",
                                    style: TextStyle(fontSize: 12.0),
                                  )
                                : Container(),
                          ],
                        ),
                        subtitle: Text(orderedList[index].lastMessage),
                        trailing: Icon(
                          Icons.arrow_forward_ios,
                          size: 14.0,
                        ),
                      ),
                      Divider(
                        height: 12.0,
                      ),
                    ],
                  ),
                  onTap: () async {
                    await Navigator.push(
                      context,
                      new MaterialPageRoute(
                        builder: (BuildContext context) => new ChattingPage(
                          endpoint: "${orderedList[index].endpoint}",
                          partnerName: "${orderedList[index].partnerName}",
                        ),
                      ),
                    );
                    _fetchChatList();
                  },
                );
              },
            );
          } else {
            return Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }

  _fetchChatList() async {
    List<ChatRoom> chatList = await _httpChatrooms.fetchChats();
    _events.add(chatList);
  }
}
