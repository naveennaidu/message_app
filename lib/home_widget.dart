import 'package:flutter/material.dart';
import 'package:message_app/chatting_page.dart';

class HomeWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: RaisedButton(
        child: Text('Connect'),
        onPressed: () {
          Navigator.pushNamed(context, ChattingPage.routeName);
        },
      ),
    );
  }

}