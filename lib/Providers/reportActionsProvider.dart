import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../resources/constants.dart';

class ReportActionsProvider with ChangeNotifier {
  bool _isLoading = false;
  String? _errorMessage;

  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;

  Future<void> handleReportAction(String action, String reportId) async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    final url = '$baseUrl/reports/$action';
    final response = await http.post(
      Uri.parse(url),
      headers: {'Content-Type': 'application/json'},
      body: '{"report_id": "$reportId"}',
    );

    if (response.statusCode == 200) {
      // Handle success response
      _isLoading = false;
      notifyListeners();
    } else {
      // Handle error response
      _isLoading = false;
      _errorMessage = 'Failed to $action report';
      notifyListeners();
    }
  }
}
