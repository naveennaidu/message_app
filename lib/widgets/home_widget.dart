import 'package:flutter/material.dart';
import 'package:message_app/pages/chatting_page.dart';
import 'package:message_app/utils/http_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeWidget extends StatelessWidget {
  HttpService _httpService = new HttpService();
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
              SharedPreferences prefs = await SharedPreferences.getInstance();
              String token = prefs.getString("token");

              String endpoint = "token"; //await _httpService.post("", token);

              Navigator.push(
                  context,
                  new MaterialPageRoute(
                      builder: (BuildContext context) =>
                          new ChattingPage(endpoint: endpoint)));
            },
          ),
        ),
      ],
    );
  }
}
