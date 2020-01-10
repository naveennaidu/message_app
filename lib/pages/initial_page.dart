import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:message_app/pages/signup_page/signup_page.dart';
import 'package:message_app/utils/api/auth_login.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'home_page.dart';

class InitialPage extends StatefulWidget {
  static const String routeName = 'initial_page';
  @override
  State<StatefulWidget> createState() {
    return _InitialPageState();
  }
}

class _InitialPageState extends State<InitialPage> {
  int result = HttpStatus.accepted;

  @override
  void initState() {
    super.initState();
    navigateUser();
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

  void navigateUser() async {
    // You should basically do this in the main() method of
    // your app, or at least in the first route you call.
    // Also, don't store username and password, but the token you receive
    // TODO: from the API instead (or additionally. Storing username and password to
    // allow automatic renewal might be okay)
    // Also, when storing the token, there is no necessity to perform a new authentication
    // on every startup, as long as the token did not expire
    SystemChannels.textInput.invokeMethod('TextInput.hide');
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var username = prefs.getString("username");
    var password = prefs.getString("password");

    if (username != null && password != null) {
      AuthLogin _authLogin = new AuthLogin();
      result = await _authLogin.authenticateLogin(username, password);
    }

    if (result == HttpStatus.ok) {
      Navigator.pushReplacementNamed(context, HomePage.routeName);
    } else {
      Navigator.pushReplacementNamed(context, SignupPage.routeName);
    }
  }
}
