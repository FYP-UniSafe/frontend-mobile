import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../Models/Report.dart';
import '../resources/constants.dart';

class ReportProvider extends ChangeNotifier {
  Future createReport({required Report report}) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/reports/create'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: json.encode(report.toJsonReportData()),
      );

      if (response.statusCode == 200) {
        print('Report created successfully');
      } else {
        print('Failed to create report. Status code: ${response.statusCode}');
      }
    } catch (e) {
      print('Error creating report: $e');
    }
  }
}
