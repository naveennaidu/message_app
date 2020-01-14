import 'dart:async';
import 'package:http/http.dart' as http;

const String backendUrl = "https://stormy-savannah-90253.herokuapp.com";

class NetworkUtil {
  final String url;

  NetworkUtil(String path) : this.url = backendUrl + path;

  Future<http.Response> get({Map<String, String> headers}) {
    return http.get(url, headers: headers).then((http.Response response) {
      return handleResponse(response);
    });
  }

  Future<http.Response> post(
      {Map<String, String> headers, body}) async {
    http.Response response =
        await http.post(url, body: body, headers: headers);
    return handleResponse(response);
  }

  Future<http.Response> delete(
      {Map<String, String> headers}) async {
    http.Response response =
    await http.delete(url, headers: headers);
    return handleResponse(response);
  }

  dynamic handleResponse(dynamic response) {
    final int statusCode = response.statusCode;

    if (statusCode == 500) {
      throw Exception("Server Down");
    }

    return response;
  }
}
