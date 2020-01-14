import 'dart:convert';
import 'dart:io';

import 'package:message_app/utils/network_util.dart';
import 'package:shared_preferences/shared_preferences.dart';

const String loginPath = "/api/auth/login";

class AuthLogin {
  NetworkUtil _networkUtil = NetworkUtil(loginPath);

  Future<bool> authenticateLogin(String username, String password) async {
    var body = json.encode({"user":{"name":username,"password":password}});
    dynamic response = handleResponse(await _networkUtil.post(body: body, headers: { "Content-Type": "application/json" }));
    String token = json.decode(response.body)["user"]["access_token"];
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs?.setString("token", token);
    return response.statusCode == HttpStatus.ok;
  }

  dynamic handleResponse(dynamic response) {
    final int statusCode = response.statusCode;

    if (statusCode == 403) {
      throw Exception("wrong Authentication");
    } else if (statusCode == 422) {
      throw Exception("Insufficient data provided");
    } else if (statusCode == 400) {
      throw Exception("No data provided");
    }

    return response;
  }
}
