import 'dart:io';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'dart:async';

class HttpService {
  Future<bool> authenticate(String username, String password) async {
    String url =
        "https://messages.free.beeceptor.com/signup?username=$username&password=$password";
    http.Response response = await http.post(url);
    String token = response.headers["connection"];
    if (response.statusCode == HttpStatus.ok) {
      final secureStore = new FlutterSecureStorage();
      await secureStore.write(key: "token", value: token);
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
        return response.body;
      } else {
        throw Exception('Failed to load post');
      }
    });
  }
}
