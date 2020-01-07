import 'package:flutter/material.dart';
import 'package:message_app/pages/splash_page.dart';
import 'package:message_app/pages/signup_page.dart';

import 'pages/home_page.dart';
import 'pages/chatting_page.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Message App',
      initialRoute: SplashPage.routeName,
      routes: {
        HomePage.routeName : (context) => HomePage(),
        ChattingPage.routeName : (context) => ChattingPage(),
        SignupPage.routeName : (context) => SignupPage(),
        // TODO: You should not use a dedicated splash page.
        // Use your main() method to for app specific setup, and just display a
        // loading screen as supposed by Android or iOS
        SplashPage.routeName : (context) => SplashPage(),
      },
      theme: ThemeData(
        primarySwatch: Colors.lightBlue,
      ),
    );
  }
}



