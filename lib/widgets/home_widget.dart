import 'dart:io';

import 'package:flutter/material.dart';
import 'package:message_app/common/showDialogSingleButton.dart';
import 'package:message_app/utils/api/http_connect.dart';
import 'package:message_app/widgets/loading_widget.dart';

class HomeWidget extends StatefulWidget {
  @override
  _HomeWidgetState createState() => _HomeWidgetState();
}

class _HomeWidgetState extends State<HomeWidget> {
  HttpConnect _httpConnect = HttpConnect();

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(bottom: 100.0),
          child: Text(
            "Start chatting with random stranger",
            style: TextStyle(fontSize: 20),
          ),
        ),
        Center(
          child: RaisedButton(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                'Connect',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ),
            onPressed: () async {
              var connectStatus = await _httpConnect.postConnection();
              if (connectStatus == HttpStatus.ok) {
                Navigator.pushNamed(context, LoadingWidget.routeName);
              } else {
                showDialogSingleButton(context, "please try again",
                    "not able to connect to server", "OK");
              }
            },
          ),
        ),
      ],
    );
  }
}
