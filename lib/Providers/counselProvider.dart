import 'dart:convert';
import 'dart:developer';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../Models/Counsel.dart';
import '../Services/storage.dart';
import '../resources/constants.dart';
import 'authProvider.dart';

class CounselProvider extends ChangeNotifier {
  bool? _isRequested;

  bool? get isRequested => _isRequested;
  List<Counsel> _appointments = [];

  List<Counsel> get appointments => _appointments;

  // Future requestAppointment({required Counsel appointment}) async {
  //   log(appointment.toJsonCounselData().toString());
  //   String? token = await LocalStorage.getToken();
  //   try {
  //     var uri = Uri.parse('$baseUrl/appointments/create');
  //     var request = http.MultipartRequest('POST', uri);
  //
  //     appointment.toJsonCounselData().forEach((key, value) {
  //       request.fields[key] = value;
  //     });
  //
  //     request.headers['Content-Type'] = 'application/json';
  //     request.headers['Accept'] = 'application/json';
  //     request.headers['Authorization'] = 'Bearer $token';
  //     final response = await request.send();
  //
  //     String responseBody = await response.stream.bytesToString();
  //     log('Response body: $responseBody');
  //
  //     if (response.statusCode == 200 || response.statusCode == 201) {
  //       var output = jsonDecode(responseBody);
  //       if (kDebugMode) {
  //         print('Appointment requested successfully');
  //       }
  //       await getAppointments();
  //       _isRequested = true;
  //       notifyListeners();
  //     } else if (response.statusCode == 401) {
  //       log(responseBody);
  //       AuthProvider.refreshToken();
  //       await requestAppointment(appointment: appointment);
  //     } else {
  //       log(responseBody);
  //       _isRequested = false;
  //       notifyListeners();
  //       if (kDebugMode) {
  //         print(response.statusCode);
  //         log(responseBody);
  //         print('Appointment request failed');
  //       }
  //     }
  //   } catch (e) {
  //     _isRequested = false;
  //     notifyListeners();
  //     if (kDebugMode) {
  //       print(e.toString());
  //     }
  //   }
  // }
  Future requestAppointment({required Counsel appointment}) async {
    String? token = await LocalStorage.getToken();
    try {
      var uri = Uri.parse('$baseUrl/appointments/create');
      var response = await http.post(uri,
          headers: {
            "Accept": "application/json",
            "Authorization": "Bearer $token"
          },
          body: appointment.toJsonCounselData());
      var responseBody = response.body;
      // log("Response body: $responseBody");

      if (response.statusCode == 200 || response.statusCode == 201) {
        var output = jsonDecode(responseBody);
        if (kDebugMode) {
          print('Appointment requested successfully');
        }
        await getAppointments();
        _isRequested = true;
        notifyListeners();
      } else if (response.statusCode == 401) {
        log(responseBody);
        AuthProvider.refreshToken();
        await requestAppointment(appointment: appointment);
      } else {
        log(responseBody);
        _isRequested = false;
        notifyListeners();
        if (kDebugMode) {
          print(response.statusCode);
          log(responseBody);
          print('Appointment request failed');
        }
      }
    } catch (e) {
      _isRequested = false;
      notifyListeners();
      if (kDebugMode) {
        print(e.toString());
      }
    }
  }

  Future getAppointments() async {
    String? token = await LocalStorage.getToken();
    try {
      http.Response response = await http
          .get(Uri.parse("$baseUrl/appointments/list/requested"), headers: {
        "Content-Type": "application/json",
        "Accept": "application/json",
        "Authorization": "Bearer $token",
      });

      if (response.statusCode == 200) {
        List output = jsonDecode(response.body);
        _appointments = output.map((data) => Counsel.fromJson(data)).toList();
        _appointments.sort;

        notifyListeners();
      } else if (response.statusCode == 401) {
        AuthProvider.refreshToken();
        await getAppointments();
      } else {
        _appointments = [];
        notifyListeners();
      }
    } catch (e) {
      _appointments = [];
      notifyListeners();
    }
  }
}
