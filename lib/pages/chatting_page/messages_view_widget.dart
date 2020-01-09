import 'dart:async';

import 'package:bubble/bubble.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:message_app/models/message.dart';

class MessagesViewWidget extends StatelessWidget {
  const MessagesViewWidget({
    Key key,
    @required this.messages,
    @required this.styleMe,
    @required this.styleOther,
    @required ScrollController scrollController,
  }) : _scrollController = scrollController, super(key: key);

  final StreamController<List<Message>> messages;
  final BubbleStyle styleMe;
  final BubbleStyle styleOther;
  final ScrollController _scrollController;

  @override
  Widget build(BuildContext context) {
    return Flexible(
      child: StreamBuilder<List<Message>>(
        stream: messages.stream,
        builder: (BuildContext context,
            AsyncSnapshot<List<Message>> snapshot) {
          if (snapshot.hasData) {
            var reversedList = snapshot.data.reversed.toList();
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
    );
  }
}