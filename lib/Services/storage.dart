import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import '../Providers/Models/User.dart';


class LocalStorage {
  static const FlutterSecureStorage _storage = FlutterSecureStorage();

  static Future storeUserData({required User user}) async {
    await _storage.write(key: 'user', value: json.encode(user.toJsonStorage()));
  }

  static Future<User?> getUserData() async {
    var user = await _storage.read(key: 'user');
    var userData = User.fromJson(json.decode(user ?? '[]'));
    return userData;
  }

  static Future storeToken({required String token}) async {
    await _storage.write(key: 'token', value: token);
  }

  static Future<String?> getToken() async {
    var token = await _storage.read(key: 'token');
    return token;
  }


  static Future storeOnboarding() async {
    await _storage.write(key: 'onboarding', value: 'true');
  }

  static Future<bool> getOnboarding() async {
    var onboarding = await _storage.read(key: 'onboarding') != null
        ? await _storage.read(key: 'onboarding') == 'true'
            ? true
            : false
        : false;
    return onboarding;
  }

  static Future logout() async {
    await _storage.delete(key: 'token');
    await _storage.delete(key: 'user');
  }

  static Future<bool> checkSession() async {
    var available = await _storage.containsKey(key: 'token');
    return available;
  }
}

class LocalStorageProvider extends ChangeNotifier {
  User? _user;
  User? get user => _user;
  final _storage = const FlutterSecureStorage();



  Future<void> initialize() async {
    try {
      _user = await LocalStorage.getUserData();
      notifyListeners();
    } catch (e) {
      _user = null;
      notifyListeners();
    }

    notifyListeners();
  }


}
