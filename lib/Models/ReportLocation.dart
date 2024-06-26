class ReportLocation {
  final String name;
  final double latitude;
  final double longitude;
  final int cases;

  ReportLocation({
    required this.name,
    required this.latitude,
    required this.longitude,
    required this.cases,
  });

  factory ReportLocation.fromJson(String name, Map<String, dynamic> json) {
    return ReportLocation(
      name: name,
      latitude: json['center']['lat'].toDouble(),
      longitude: json['center']['lng'].toDouble(),
      cases: json['cases'],
    );
  }
}
