import 'package:flutter/material.dart';
import 'package:message_app/pages/chatting_page/chat_view_widget.dart';

class ChattingPage extends StatelessWidget {
  static const String routeName = 'chatting';
  final String endpoint;
  final String partnerName;

  const ChattingPage({Key key, this.endpoint, this.partnerName})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: <Widget>[
            CircleAvatar(
              backgroundColor: Colors.white,
              child: Text("${partnerName[0].toUpperCase()}"),
            ),
            SizedBox(
              width: 10,
            ),
            Text(partnerName),
          ],
        ),
      ),
      body: Container(
        color: Colors.yellow.withAlpha(64),
        child: ChatViewWidget(endpoint: endpoint,),
      ),
    );
  }
}
