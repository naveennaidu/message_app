import 'dart:convert';

import 'package:message_app/models/message.dart';
import 'package:message_app/utils/network_util.dart';
import 'package:message_app/utils/tokenizer.dart';

const String messagesPath = "/api/chatrooms/";

class HttpMessages {
  final String endpoint;
  final NetworkUtil _networkUtil;

  HttpMessages(this.endpoint)
      : _networkUtil = NetworkUtil(messagesPath + endpoint + "/messages");
  Tokenizer _tokenizer = Tokenizer();

  Future<List<Message>> fetchMessages() async {
    String token = await _tokenizer.getToken();
    dynamic response =
        await _networkUtil.get(headers: {"Authorization": token});
    return json.decode(response.body)["messages"]
        .map<Message>((p) => Message.fromJson(p))
        .toList();
  }

  Future<dynamic> postMessages(String message) async {
    String token = await _tokenizer.getToken();
    var body = json.encode({"message":{"body":message}});
    dynamic response = await _networkUtil
        .post(body: body, headers: {"Authorization": token, "Content-Type": "application/json"});
    return json.decode(response.body);
  }
}
