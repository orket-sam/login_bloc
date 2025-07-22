import 'dart:convert';

import 'package:logger/web.dart';
import 'package:http/http.dart' as http;

class LoginService {
  var logger = Logger();
  Future<http.StreamedResponse?> signIn(String email, String password) async {
    try {
      var headers = {'Content-Type': 'application/json'};
      var request = http.Request(
        'POST',
        Uri.parse('https://api.villagecirclerewards.com/apis/user/signin'),
      );
      print(email);
      request.body = json.encode({"email": email, "password": password});
      request.headers.addAll(headers);

      http.StreamedResponse response = await request.send();

      return response;
    } catch (e) {
      logger.e(e);
    }
    return null;
  }
}
