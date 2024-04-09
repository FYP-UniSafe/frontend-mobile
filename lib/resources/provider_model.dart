import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProfileTypeProvider extends ChangeNotifier {
  String selectedProfileType = '';
  String selectedCollege = '';
  String staffID = '';
  String registrationNumber = '';
  String policeID = '';
  String station = '';

  void setSelectedProfileType(String profileType) {
    selectedProfileType = profileType;
    notifyListeners();
  }

  void setSelectedCollege(String college) {
    selectedCollege = college;
    notifyListeners();
  }

  void setStaffID(String id) {
    staffID = id;
    notifyListeners();
  }

  void setRegistrationNumber(String number) {
    registrationNumber = number;
    notifyListeners();
  }

  void setPoliceID(String id) {
    policeID = id;
    notifyListeners();
  }

  void setStation(String stationName) {
    station = stationName;
    notifyListeners();
  }
}
