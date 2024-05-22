import 'dart:convert';
import '../models/user_model.dart';

import 'package:http/http.dart' as http;

var net = 'http://127.0.0.1:8000/';

Future<User> signUp(String username, fistName, String lastName, String email,
    String password) async {
  try {
    var request = http.MultipartRequest('POST', Uri.parse(net + 'user/'));
    request.fields['username'] = username;
    request.fields['first_name'] = fistName;
    request.fields['last_name'] = lastName;
    request.fields['email'] = email;
    request.fields['password'] = password;

    var streamedResponse = await request.send();
    if (streamedResponse.statusCode == 201 ||
        streamedResponse.statusCode == 200) {
      var response = await http.Response.fromStream(streamedResponse);
      final String responseString = response.body;
      return User.fromJson(responseString);
    } else {
      return Future.error("SERVER Error");
    }
  } catch (e) {
    return Future.error(e);
  }
}

Future<Map<String, dynamic>> login(String username, String password) async {
  final response = await http.post(
    Uri.parse(net + 'user/login/'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(<String, String>{
      'username': username,
      'password': password,
    }),
  );

  if (response.statusCode == 200) {
    final String responseString = response.body;
    return {
      'user': User.fromJson(responseString),
      'error': null,
    };
  } else {
    final error = jsonDecode(utf8.decode(response.bodyBytes))['error'];
    return {
      'user': null,
      'error': error,
    };
  }
}
