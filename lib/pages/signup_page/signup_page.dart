import 'dart:io';

import 'package:flutter/material.dart';
import 'package:message_app/pages/signup_page/password_field.dart';
import 'package:message_app/pages/signup_page/username_field.dart';
import 'package:message_app/utils/api/auth_login.dart';
import 'package:message_app/utils/api/auth_signup.dart';
import 'package:message_app/pages/home_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SignupPage extends StatefulWidget {
  static const String routeName = 'Signup';
  SignupPage({Key key}) : super(key: key);

  @override
  _SignupPageState createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  final _formKey = GlobalKey<FormState>();
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Messages App",
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            UsernameField(usernameController: _usernameController),
            PasswordField(passwordController: _passwordController),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                RaisedButton(
                  padding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                  onPressed: () async {
                    _onLoading();
                    await _onPressedSignUp(context);
                  },
                  child: Text(
                    "Sign Up",
                  ),
                ),
                RaisedButton(
                  padding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                  onPressed: () async {
                    _onLoading();
                    await _onPressedLogin(context);
                  },
                  child: Text(
                    "Log In",
                  ),
                ),
              ],
            ),
            SizedBox(height: 100),
          ],
        ),
      ),
    );
  }

  Future _onPressedLogin(BuildContext context) async {
    if (_formKey.currentState.validate()) {
      AuthLogin _authLogin = AuthLogin();
      var result = await _authLogin.authenticateLogin(
          _usernameController.text, _passwordController.text);
      if (result == HttpStatus.ok) {
        SharedPreferences prefs = await SharedPreferences.getInstance();
        prefs?.setString("username", _usernameController.text);
        prefs?.setString("password", _passwordController.text);
        Navigator.pop(context);
        Navigator.pushReplacementNamed(context, HomePage.routeName);
      } else if (result == HttpStatus.forbidden) {
        Scaffold.of(context).showSnackBar(SnackBar(content: Text("Wrong username or password, please try again with correct details"),));
      }
    }
  }

  Future _onPressedSignUp(BuildContext context) async {
    if (_formKey.currentState.validate()) {
        AuthSignup _authSignup = AuthSignup();
        var result = await _authSignup.authenticateSignup(
            _usernameController.text, _passwordController.text);
        if (result == HttpStatus.created) {
          SharedPreferences prefs = await SharedPreferences.getInstance();
          prefs?.setString("username", _usernameController.text);
          prefs?.setString("password", _passwordController.text);
          Navigator.pop(context);
          Navigator.pushReplacementNamed(context, HomePage.routeName);
        } else if (result == HttpStatus.unprocessableEntity) {
          Scaffold.of(context).showSnackBar(SnackBar(content: Text("username already in use, please try with different username"),));
        }
    }
  }

  void _onLoading() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return Dialog(
          child: Container(
            height: 100,
            width: 100,
            color: Color.fromRGBO(135, 206, 235, 0.5),
            child: new Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                new CircularProgressIndicator(),
                new Text("Loading"),
              ],
            ),
          ),
        );
      },
    );
  }

}
