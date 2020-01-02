import 'dart:async';

import 'package:flutter/material.dart';
import 'package:message_app/pages/signup_page.dart';
import 'package:message_app/utils/http_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'home_page.dart';

class SplashPage extends StatefulWidget {
  static const String routeName = 'splash_page';
  @override
  State<StatefulWidget> createState() {
    return _SplashPageState();
  }
}

class _SplashPageState extends State<SplashPage> {
  bool result = false;

  @override
  void initState() {
    super.initState();
    startTimer();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: Text(
        "Messages App",
        style: TextStyle(fontSize: 30),
      )),
    );
  }

  void startTimer() {
    Timer(Duration(seconds: 3), () {
      navigateUser();
    });
  }

  void navigateUser() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var username = prefs.getString("username");
    var password = prefs.getString("password");

    if (username != null && password != null) {
      HttpService _httpService = new HttpService();
      result = await _httpService.authenticate(username, password);
    }

    if (result) {
      Navigator.pushReplacementNamed(context, HomePage.routeName);
    } else {
      Navigator.pushReplacementNamed(context, SignupPage.routeName);
    }
  }
}
