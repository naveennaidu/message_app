import 'dart:async';

import 'package:flutter/material.dart';
import 'package:message_app/authentication_service.dart';
import 'package:message_app/authetication_state.dart';
import 'package:message_app/pages/home_page.dart';

class SignupPage extends StatefulWidget {
  static const String routeName = 'Signup';
  final StreamController<AuthenticationState> streamController;
  SignupPage({Key key, @required this.streamController}) : super(key: key);

  @override
  _SignupPageState createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  final _formKey = GlobalKey<FormState>();
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();
  AuthenticationService _authenticationService = new AuthenticationService();

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

    final signupButton = Padding(
      padding: const EdgeInsets.all(8.0),
      child: RaisedButton(
        padding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
        onPressed: () async {
          if (_formKey.currentState.validate()) {
            widget.streamController.add(AuthenticationState.authenticated());
            var result =
            await _authenticationService.authenticate(_usernameController.text, _passwordController.text);
            print(result);
            if (result) {
              print("go to home");
              widget.streamController.add(AuthenticationState.authenticated());
              Navigator.pushReplacementNamed(context, HomePage.routeName);
            }
            else {
              widget.streamController.add(AuthenticationState.failed());
              Scaffold
                  .of(context)
                  .showSnackBar(SnackBar(content: Text('Sign Up Failed! Please try again')));
            }

          }
        },
        child: Text(
          "Sign Up",
        ),
      ),
    );
    return Scaffold(
        appBar: AppBar(
          title: Text("Messages App"),
        ),
        body: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              emailField,
              passwordField,
              signupButton,
            ],
          ),
        ));
  }
}
