import 'dart:convert';

import 'package:message_app/utils/network_util.dart';
import 'package:message_app/utils/tokenizer.dart';

const String connectPath = "/api/connection/";

class HttpConnect {
  final NetworkUtil _networkUtil = NetworkUtil(connectPath);
  Tokenizer _tokenizer = Tokenizer();

  Future<dynamic> getConnection() async {
    String token = await _tokenizer.getToken();
    dynamic response = handleResponse(
        await _networkUtil.get(headers: {"Authorization": token}));
    return json.decode(response.body)["connection"];
  }

  Future<dynamic> postConnection() async {
    String token = await _tokenizer.getToken();
    dynamic response = handleResponse(
        await _networkUtil.post(headers: {"Authorization": token}));
    return response.statusCode;
  }

  Future<dynamic> cancelConnection() async {
    String token = await _tokenizer.getToken();
    dynamic response = handleResponse(
        await _networkUtil.delete(headers: {"Authorization": token}));
    return json.decode(response.body)["connection"];
  }

  dynamic handleResponse(dynamic response) {
    final int statusCode = response.statusCode;

    if (statusCode == 403) {
      throw Exception("Wrong Authorization");
    } else if (statusCode == 401) {
      throw Exception("Authorization not provided");
    }

    return response;
  }
}
