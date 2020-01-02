import 'package:flutter/material.dart';
import 'package:message_app/utils/http_service.dart';
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
  HttpService _httpService = new HttpService();

  @override
  Widget build(BuildContext context) {
    final emailField = Padding(
      padding: const EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 10.0),
      child: TextFormField(
        decoration: InputDecoration(
          labelText: "Username",
        ),
        validator: (value) {
          if (value.isEmpty) {
            return 'Please enter your username';
          }
          return null;
        },
        controller: _usernameController,
      ),
    );

    final passwordField = Padding(
      padding: const EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 20.0),
      child: TextFormField(
        obscureText: true,
        decoration: InputDecoration(
          labelText: "Password",
        ),
        validator: (value) {
          if (value.isEmpty) {
            return 'Please enter your password';
          }
          return null;
        },
        controller: _passwordController,
      ),
    );

    return Scaffold(
        appBar: AppBar(
          title: Text("Messages App"),
        ),
        body: Builder(builder: (BuildContext context) {
          return Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                emailField,
                passwordField,
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: RaisedButton(
                    padding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                    onPressed: () async {
                      if (_formKey.currentState.validate()) {
                        var result = await _httpService.authenticate(
                            _usernameController.text, _passwordController.text);
                        if (result) {
                          SharedPreferences prefs = await SharedPreferences.getInstance();
                          prefs?.setString("username", _usernameController.text);
                          prefs?.setString("password", _passwordController.text);
                          Navigator.pushReplacementNamed(
                              context, HomePage.routeName);
                        } else {
                          Scaffold.of(context).showSnackBar(
                              SnackBar(content: Text("please try again")));
                        }
                      }
                    },
                    child: Text(
                      "Sign Up",
                    ),
                  ),
                ),
              ],
            ),
          );
        }));
  }
}
