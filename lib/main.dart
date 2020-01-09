import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:message_app/pages/initial_page.dart';
import 'package:message_app/pages/signup_page/signup_page.dart';
import 'package:message_app/widgets/loading_widget.dart';

import 'pages/home_page.dart';
import 'pages/chatting_page/chatting_page.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    return MaterialApp(
      title: 'Message App',
      initialRoute: InitialPage.routeName,
      routes: {
        HomePage.routeName : (context) => HomePage(),
        ChattingPage.routeName : (context) => ChattingPage(),
        SignupPage.routeName : (context) => SignupPage(),
        InitialPage.routeName : (context) => InitialPage(),
        LoadingWidget.routeName : (context) => LoadingWidget(),
      },
      theme: ThemeData(
        primarySwatch: Colors.lightBlue,
      ),
    );
  }
}



