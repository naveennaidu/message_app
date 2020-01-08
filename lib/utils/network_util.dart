import 'dart:async';
import 'package:http/http.dart' as http;

const String backendUrl = "https://stormy-savannah-90253.herokuapp.com";

class NetworkUtil {
  final String url;

  NetworkUtil(String path): this.url = backendUrl + path;

  Future<http.Response> get({Map<String, String> headers}) {
    return http.get(url, headers: headers).then((http.Response response) {
      return response;
    });
  }

  Future<http.Response> post({Map<String, String> headers, body, encoding}) {
    return http
        .post(url, body: body, headers: headers, encoding: encoding)
        .then((http.Response response) {
      return response;
    });
  }

}
