import 'dart:convert';

import 'package:message_app/utils/network_util.dart';
import 'package:message_app/utils/tokenizer.dart';

const String connectPath = "/api/connect/";

class HttpConnect {
  final NetworkUtil _networkUtil = NetworkUtil(connectPath);
  Tokenizer _tokenizer = Tokenizer();

  Future<dynamic> getConnection() async {
    String token = await _tokenizer.getToken();
    dynamic response =
        await _networkUtil.get(headers: {"Authorization": token});
    return json.decode(response.body);
  }

  Future<dynamic> postConnection() async {
    String token = await _tokenizer.getToken();
    dynamic response =
        await _networkUtil.post(headers: {"Authorization": token});
    return response.statusCode;
  }
}
