import 'dart:convert';

import 'package:message_app/utils/network_util.dart';
import 'package:shared_preferences/shared_preferences.dart';

const String signUpPath = "/api/auth/register";

class AuthSignup {
  NetworkUtil _networkUtil = NetworkUtil(signUpPath);

  Future<int> authenticateSignup(String username, String password) async {
    dynamic response = await _networkUtil.post(body: {
      'user': {
        'name': username,
        'password': password
      }
    });
    String token = json.decode(json.decode(response.body)["user"])["token"];
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs?.setString("token", token);
    return response.statusCode;
  }
}
