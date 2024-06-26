import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import '../Models/AbuseReport.dart';
import '../resources/constants.dart';

class AbuseReportProvider with ChangeNotifier {
  List<AbuseReport> _reports = [];

  List<AbuseReport> get reports => _reports;

  Future<void> fetchReports() async {
    final response =
        await http.get(Uri.parse('$baseUrl/statistics/per/abusetype'));
    if (response.statusCode == 200) {
      List<dynamic> data = json.decode(response.body);
      _reports = data.map((item) => AbuseReport.fromJson(item)).toList();
      notifyListeners();
    } else {
      throw Exception('Failed to load reports');
    }
  }
}
