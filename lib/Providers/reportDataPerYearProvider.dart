import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import '../Models/ReportDataPerYear.dart';
import '../resources/constants.dart';

class ReportDataPerYearProvider with ChangeNotifier {
  List<ReportDataPerYear> _reports = [];

  List<ReportDataPerYear> get reports => _reports;

  Future<void> fetchReports() async {
    final response = await http.get(Uri.parse('$baseUrl/statistics/per/year'));
    if (response.statusCode == 200) {
      final List data = json.decode(response.body);

      _reports = data.map((item) => ReportDataPerYear.fromJson(item)).toList();

      notifyListeners();
    } else {
      throw Exception('Failed to load reports');
    }
  }
}
