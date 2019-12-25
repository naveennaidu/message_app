import 'package:flutter/material.dart';

import 'home_page.dart';
import 'chatting_page.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Message App',
      initialRoute: HomePage.routeName,
      routes: {
        HomePage.routeName : (context) => HomePage(),
        ChattingPage.routeName : (context) => ChattingPage(),
      },
      theme: ThemeData(
        primarySwatch: Colors.lightBlue,
      ),
    );
  }
}



