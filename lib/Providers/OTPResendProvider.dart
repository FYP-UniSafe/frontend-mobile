import 'package:flutter/material.dart';

class OTPResendProvider extends ChangeNotifier {
  TextEditingController emailController = TextEditingController();
  bool isLoading = false;

  void setIsLoading(bool value) {
    isLoading = value;
    notifyListeners();
  }
}
