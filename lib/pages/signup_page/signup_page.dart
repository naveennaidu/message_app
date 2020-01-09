import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:message_app/common/showDialogSingleButton.dart';
import 'package:message_app/pages/signup_page/password_field.dart';
import 'package:message_app/pages/signup_page/username_field.dart';
import 'package:message_app/utils/api/auth_login.dart';
import 'package:message_app/utils/api/auth_signup.dart';
import 'package:message_app/pages/home_page.dart';
import 'package:message_app/utils/internet_check.dart';
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
  InternetCheck _internetCheck = InternetCheck();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Messages App",
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: Builder(
        builder: (BuildContext context) {
          return Form(
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
                        await _onPressedSignUp(context);
                      },
                      child: Text(
                        "Sign Up",
                      ),
                    ),
                    RaisedButton(
                      padding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                      onPressed: () async {
                        await _onPressedLogin(context);
                      },
                      child: Text(
                        "Log In",
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 200),
              ],
            ),
          );
        },
      ),
    );
  }

  Future _onPressedLogin(BuildContext context) async {
    bool isConnected = await _internetCheck.check();
    if (_formKey.currentState.validate()) {
      if (isConnected) {
        AuthLogin _authLogin = AuthLogin();
        var result = await _authLogin.authenticateLogin(
            _usernameController.text, _passwordController.text);
        await _goToHomePage(result, context);
      } else {
        showDialogSingleButton(context, "Please check your internet connection",
            "This app needs internet connection to work", "OK");
      }
    }
  }

  Future _onPressedSignUp(BuildContext context) async {
    bool isConnected = await _internetCheck.check();
    if (_formKey.currentState.validate()) {
      if (isConnected) {
        AuthSignup _authSignup = AuthSignup();
        var result = await _authSignup.authenticateSignup(
            _usernameController.text, _passwordController.text);
        await _goToHomePage(result, context);
      } else {
        showDialogSingleButton(context, "Please check your internet connection",
            "This app needs internet connection to work", "OK");
      }
    }
  }

  Future _goToHomePage(bool result, BuildContext context) async {
    if (result) {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs?.setString("username", _usernameController.text);
      prefs?.setString("password", _passwordController.text);
      Navigator.pushReplacementNamed(context, HomePage.routeName);
    } else {
      showDialogSingleButton(
          context,
          "Unable to Login",
          "You may have supplied an invalid 'Username' / 'Password' combination",
          "OK");
    }
  }
}
