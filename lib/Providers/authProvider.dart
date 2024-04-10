import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:unisafe/Services/storage.dart';
import 'package:unisafe/resources/constants.dart';

import '../Models/User.dart';

class AuthProvider extends ChangeNotifier {
  bool? _isLoggedIn;

  bool? get isLoggedIn => _isLoggedIn;

  User? _currentUser;

  User? get currentUser => _currentUser;

  Future login({required User user}) async {
    try {
      http.Response response = await http.post(
          Uri.parse('$baseUrl/users/login'),
          headers: {
            'Accept': 'application/json',
            'Content-Type': 'application/json'
          },
          body: json.encode(user.toLoginJson()));

      if (response.statusCode == 200 || response.statusCode == 201) {
        Map<String, dynamic> output = jsonDecode(response.body);

        try {
          _currentUser = User.fromJson(output);
          await LocalStorage.storeToken(token: output['tokens']['access']);
          await LocalStorage.storeUserData(user: _currentUser!);
          _isLoggedIn = true;
          notifyListeners();
        } catch (e) {
          print(e.toString());
          _isLoggedIn = false;
          notifyListeners();
        }
      } else {
        throw HttpException('${response.statusCode}: ${response.reasonPhrase}',
            uri: Uri.parse('$baseUrl/users/login'));
      }
    } catch (e) {}
  }


  Future registerStudent({required User user}) async {
    try {
      http.Response response = await http.post(
          Uri.parse('$baseUrl/users/signup/student'),
          headers: {
            'Accept': 'application/json',
            'Content-Type': 'application/json'
          },
          body: json.encode(user.toStudentSignupJson()));

      if (response.statusCode == 200 || response.statusCode == 201) {
        Map<String, dynamic> output = jsonDecode(response.body);
        log(output.toString());

        try {
          _currentUser = User.fromJson(output);
          await LocalStorage.storeToken(token: output['tokens']['access']);
          await LocalStorage.storeUserData(user: _currentUser!);
          _isLoggedIn = true;
          notifyListeners();
        } catch (e) {
          print(e.toString());
          _isLoggedIn = false;
          notifyListeners();
        }
      } else {
        throw HttpException('${response.statusCode}: ${response.reasonPhrase}',
            uri: Uri.parse('$baseUrl/users/login'));
      }
    } catch (e) {}
  }
}
