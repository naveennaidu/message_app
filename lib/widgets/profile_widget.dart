import 'dart:async';

import 'package:avatar_letter/avatar_letter.dart';
import 'package:flutter/material.dart';
import 'package:message_app/pages/signup_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfileWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ProfileForm();
  }

}

class ProfileForm extends StatefulWidget {
  @override
  _ProfileFormState createState() => _ProfileFormState();
}

// Is there a reason you made this class not private as the other States?
class _ProfileFormState extends State<ProfileForm> {
  var username;
  StreamController<String> _events;

  @override
  void initState() {
    super.initState();
    _events = StreamController<String>();
    getUsername();
  }

  Future getUsername() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    username = prefs.getString("username");
    _events.add(username);
  }

  @override
  Widget build(BuildContext context) {
    // Use a StreamBuilder here.
    return StreamBuilder<String>(
      stream: _events.stream,
      builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
        if( snapshot.connectionState == ConnectionState.waiting){
          return  Center(child: Text('Please wait its loading...'));
        }else{
          if (snapshot.hasError)
            return Center(child: Text('Error: ${snapshot.error}'));
          else
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(top: 40.0),
                  child: Center(
                    child: AvatarLetter(
                      size: 80,
                      backgroundColor: Colors.lightBlue,
                      textColor: Colors.white,
                      fontSize: 40,
                      upperCase: true,
                      numberLetters: 1,
                      letterType: LetterType.Circular,
                      text: snapshot.data,
                      backgroundColorHex: null,
                      textColorHex: null,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Center(
                    child: Text(
                      snapshot.data.toUpperCase(),
                      style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 200.0),
                  child: Center(
                    child: RaisedButton(
                      onPressed: () async {
                        SharedPreferences prefs = await SharedPreferences.getInstance();
                        prefs?.clear();
                        Navigator.pushReplacementNamed(context, SignupPage.routeName);
                      },
                      child: Text('LOG OUT', style: TextStyle(fontWeight: FontWeight.bold)),
                      color: Colors.red,
                      textColor: Colors.white,
                    ),
                  ),
                ),
              ],
            );
        }
      }


    );
  }
}
