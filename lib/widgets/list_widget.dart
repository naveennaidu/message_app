import 'package:avatar_letter/avatar_letter.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:message_app/models/chat_model.dart';
import 'package:message_app/pages/chatting_page.dart';
import 'package:message_app/utils/http_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

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
  HttpService _httpService = new HttpService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // TODO: Use a StreamBuilder here
      body: FutureBuilder<List<ChatModel>>(
        future: fetchChatList(),
        builder:
            (BuildContext context, AsyncSnapshot<List<ChatModel>> snapshot) {
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
                            text: snapshot.data[index].name,
                            backgroundColorHex: null,
                            textColorHex: null,
                          ),
                          title: Row(
                            children: <Widget>[
                              Text(snapshot.data[index].name),
                              SizedBox(
                                width: 16.0,
                              ),
                              Text(
                                "${DateFormat('kk:mm:a').format(DateTime.parse(snapshot.data[index].datetime))}",
                                style: TextStyle(fontSize: 12.0),
                              ),
                            ],
                          ),
                          subtitle: Text(snapshot.data[index].message),
                          trailing: Icon(
                            Icons.arrow_forward_ios,
                            size: 14.0,
                          ),
                        ),
                      ],
                    ),
                    onTap: () async {
                      Navigator.push(
                          context,
                          new MaterialPageRoute(
                              builder: (BuildContext context) =>
                                  new ChattingPage(endpoint: "${snapshot.data[index].endpoint}")));
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

  Future<List<ChatModel>> fetchChatList() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = prefs.getString("token");
    List<ChatModel> listchat = await _httpService.fetchChats(
        "https://stormy-savannah-90253.herokuapp.com/api/chatroom/", token);
    return listchat;
  }
}
