import 'dart:convert';
import 'dart:developer';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:unisafe/Services/storage.dart';

import '../Models/Report.dart';
import '../resources/constants.dart';

class ReportProvider extends ChangeNotifier {
  bool? _isReported;

  bool? get isReported => _isReported;
  List<Report> _reports = [];

  List<Report> get reports => _reports;

  Future createReport({required Report report}) async {
    log(report.toJsonReportData().toString());
    String? token = await LocalStorage.getToken();
    try {
      var uri = Uri.parse(
          '$baseUrl/reports/create'); // Replace with your Laravel API endpoint
      var request = http.MultipartRequest('POST', uri);

      report.evidence!.forEach((element) async {
        var file =
            await http.MultipartFile.fromPath('attachment[]', element.path);
        request.files.add(file);
      });

      report.toJsonReportData().forEach((key, value) {
        request.fields[key] = value;
      });

      request.headers['Content-Type'] = 'application/json';
      request.headers['Accept'] = 'application/json';
      request.headers['Authorization'] = 'Bearer $token';

      final response = await request.send();
      log(response.statusCode.toString());
      String responseBody = await response.stream.bytesToString();
      log(responseBody);
      if (response.statusCode == 200 || response.statusCode == 201) {

        var output = jsonDecode(responseBody);
        if (kDebugMode) {
          print('File uploaded successfully');
        }
        _isReported = true;
        notifyListeners();
      } else {
        _isReported = false;
        notifyListeners();
        if (kDebugMode) {
          print(response.statusCode);
          print('File upload failed');
        }
      }
    } catch (e) {
      _isReported = false;
      notifyListeners();
      if (kDebugMode) {
        print(e.toString());
      }
    }
  }

  Future getReports() async {
    String? token = await LocalStorage.getToken();
    try {
      http.Response response =
          await http.get(Uri.parse("$baseUrl/reports"), headers: {
        "Content-Type": "application/json",
        "Accept": "application/json",
        "Authorization": "Bearer $token",
      });

      if (response.statusCode == 200) {
        Map output = jsonDecode(response.body);
      }
    } catch (e) {}
  }
}
