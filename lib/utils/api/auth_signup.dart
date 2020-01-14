import 'dart:convert';
import 'dart:io';

import 'package:message_app/utils/network_util.dart';
import 'package:shared_preferences/shared_preferences.dart';

const String signUpPath = "/api/auth/register";

class AuthSignup {
  NetworkUtil _networkUtil = NetworkUtil(signUpPath);

  Future<bool> authenticateSignup(String username, String password) async {
    var body = json.encode({
      "user": {"name": username, "password": password}
    });
    dynamic response = handleResponse(await _networkUtil
        .post(body: body, headers: {"Content-Type": "application/json"}));
    String token = json.decode(response.body)["user"]["access_token"];
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs?.setString("token", token);
    return response.statusCode == HttpStatus.created;
  }

  dynamic handleResponse(dynamic response) {
    final int statusCode = response.statusCode;

    if (statusCode == 422) {
      throw Exception("Username already in use or Insufficient data provided");
    } else if (statusCode == 400) {
      throw Exception("No data provided");
    }

    return response;
  }
}
