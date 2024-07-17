import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

///Class used to restore the apps state when the user switches to another app or from the app
class AppStateObserver extends WidgetsBindingObserver with ChangeNotifier {
  final storage = const FlutterSecureStorage();
  var myVariable;
  var jsonString;

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);

    if (state == AppLifecycleState.resumed) {
      // App resumed from the background
      // Restore the app state as needed

      // Retrieve saved state from flutter secure storage
      final savedState = _retrieveAppStateFromPreferences();

      //  Update the UI with the restored state
      if (savedState != null) {
        // setState(() {
        // Update your app's state variables with the restored state
        myVariable = savedState.toString();
        notifyListeners();
        // });
      }
    } else if (state == AppLifecycleState.paused) {
      // App moved to the background
      // Save the app state as needed

      // Prepare the app state to be saved
      final currentState = _getCurrentAppState();

      // Save the state to shared preferences
      _saveAppStateToPreferences(currentState);
    }
  }

  // methods for saving and retrieving app state from shared preferences
  void _saveAppStateToPreferences(Map<String, dynamic> state) {
    // Save the state to flutter secure storage or any other persistence mechanism
    final jsonStrings = json.encode(state);
    storage.write(key: 'appState', value: jsonStrings);
  }

  Future<Map<String, dynamic>?> _retrieveAppStateFromPreferences() async {
    // Retrieve the state from flutter secure storage or any other persistence mechanism
    await _loadKey();

    if (jsonString != null) {
      return json.decode(jsonString);
    }
    return null;
  }

  // method for getting the current app state
  Map<String, dynamic> _getCurrentAppState() {
    // Retrieve the current state of your app
    // and return it as a map

    return {
      'myVariable': 'currentValue',
    };
  }

  _readStateKey() async {
    jsonString = await storage.read(key: 'appState');
    notifyListeners();
    var string = jsonString;
    notifyListeners();
    return string;
  }

  _loadKey() async {
    await _readStateKey();
  }
}
