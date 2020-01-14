import 'dart:convert';

import 'package:message_app/models/chat_room.dart';
import 'package:message_app/utils/network_util.dart';
import 'package:message_app/utils/tokenizer.dart';

const String chatroomPath = "/api/chatrooms";

class HttpChatrooms {
  NetworkUtil _networkUtil = NetworkUtil(chatroomPath);
  Tokenizer _tokenizer = Tokenizer();

  Future<List<ChatRoom>> fetchChats() async {
    String token = await _tokenizer.getToken();
    dynamic response =
        await _networkUtil.get(headers: {"Authorization": token});
    return json.decode(response.body)["chatrooms"]
        .map<ChatRoom>((p) => ChatRoom.fromJson(p))
        .toList();
  }
}
