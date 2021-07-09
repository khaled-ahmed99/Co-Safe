import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

class UserProvider extends ChangeNotifier {
  bool obscurePassword = true;
  String? token;
  String id = '';
  late bool isInfected;
  bool isLoading = false;
  bool optIn = false;

  void toggleOptIn(bool value) {
    optIn = value;
    notifyListeners();
  }

  void showPassword() {
    obscurePassword = !obscurePassword;
    notifyListeners();
  }

  void showLoadingIndicator() {
    isLoading = true;
    notifyListeners();
  }

  void notShowLoadingIndicator() {
    isLoading = false;
    notifyListeners();
  }

  void getToken(http.Response response) {
    var data = jsonDecode(response.body);
    var tokenData = data['token'];
    token = tokenData;
    notifyListeners();
  }

  void getID(http.Response response) {
    var data = jsonDecode(response.body);
    var idData = data['user']['_id'];
    id = idData;
    notifyListeners();
  }

  void getIsInfected(http.Response response) {
    var data = jsonDecode(response.body);
    var isInfectedData = data['user']['isInfected'];
    isInfected = isInfectedData;
    notifyListeners();
  }
}
