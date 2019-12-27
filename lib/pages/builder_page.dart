import 'dart:async';

import 'package:flutter/material.dart';
import 'package:message_app/authetication_state.dart';
import 'package:message_app/pages/home_page.dart';
import 'package:message_app/pages/signup_page.dart';

class BuilderPage extends StatelessWidget{
  static const String routeName = 'Builder';
  final StreamController<AuthenticationState> _streamController = new StreamController<AuthenticationState>();

  Widget buildUi(BuildContext context, AuthenticationState s) {
    if (s.authenticated) {
      return HomePage();
    } else {
      return SignupPage(streamController: _streamController);
    }
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new StreamBuilder<AuthenticationState>(
        stream: _streamController.stream,
        initialData: new AuthenticationState.initial(),
        builder: (BuildContext context,
            AsyncSnapshot<AuthenticationState> snapshot) {
          final state = snapshot.data;
          return buildUi(context, state);
        });
  }

}