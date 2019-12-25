import 'package:flutter/material.dart';

class ChattingPage extends StatelessWidget {
  static const String routeName = 'chatting';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Message Screen"),
      ),
      body: Center(
          child: Text("Message screen")
      ),
    );
  }
}