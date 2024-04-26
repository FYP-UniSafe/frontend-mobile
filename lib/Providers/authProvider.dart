import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:unisafe/Services/storage.dart';
import 'package:unisafe/resources/constants.dart';

import '../Models/User.dart';

class AuthProvider extends ChangeNotifier {
  bool? _isChanged;

  bool? get isChanged => _isChanged;

  bool? _isLoggedIn;

  bool? get isLoggedIn => _isLoggedIn;

  bool? _otpVerifed;

  bool? get otpVerifed => _otpVerifed;

  bool? _otpSent;

  bool? get otpSent => _otpSent;
  User? _currentUser;

  set currentUser(User? value) {
    _currentUser = value;
  }

  User? get currentUser => _currentUser;

  bool _isLoading = false;

  bool get isLoading => _isLoading;

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
          _currentUser = User.fromLoginJson(output);
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
        log(response.body);
        throw HttpException('${response.statusCode}: ${response.reasonPhrase}',
            uri: Uri.parse('$baseUrl/users/login'));
      }
    } catch (e) {
      log('Error is ${e.toString()}');
    }
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
          _currentUser!.password = user.password;
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
        if (kDebugMode) {
          log(response.body);
        }

        throw HttpException('${response.statusCode}: ${response.reasonPhrase}',
            uri: Uri.parse('$baseUrl/users/login'));
      }
    } catch (e) {}
  }

  Future verifyOtp({required User user}) async {
    try {
      http.Response response = await http.post(
          Uri.parse('$baseUrl/users/otp/verify'),
          headers: {
            'Accept': 'application/json',
            'Content-Type': 'application/json'
          },
          body: json.encode(user.toOtpJson()));

      if (response.statusCode == 200 || response.statusCode == 201) {
        Map<String, dynamic> output = jsonDecode(response.body);
        if (kDebugMode) {
          log(output.toString());
        }
        await login(user: _currentUser!);
        _otpVerifed = true;
        notifyListeners();
      } else {
        _otpVerifed = false;
        throw HttpException('${response.statusCode}: ${response.reasonPhrase}',
            uri: Uri.parse('$baseUrl/users/login'));
      }
    } catch (e) {
      _otpVerifed = false;
      notifyListeners();
    }
  }

  Future resetPassword({required User user}) async {
    try {
      http.Response response = await http.post(
          Uri.parse('$baseUrl/users/password/reset'),
          headers: {
            'Accept': 'application/json',
            'Content-Type': 'application/json'
          },
          body: json.encode(user.toResetJson()));
      log(response.body);
      if (response.statusCode == 200 || response.statusCode == 201) {
        Map<String, dynamic> output = jsonDecode(response.body);
        if (kDebugMode) {
          log(output.toString());
        }
        _otpVerifed = true;
        notifyListeners();
      } else {
        _otpVerifed = false;
        throw HttpException('${response.statusCode}: ${response.reasonPhrase}',
            uri: Uri.parse('$baseUrl/users/password/reset'));
      }
    } catch (e) {
      _otpVerifed = false;
      notifyListeners();
    }
  }

  Future forgotPassword({required String email}) async {
    try {
      http.Response response = await http.post(
          Uri.parse('$baseUrl/users/password/forgot'),
          headers: {
            'Accept': 'application/json',
            'Content-Type': 'application/json'
          },
          body: json.encode({"email": email}));
      log('Response is ${response.statusCode.toString()}');

      if (response.statusCode == 200 || response.statusCode == 201) {
        Map<String, dynamic> output = jsonDecode(response.body);
        if (kDebugMode) {
          log(output.toString());
        }
        _otpSent = true;
        notifyListeners();
      } else {
        _otpSent = false;
        throw HttpException('${response.statusCode}: ${response.reasonPhrase}',
            uri: Uri.parse('$baseUrl/users/password/forgot'));
      }
    } catch (e) {
      log('Error is ${e.toString()}');
      _otpSent = false;
      notifyListeners();
    }
  }

  Future<void> resendOTP() async {
    final Uri apiUrl = Uri.parse('$baseUrl/users/otp/resend');
    final Map<String, dynamic> requestData = {
      'email': _currentUser!.email,
    };

    try {
      final http.Response response = await http.post(
        apiUrl,
        body: json.encode(requestData),
        headers: {'Content-Type': 'application/json'},
      );

      if (response.statusCode == 200) {
        _otpSent = true;
        notifyListeners();
        print('OTP Resent Successfully');
      } else {
        _otpSent = false;
        notifyListeners();
        print('Failed to Resend OTP');
      }
    } catch (e) {
      _otpSent = false;
      notifyListeners();
      print('Error: $e');
    }
  }

  Future<void> changePassword(
      {required String? old_password, required String? new_password}) async {
    String? token = await LocalStorage.getToken();
    try {
      final http.Response response = await http.post(
        Uri.parse('$baseUrl/users/password/change'),
        headers: {
          'Accept': 'application/json',
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token'
        },
        body: json.encode({
          'old_password': old_password,
          'new_password': new_password,
        }),
      );

      if (response.statusCode == 200) {
        Map<String, dynamic> output = jsonDecode(response.body);

        try {
          await LocalStorage.logout();
          _isChanged = true;
          notifyListeners();
        } catch (e) {
          print(e.toString());
          _isChanged = false;
          notifyListeners();
        }
        notifyListeners();
        print('Password changed successfully');
      } else {
        _isChanged = false;
        notifyListeners();
        print('Password change failed: ${response.body}');
      }
    } catch (e) {
      _isChanged = false;
      notifyListeners();
      print('Error changing password: $e');
    }
  }
}
