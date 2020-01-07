import 'dart:convert';

import 'package:message_app/models/chat_room.dart';
import 'package:message_app/utils/network_util.dart';

const String chatroomPath = "/api/chatrooms";

class HttpChatrooms {

  NetworkUtil _networkUtil = NetworkUtil(chatroomPath);

  Future<List<ChatRoom>> fetchChats(String token) {
    return _networkUtil.get(headers: {"Authorization": token}).then((dynamic response) {
      return (json.decode(json.decode(response.body)["chatrooms"]))
                .map<ChatRoom>((p) => ChatRoom.fromJson(p))
                .toList();
    });

  }
}