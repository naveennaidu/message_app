import 'package:flutter/material.dart';
import 'package:message_app/pages/builder_page.dart';
import 'package:message_app/pages/signup_page.dart';

import 'pages/home_page.dart';
import 'pages/chatting_page.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Message App',
      initialRoute: BuilderPage.routeName,
      routes: {
        HomePage.routeName : (context) => HomePage(),
        ChattingPage.routeName : (context) => ChattingPage(),
        SignupPage.routeName : (context) => SignupPage(),
        BuilderPage.routeName : (context) => BuilderPage(),
      },
      theme: ThemeData(
        primarySwatch: Colors.lightBlue,
      ),
    );
  }
}



