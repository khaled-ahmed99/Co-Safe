import 'dart:convert';

import 'package:co_safe/models/user.dart';
import 'package:http/http.dart' as http;

class UserData {
  Future<http.Response> createUser(User user) async {
    final msg = jsonEncode({
      "firstName": user.firstName,
      "lastName": user.lastName,
      "email": user.email,
      "password": user.password,
      "city": user.city,
      "street": user.street,
      "age": user.age,
      "phoneNo": user.phoneNumber
    });
    var response = await http.post(
        Uri.parse(
          'http://co-safe.herokuapp.com/user/client/signup',
        ),
        headers: <String, String>{'Content-Type': 'application/json'},
        body: msg);
    return response;
  }

  Future<http.Response> loginUser(User user) async {
    final msg = jsonEncode({
      "email": user.email,
      "password": user.password,
    });
    var response = await http.post(
        Uri.parse(
          'http://co-safe.herokuapp.com/user/client/login',
        ),
        headers: <String, String>{'Content-Type': 'application/json'},
        body: msg);
    return response;
  }
}
