import 'dart:convert';

import 'package:message_app/models/message.dart';
import 'package:message_app/utils/network_util.dart';

const String messagesPath = "/api/chatroom/";

class HttpMessages {
  final String endpoint;
  final NetworkUtil _networkUtil;

  HttpMessages(this.endpoint): _networkUtil = NetworkUtil(messagesPath + endpoint);

  Future<List<Message>> fetchMessages(String token) {
    return _networkUtil
        .get(headers: {"Authorization": token}).then((dynamic response) {
      return (json.decode(json.decode(response.body)["messages"]))
          .map<Message>((p) => Message.fromJson(p))
          .toList();
    });
  }

  Future<dynamic> postMessages(String message, String token) {
    return _networkUtil.post(
        body: {"body": message},
        headers: {"Authorization": token}).then((dynamic response) {
      return json.decode(response.body);
    });
  }

}
