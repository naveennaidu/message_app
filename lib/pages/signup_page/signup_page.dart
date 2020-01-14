import 'package:flutter/material.dart';
import 'package:message_app/common/showDialogSingleButton.dart';
import 'package:message_app/pages/signup_page/userinput_field.dart';
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
  final _passwordController = TextEditingController();
  final _usernameController = TextEditingController();

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
            UserInputField(
              usernameController: _usernameController,
              labelText: "username",
              obscureTextRequired: false,
            ),
            UserInputField(
              usernameController: _passwordController,
              labelText: "password",
              obscureTextRequired: true,
            ),
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
            SizedBox(height: 100),
          ],
        ),
      ),
    );
  }

  Future _onPressedLogin(BuildContext context) async {
    if (_formKey.currentState.validate()) {
      _onLoading();
      AuthLogin _authLogin = AuthLogin();
      try {
        var result = await _authLogin.authenticateLogin(
            _usernameController.text, _passwordController.text);

        if (result) {
          SharedPreferences prefs = await SharedPreferences.getInstance();
          prefs?.setString("username", _usernameController.text);
          prefs?.setString("password", _passwordController.text);
          Navigator.pop(context);
          Navigator.pushReplacementNamed(context, HomePage.routeName);
        }
      } on Exception catch (e) {
        Navigator.pop(context);
        showDialogSingleButton(context, "$e", "", "OK");
      }
    }
  }

  Future _onPressedSignUp(BuildContext context) async {
    if (_formKey.currentState.validate()) {
      _onLoading();
      AuthSignup _authSignup = AuthSignup();
      try {
        var result = await _authSignup.authenticateSignup(
            _usernameController.text, _passwordController.text);
        if (result) {
          SharedPreferences prefs = await SharedPreferences.getInstance();
          prefs?.setString("username", _usernameController.text);
          prefs?.setString("password", _passwordController.text);
          Navigator.pop(context);
          Navigator.pushReplacementNamed(context, HomePage.routeName);
        }
      } on Exception catch (e) {
        Navigator.pop(context);
        showDialogSingleButton(context, "$e", "", "OK");
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
