import 'dart:async';

import 'package:flutter/material.dart';
import 'package:message_app/pages/chatting_page/chatting_page.dart';
import 'package:message_app/utils/api/http_connect.dart';

class LoadingWidget extends StatefulWidget {
  static const String routeName = 'loading';

  @override
  _LoadingWidgetState createState() => _LoadingWidgetState();
}

class _LoadingWidgetState extends State<LoadingWidget> {
  HttpConnect _httpConnect = HttpConnect();
  Timer timer;

  @override
  void initState() {
    super.initState();
    timer = Timer.periodic(Duration(seconds: 1), (Timer t) {
      _getConnectionStatus();
    });
  }

  @override
  void dispose() {
    timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            SizedBox(
              height: 100,
              width: 100,
              child: CircularProgressIndicator(),
            ),
            Text("Please wait, trying to connect"),
            SizedBox(
              height: 60,
            ),
            IconButton(
              icon: Icon(Icons.cancel),
              onPressed: () {
                Navigator.of(context).pop();
              },
              iconSize: 60,
              color: Colors.redAccent,
            ),
          ],
        ),
      ),
    );
  }

  _getConnectionStatus() async {
    Map<String, dynamic> json = await _httpConnect.getConnection();
    print(json);
    if (json["chatroom"] != null && json["other_name"] != null) {
      timer.cancel();
      Navigator.pushReplacement(
        context,
        new MaterialPageRoute(
          builder: (BuildContext context) => new ChattingPage(
            endpoint: json["chatroom"],
            partnerName: json["other_name"],
          ),
        ),
      );
    }
  }
}
