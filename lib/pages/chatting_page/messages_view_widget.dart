import 'dart:async';

import 'package:bubble/bubble.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:message_app/models/message.dart';

class MessagesViewWidget extends StatelessWidget {
  const MessagesViewWidget({
    Key key,
    @required this.messagesStream,
  }) : super(key: key);

  final StreamController<List<Message>> messagesStream;

  @override
  Widget build(BuildContext context) {
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

    return Flexible(
      child: StreamBuilder<List<Message>>(
        stream: messagesStream.stream,
        builder: (BuildContext context,
            AsyncSnapshot<List<Message>> snapshot) {
          if (snapshot.hasData) {
            var reversedList = snapshot.data;
            return ListView.builder(
              itemBuilder: (context, index) {
                return Bubble(
                  style: reversedList[index].belongsToCurrentUser
                      ? styleMe
                      : styleOther,
                  child: RichText(
                    text: TextSpan(
                        style: TextStyle(
                            fontSize: 16, color: Colors.black),
                        children: [
                          TextSpan(text: "${reversedList[index].text}"),
                          TextSpan(
                            text:
                            "${" " + DateFormat('kk:mm:a').format(reversedList[index].createdAt)}",
                            style: TextStyle(
                                fontSize: 10, color: Colors.black),
                          ),
                        ]),
                  ),
                );
              },
              itemCount: snapshot.data.length,
              reverse: true,
            );
          } else {
            return CircularProgressIndicator();
          }
        },
      ),
    );
  }
}