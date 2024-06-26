class ReportDataPerYear {
  final String year;
  final int count;

  ReportDataPerYear({
    required this.year,
    required this.count,
  });

  factory ReportDataPerYear.fromJson(Map<String, dynamic> json) {
    return ReportDataPerYear(
      year: json['year'],
      count: json['count'],
    );
  }
}
