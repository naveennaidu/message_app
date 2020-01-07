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
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Icon(Icons.message, size: 50),
            Text(
              "Messages App",
              style: TextStyle(fontSize: 30),
            ),

          ],
        ),
      ),
    );
  }

  void startTimer() {
    Timer(Duration(seconds: 2), () {
      navigateUser();
    });
  }

  void navigateUser() async {
    // TODO: You should basically do this in the main() method of
    // your app, or at least in the first route you call.
    // Also, don't store username and password, but the token you receive
    // from the API instead (or additionally. Storing username and password to
    // allow automatic renewal might be okay)
    // Also, when storing the token, there is no necessity to perform a new authentication
    // on every startup, as long as the token did not expire
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var username = prefs.getString("username");
    var password = prefs.getString("password");

    if (username != null && password != null) {
      HttpService _httpService = new HttpService();
      result = await _httpService.authenticateLogin(username, password);
    }

    if (result) {
      Navigator.pushReplacementNamed(context, HomePage.routeName);
    } else {
      Navigator.pushReplacementNamed(context, SignupPage.routeName);
    }
  }
}
