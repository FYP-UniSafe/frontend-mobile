import 'package:email_validator/email_validator.dart';

class TextFormValidators {
  static String? passwordValidator(String password) {
    if (password.isEmpty) {
      return "Password can't be empty";
    }
    return null;
  }

  static String? emailValidator(String email) {
    if (email.isEmpty) {
      return 'Email is required';
    } else {
      if (EmailValidator.validate(email)) {
        return null;
      } else {
        return 'Invalid email';
      }
    }
  }

  static String? phoneValidator(String phone) {
    RegExp phoneNumberPattern = RegExp(r'^\d{10,}$');
    if (phone.isEmpty) {
      return 'Phone Number is required';
    } else if (!phoneNumberPattern.hasMatch(phone)) {
      return 'At least 10 digits required';
    }
    return null;
  }

  static String? textFieldValidator(String? text) {
    if (text!.isEmpty) {
      return "Field can't be empty";
    }
    return null;
  }

  static String? studentIDValidator(String? text) {
    RegExp studentIdPattern = RegExp(r'^\d{4}-\d{2}-\d{5}$');
    if (text!.isEmpty) {
      return "Field can't be empty";
    } else if (!studentIdPattern.hasMatch(text)) {
      return 'Invalid Student ID';
    }
    return null;
  }

  static String? staffIDValidator(String? text) {
    RegExp studentIdPattern = RegExp(r'^\d{4}-\d{2}-\d{5}$');
    if (text!.isEmpty) {
      return "Field can't be empty";
    } else if (!studentIdPattern.hasMatch(text)) {
      return 'Invalid Staff ID';
    }
    return null;
  }

  static String? chooseItems(String? item) {
    if (item == null) {
      return 'Choose an Item from the list';
    }
    return null;
  }
}
