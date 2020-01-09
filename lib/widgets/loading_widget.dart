import 'dart:async';

import 'package:flutter/material.dart';
import 'package:message_app/pages/chatting_page.dart';
import 'package:message_app/utils/http_connect.dart';
import 'package:shared_preferences/shared_preferences.dart';

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
    return Scaffold(body: Center(child: CircularProgressIndicator()));
  }

  _getConnectionStatus() async {
    Map<String, dynamic> json = await _httpConnect.getConnection();
    print(json);
    if (json["chatroom"] != null && json["user"] != null) {
      timer.cancel();
      Navigator.pushReplacement(
          context,
          new MaterialPageRoute(
              builder: (BuildContext context) =>
              new ChattingPage(endpoint: json["chatroom"], partnerName: json["user"],)));

    }
  }
}
