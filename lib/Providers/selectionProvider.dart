import 'package:flutter/material.dart';

class SelectionProvider extends ChangeNotifier {
  bool? _isMyselfSelected;

  bool? get isMyselfSelected => _isMyselfSelected;

  set isMyselfSelected(bool? value) {
    _isMyselfSelected = value;
    notifyListeners();
  }
}
