import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart' as http;
import '../Models/PolicePost.dart';
import '../Models/ReportLocation.dart';
import '../resources/constants.dart';

class LocationProvider with ChangeNotifier {
  List<ReportLocation> _reportLocations = [];
  List<PolicePost> _policePosts = [];
  bool _showReports = true;

  List<ReportLocation> get reportLocations => _reportLocations;

  List<PolicePost> get policePosts => _policePosts;

  bool get showReports => _showReports;

  Future<void> fetchReportLocations() async {
    final response =
        await http.get(Uri.parse('$baseUrl/statistics/per/location'));
    final Map<String, dynamic> responseData = json.decode(response.body);

    _reportLocations = responseData.entries.map((entry) {
      return ReportLocation.fromJson(entry.key, entry.value);
    }).toList();

    notifyListeners();
  }

  Future<void> fetchPolicePosts() async {
    final response =
        await http.get(Uri.parse('$baseUrl/statistics/police-locations'));
    final Map<String, dynamic> responseData = json.decode(response.body);

    List<PolicePost> tempPosts = [];
    responseData.forEach((key, value) {
      if (value is List) {
        tempPosts.addAll(
            PolicePost.fromJsonList(key, value) as Iterable<PolicePost>);
      } else {
        tempPosts.add(PolicePost.fromJson(key, value));
      }
    });
    _policePosts = tempPosts;
    notifyListeners();
  }

  void toggleMarkers(bool showReports) {
    _showReports = showReports;
    notifyListeners();
  }

  List<WeightedLatLng> getHeatmapData() {
    List<WeightedLatLng> heatmapData = [];
    for (ReportLocation location in _reportLocations) {
      heatmapData.add(WeightedLatLng(
        point: LatLng(location.latitude, location.longitude),
        intensity: location.cases.toDouble(),
        numReports: location.cases,
      ));
    }
    return heatmapData;
  }
}

class WeightedLatLng {
  final LatLng point;
  final double intensity;
  final int numReports;

  WeightedLatLng(
      {required this.point, required this.intensity, required this.numReports});
}
