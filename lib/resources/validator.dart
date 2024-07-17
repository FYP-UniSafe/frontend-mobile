import 'package:email_validator/email_validator.dart';

class TextFormValidators {
  static String? passwordValidator(String password) {
    RegExp passwordPattern = RegExp(
        r"^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[@$!%?&])[A-Za-z\d@$!%?&]{8,}$");
    if (!passwordPattern.hasMatch(password)) {
      return 'At least one uppercase, one digit and one special character is required';
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
    RegExp phoneNumberPattern1 = RegExp(r'^\d{10,}$');
    RegExp phoneNumberPattern = RegExp(r'^\+\d{1,3}\d{9,}$');
    if (phone.isEmpty) {
      return 'Phone Number is required';
    } else if (!phoneNumberPattern.hasMatch(phone)&&!phoneNumberPattern1.hasMatch(phone)){
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
