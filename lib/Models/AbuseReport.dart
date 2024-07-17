class AbuseReport {
  final String abuseType;
  final int count;

  AbuseReport({required this.abuseType, required this.count});

  factory AbuseReport.fromJson(Map<String, dynamic> json) {
    return AbuseReport(
      abuseType: json['abuse_type'],
      count: json['count'],
    );
  }
}
