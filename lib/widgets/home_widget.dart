import 'package:flutter/material.dart';
import 'package:message_app/pages/chatting_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeWidget extends StatelessWidget {
  // This variable is not used!
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

              String endpoint = "2"; //await _httpService.post("", token);

              Navigator.push(
                  context,
                  new MaterialPageRoute(
                      builder: (BuildContext context) =>
                          new ChattingPage(endpoint: endpoint, partnerName: "User 1",)));
            },
          ),
        ),
      ],
    );
  }
}
