import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:message_app/common/showDialogSingleButton.dart';
import 'package:message_app/utils/auth_login.dart';
import 'package:message_app/utils/auth_signup.dart';
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
    // If you declare the fields as variables, it would look a
    // little better if you also move the initialization to its own method.
    // Not a mistake, but makes the code a little more readable

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
                UsernameField(usernameController: _usernameController),
                PasswordField(passwordController: _passwordController),
                Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: RaisedButton(
                          padding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                          // Can you put the code in it's own method and call that method here?
                          onPressed: () async {
                            SystemChannels.textInput.invokeMethod('TextInput.hide');
                            await onPressedSignUp(context);
                          },
                          child: Text(
                            "Sign Up",
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: RaisedButton(
                          padding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                          // Can you put the code in it's own method and call that method here?
                          onPressed: () async {
                            SystemChannels.textInput.invokeMethod('TextInput.hide');
                            await onPressedLogin(context);
                          },
                          child: Text(
                            "Log In",
                          ),
                        ),
                      ),
                    ]),
              ],
            ),
          );
        }));
  }

  Future onPressedLogin(BuildContext context) async {
    if (_formKey.currentState.validate()) {
      AuthLogin _authLogin = AuthLogin();
      var result = await _authLogin.authenticateLogin(
          _usernameController.text, _passwordController.text);
      if (result) {
        SharedPreferences prefs = await SharedPreferences.getInstance();
        prefs?.setString("username", _usernameController.text);
        prefs?.setString("password", _passwordController.text);
        Navigator.pushReplacementNamed(context, HomePage.routeName);
      } else {
        showDialogSingleButton(context, "Unable to Login", "You may have supplied an invalid 'Username' / 'Password' combination", "OK");
      }
    }
  }

  Future onPressedSignUp(BuildContext context) async {
    if (_formKey.currentState.validate()) {
      AuthSignup _authSignup = AuthSignup();
      var result = await _authSignup.authenticateSignup(
          _usernameController.text, _passwordController.text);
      if (result) {
        SharedPreferences prefs = await SharedPreferences.getInstance();
        prefs?.setString("username", _usernameController.text);
        prefs?.setString("password", _passwordController.text);
        Navigator.pushReplacementNamed(context, HomePage.routeName);
      } else {
        showDialogSingleButton(context, "Unable to SignUp", "Username already taken, please try again with new username", "OK");
      }
    }
  }
}

class PasswordField extends StatelessWidget {
  const PasswordField({
    Key key,
    @required TextEditingController passwordController,
  }) : _passwordController = passwordController, super(key: key);

  final TextEditingController _passwordController;

  @override
  Widget build(BuildContext context) {
    return Padding(
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
  }
}

class UsernameField extends StatelessWidget {
  const UsernameField({
    Key key,
    @required TextEditingController usernameController,
  }) : _usernameController = usernameController, super(key: key);

  final TextEditingController _usernameController;

  @override
  Widget build(BuildContext context) {
    return Padding(
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
  }
}
