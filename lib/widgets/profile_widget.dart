import 'dart:async';

import 'package:flutter/material.dart';
import 'package:message_app/pages/signup_page/signup_page.dart';
import 'package:shared_preferences/shared_preferences.dart';


class ProfileWidget extends StatefulWidget {
  @override
  _ProfileWidgetState createState() => _ProfileWidgetState();
}

class _ProfileWidgetState extends State<ProfileWidget> {
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
    return StreamBuilder<String>(
        stream: _events.stream,
        builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: Text('Please wait its loading...'));
          } else {
            if (snapshot.hasError)
              return Center(child: Text('Error: ${snapshot.error}'));
            else
              return Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  SizedBox(height: 30),
                  CircleAvatar(
                    backgroundColor: Colors.lightBlue,
                    radius: 60,
                    child: Text(
                      "${snapshot.data[0].toUpperCase()}",
                      style: TextStyle(color: Colors.white, fontSize: 50),
                    ),
                  ),
                  SizedBox(height: 16),
                  Text(
                    snapshot.data.toUpperCase(),
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 200),
                  RaisedButton(
                    onPressed: () async {
                      SharedPreferences prefs =
                          await SharedPreferences.getInstance();
                      prefs?.clear();
                      Navigator.pushNamedAndRemoveUntil(
                          context,
                          SignupPage.routeName,
                          (Route<dynamic> route) => false);
                    },
                    child: Text('LOG OUT',
                        style: TextStyle(fontWeight: FontWeight.bold)),
                    color: Colors.red,
                    textColor: Colors.white,
                  ),
                ],
              );
          }
        });
  }
}
