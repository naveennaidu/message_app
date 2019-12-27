import 'dart:io';
import 'package:http/http.dart' as http;
import 'dart:async';

class AuthenticationService {

  Future<bool> authenticate(String username, String password) async {
    String url = "http://messageapp.free.beeceptor.com/signup?username=$username&password=$password";
    http.Response response = await http.post(url);
    print(response.body);
    return response.statusCode == HttpStatus.ok;
  }

}