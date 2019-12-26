import 'package:flutter/material.dart';
import 'package:message_app/pages/chatting_page.dart';

class HomeWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Text(
            "No. of users online:",
          style: TextStyle(fontSize: 30),
        ),
        Padding(
          padding: const EdgeInsets.only(bottom: 100.0),
          child: Text("5", style: TextStyle(color: Colors.green, fontSize: 30, fontWeight: FontWeight.bold),),
        ),
        Center(
          child: RaisedButton(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text('Connect', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),
            ),
            onPressed: () {
              Navigator.pushNamed(context, ChattingPage.routeName);
            },
          ),
        ),
      ],
    );
  }

}