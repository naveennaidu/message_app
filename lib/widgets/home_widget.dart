import 'package:flutter/material.dart';
import 'package:message_app/common/showDialogSingleButton.dart';
import 'package:message_app/utils/http_connect.dart';
import 'package:message_app/utils/internet_check.dart';
import 'package:message_app/widgets/loading_widget.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeWidget extends StatefulWidget {
  @override
  _HomeWidgetState createState() => _HomeWidgetState();
}

class _HomeWidgetState extends State<HomeWidget> {

  HttpConnect _httpConnect = HttpConnect();
  InternetCheck _internetCheck = InternetCheck();

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
              bool isConnected = await _internetCheck.check();
              if (isConnected) {
                var connectStatus = await _httpConnect.postConnection();
                if (connectStatus == 200) {
                  Navigator.pushNamed(context, LoadingWidget.routeName);
                } else {
                  showDialogSingleButton(context, "please try again", "not able to connect to server", "OK");
                }
              }else {
                showDialogSingleButton(context, "Please check your internet connection", "This app needs internet connection to work", "OK");
              }

            },
          ),
        ),
      ],
    );
  }

}
