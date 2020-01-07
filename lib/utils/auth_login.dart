import 'dart:convert';
import 'dart:io';

import 'package:message_app/utils/network_util.dart';
import 'package:shared_preferences/shared_preferences.dart';

const String loginPath = "/api/auth/login";

class AuthLogin {

  NetworkUtil _networkUtil = NetworkUtil(loginPath);

  Future<bool> authenticateLogin(String username, String password) {
    return _networkUtil.post(body: {
      "name": username,
      "password": password,
    }).then((dynamic response) async {
      String token = json.decode(response.body)["access_token"];
      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs?.setString("token", token);
      return response.statusCode == HttpStatus.ok;
    });
  }
}