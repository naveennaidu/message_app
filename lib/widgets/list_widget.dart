import 'package:avatar_letter/avatar_letter.dart';
import 'package:flutter/material.dart';
import 'package:message_app/models/chat_model.dart';

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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: ListView.builder(
          itemCount: ChatModel.dummyData.length,
          itemBuilder: (context, index) {
            ChatModel _model = ChatModel.dummyData[index];
            return Column(
              children: <Widget>[
                Divider(height: 12.0,),
                ListTile(
                  leading: AvatarLetter(
                    size: 40,
                    backgroundColor: Colors.lightBlue,
                    textColor: Colors.white,
                    fontSize: 20,
                    upperCase: true,
                    numberLetters: 1,
                    letterType: LetterType.Circular,
                    text: _model.name,
                    backgroundColorHex: null,
                    textColorHex: null,
                  ),
                  title: Row(
                    children: <Widget>[
                      Text(_model.name),
                      SizedBox(width: 16.0,),
                      Text(
                        _model.datetime,
                        style: TextStyle(fontSize: 12.0),
                      ),
                    ],
                  ),
                  subtitle: Text(_model.message),
                  trailing: Icon(
                    Icons.arrow_forward_ios,
                    size: 14.0,
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
