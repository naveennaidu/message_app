import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:message_app/models/chat_model.dart';
import 'dart:async';

import 'package:message_app/models/message.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HttpService {
  Future<bool> authenticateSignup(String username, String password) async {
    String url =
        "https://stormy-savannah-90253.herokuapp.com/api/auth/register/?name=$username&password=$password";
    http.Response response = await http.post(url, body: {});
    String token = json.decode(response.body)["access_token"];
    if (response.statusCode == HttpStatus.created) {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs?.setString("token", token);
    } else {
      print("server error");
    }
    return response.statusCode == HttpStatus.created;
  }

  Future<bool> authenticateLogin(String username, String password) async {
    String url =
        "https://stormy-savannah-90253.herokuapp.com/api/auth/login/?name=$username&password=$password";
    http.Response response = await http.post(url);
    String token = json.decode(response.body)["access_token"];
    if (response.statusCode == HttpStatus.ok) {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs?.setString("token", token);
    } else {
      print("server error");
    }
    return response.statusCode == HttpStatus.ok;
  }

  Future<dynamic> get(String url, String token) async {
    return http.get(url, headers: {"Authorization": token}).then(
        (http.Response response) {
      if (response.statusCode == 200) {
        return response.body;
      } else {
        throw Exception('Failed to load post');
      }
    });
  }

  Future<dynamic> post(String url, String token) async {
    return http.post(url, headers: {"Authorization": token}).then(
        (http.Response response) {
      if (response.statusCode == 200) {
        return json.decode(response.body);
      } else {
        throw Exception('Failed to load post');
      }
    });
  }

  Future<List<Message>> fetchMessages(String url, String token) async {
    return http.get(url, headers: {"Authorization": token}).then(
        (http.Response response) {
      if (response.statusCode == 200) {
        return (json.decode(json.decode(response.body)["messages"]))
            .map<Message>((p) => Message.fromJson(p))
            .toList();
      } else {
        throw Exception('Failed to load post');
      }
    });
  }

  Future<List<ChatModel>> fetchChats(String url, String token) async {
    return http.get(url, headers: {"Authorization": token}).then(
            (http.Response response) {
          if (response.statusCode == 200) {
            return (json.decode(json.decode(response.body)["chatrooms"]))
                .map<ChatModel>((p) => ChatModel.fromJson(p))
                .toList();
          } else {
            throw Exception('Failed to load post');
          }
        });
  }
}
