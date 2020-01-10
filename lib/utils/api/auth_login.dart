import 'dart:convert';
import 'dart:io';

import 'package:message_app/utils/network_util.dart';
import 'package:shared_preferences/shared_preferences.dart';

const String loginPath = "/api/auth/login";

class AuthLogin {
  NetworkUtil _networkUtil = NetworkUtil(loginPath);

  Future<int> authenticateLogin(String username, String password) async {
    dynamic response = await _networkUtil.post(body: {
      "name": username,
      "password": password,
    });

    String token = json.decode(json.decode(response.body)["user"])["token"];
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs?.setString("token", token);
    return response.statusCode;
  }
}
