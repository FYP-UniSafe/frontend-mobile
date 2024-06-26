import 'dart:convert';
import 'dart:developer';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:unisafe/Providers/authProvider.dart';
import 'package:unisafe/Services/storage.dart';

import '../Models/AbuseReport.dart';
import '../Models/Report.dart';
import '../Models/ReportDataPerYear.dart';
import '../resources/constants.dart';

class ReportProvider extends ChangeNotifier {
  bool? _isReported;

  bool? get isReported => _isReported;
  List<Report> _reports = [];
  List<Report> _anonymousReports = [];

  List<Report> get reports => _reports;
  List<Report> get anonymousReports => _anonymousReports;
  List<AbuseReport> _abuses = [];

  List<AbuseReport> get abuses => _abuses;

  List<ReportDataPerYear> _reportsPerYear = [];

  List<ReportDataPerYear> get reportsPerYear => _reportsPerYear;

  Future createReport({required Report report}) async {
    log(report.toJsonReportData().toString());
    String? token = await LocalStorage.getToken();
    try {
      var uri = Uri.parse('$baseUrl/reports/create');
      var request = http.MultipartRequest('POST', uri);
      for (var element in report.evidence!) {
        var file =
            await http.MultipartFile.fromPath('evidence[]', element.path);
        request.files.add(file);
      }

      report.toJsonReportData().forEach((key, value) {
        request.fields[key] = value;
      });

      request.headers['Content-Type'] = 'application/json';
      request.headers['Accept'] = 'application/json';
      request.headers['Authorization'] = 'Bearer $token';
      final response = await request.send();

      String responseBody = await response.stream.bytesToString();

      if (response.statusCode == 200 || response.statusCode == 201) {
        var output = jsonDecode(responseBody);
        if (kDebugMode) {
          print('File uploaded successfully');
        }
        await getReports();
        _isReported = true;
        notifyListeners();
      } else if (response.statusCode == 401) {
        log(responseBody);
        AuthProvider.refreshToken();
        await createReport(report: report);
      } else {
        log(responseBody);
        _isReported = false;
        notifyListeners();
        if (kDebugMode) {
          print(response.statusCode);
          log(responseBody);
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

  Future createAnonymousReport({required Report report}) async {
    log(report.toJsonAnonymousReportData().toString());
    try {
      var uri = Uri.parse('$baseUrl/reports/anonymous/create');
      var request = http.MultipartRequest('POST', uri);
      for (var element in report.evidence!) {
        var file =
            await http.MultipartFile.fromPath('attachment[]', element.path);
        request.files.add(file);
      }

      report.toJsonAnonymousReportData().forEach((key, value) {
        request.fields[key] = value;
      });

      request.headers['Content-Type'] = 'application/json';
      request.headers['Accept'] = 'application/json';

      final response = await request.send();

      String responseBody = await response.stream.bytesToString();

      if (response.statusCode == 200 || response.statusCode == 201) {
        var output = jsonDecode(responseBody);
        if (kDebugMode) {
          print('File uploaded successfully');
        }

        _isReported = true;
        notifyListeners();
      } else {
        log(responseBody);
        _isReported = false;
        notifyListeners();
        if (kDebugMode) {
          print(response.statusCode);
          log(responseBody);
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
          await http.get(Uri.parse("$baseUrl/reports/list/created"), headers: {
        "Content-Type": "application/json",
        "Accept": "application/json",
        "Authorization": "Bearer $token",
      });

      if (response.statusCode == 200) {
        List output = jsonDecode(response.body);
        _reports = output.map((data) => Report.fromJson(data)).toList();
        _reports.sort();

        notifyListeners();
      } else if (response.statusCode == 401) {
        AuthProvider.refreshToken();
        await getReports();
      } else {
        _reports = [];
        notifyListeners();
      }
    } catch (e) {
      _reports = [];
      notifyListeners();
    }
  }

  Future<void> fetchReports() async {
    String? token = await LocalStorage.getToken();
    final url = '$baseUrl/reports/list';
    try {
      final response = await http
          .get(Uri.parse(url), headers: {"Authorization": "Bearer $token"});
      if (response.statusCode == 200) {
        final List<dynamic> reportData = json.decode(response.body);
        _reports = reportData.map((data) => Report.fromJson(data)).toList();
        notifyListeners();
      } else if (response.statusCode == 401) {
        AuthProvider.refreshToken();
        await fetchReports();
      } else {
        throw Exception('Failed to load reports');
      }
    } catch (error) {
      throw error;
    }
  }

  Future<void> fetchAnonymousReports() async {
    final url = '$baseUrl/reports/anonymous/list';
    try {
      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        final List<dynamic> anonymousReportData = json.decode(response.body);

        _anonymousReports =
            anonymousReportData.map((data) => Report.fromJson(data)).toList();

        notifyListeners();
      } else if (response.statusCode == 401) {
        AuthProvider.refreshToken();
        await fetchReports();
      } else {
        throw Exception('Failed to load anonymous reports');
      }
    } catch (error) {
      throw error;
    }
  }

  Future<void> fetchAbuses() async {
    final response =
        await http.get(Uri.parse('$baseUrl/statistics/per/abusetype'));
    if (response.statusCode == 200) {
      List<dynamic> data = json.decode(response.body);
      _abuses = data.map((item) => AbuseReport.fromJson(item)).toList();
      notifyListeners();
    } else if (response.statusCode == 401) {
      AuthProvider.refreshToken();
      await fetchReports();
    } else {
      throw Exception('Failed to load reports');
    }
  }

  Future<void> fetchReportsPerYear() async {
    final response = await http.get(Uri.parse('$baseUrl/statistics/per/year'));
    if (response.statusCode == 200) {
      final List data = json.decode(response.body);

      _reportsPerYear =
          data.map((item) => ReportDataPerYear.fromJson(item)).toList();

      notifyListeners();
    } else if (response.statusCode == 401) {
      AuthProvider.refreshToken();
      await fetchReports();
    } else {
      throw Exception('Failed to load reports');
    }
  }

  Future<void> getGenderDeskReports() async {
    await Future.wait([
      fetchReportsPerYear(),
      fetchAbuses(),
      fetchAnonymousReports(),
      fetchReports()
    ]);
  }
}
