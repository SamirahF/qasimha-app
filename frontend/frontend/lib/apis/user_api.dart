import 'dart:convert';
import '../models/user_model.dart';

import 'package:http/http.dart' as http;

var net = 'http://127.0.0.1:8000/';

Future<User> signUp(String username, user_fname, String user_lname,
    String user_email, String user_password) async {
  try {
    var request = http.MultipartRequest('POST', Uri.parse(net + 'user/'));
    request.fields['username'] = username;
    request.fields['first_name'] = user_fname;
    request.fields['last_name'] = user_lname;
    request.fields['email'] = user_email;
    request.fields['password'] = user_password;

    var streamedResponse = await request.send();
    print(streamedResponse.statusCode);
    if (streamedResponse.statusCode == 201 ||
        streamedResponse.statusCode == 200) {
      print("NEW USER");
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

Future<User?> login(String email, String password) async {
  final response = await http.post(
    Uri.parse(net + 'user/login/'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(<String, String>{
      'email': email,
      'password': password,
    }),
  );

  if (response.statusCode == 200) {
    print("successful login!");
    return User.fromJson(response.body);
  } else {
    throw Exception('Failed to login');
  }
}
