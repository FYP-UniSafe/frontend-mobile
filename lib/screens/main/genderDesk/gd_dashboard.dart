import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:unisafe/Models/ReportDataPerYear.dart';
import 'package:unisafe/resources/formats.dart';
import 'package:unisafe/screens/main/genderDesk/report_actions.dart';

import '../../../Models/AbuseReport.dart';
import '../../../Models/Report.dart';
import '../../../Providers/abuseReportProvider.dart';
import '../../../Providers/reportProvider.dart';
import '../../../Providers/reportDataPerYearProvider.dart';
import '../../../Services/stateObserver.dart';

class GDDashboard extends StatefulWidget {
  const GDDashboard({super.key});

  @override
  State<GDDashboard> createState() => _GDDashboardState();
}

class _GDDashboardState extends State<GDDashboard> {
  final _appStateObserver = AppStateObserver();
  int? touchedIndex;

  List<Report> _reports = [];
  List<Report> _anonymousReports = [];
  List<ReportDataPerYear> _perYear = [];

  List<AbuseReport> _abuses = [];
  late ReportProvider _reportProvider;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _reportProvider = Provider.of<ReportProvider>(context);

    _abuses = _reportProvider.abuses;
    _perYear = _reportProvider.reportsPerYear;
    _reports = _reportProvider.reports;
    _anonymousReports = _reportProvider.anonymousReports;
  }

  @override
  void initState() {
    WidgetsBinding.instance.addObserver(_appStateObserver);
    super.initState();
    Future.microtask(() => Provider.of<ReportProvider>(context, listen: false)
        .getGenderDeskReports());
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(_appStateObserver);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Map<String, List<Report>> groupedReports = {};
    Map<String, List<Report>> groupedAnonymousReports = {};

    _reports.forEach((report) {
      String status =
          report.status.toString().capitalizeFirstLetterOfEachWord();
      if (!groupedReports.containsKey(status)) {
        groupedReports[status] = [];
      }
      groupedReports[status]!.add(report);
    });

    _anonymousReports.forEach((report) {
      String status =
          report.status.toString().capitalizeFirstLetterOfEachWord();
      if (!groupedAnonymousReports.containsKey(status)) {
        groupedAnonymousReports[status] = [];
      }
      groupedAnonymousReports[status]!.add(report);
    });
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.only(left: 16.0, right: 16.0),
        child: SizedBox(
          height: MediaQuery.of(context).size.height * 0.99,
          child: RefreshIndicator(
            onRefresh: _reportProvider.getGenderDeskReports,
            color: Color.fromRGBO(8, 100, 175, 1),
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    'REPORTS',
                    style: TextStyle(fontSize: 18.0),
                  ),
                  Divider(
                    height: 30.0,
                    color: Color.fromRGBO(8, 100, 175, 1.0),
                  ),
                  Text(
                    'All Reports',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  groupedReports.isEmpty
                      ? _buildNoReportsView()
                      : Column(
                          children: groupedReports.entries.map((entry) {
                            String status = entry.key;
                            List<Report> reports = entry.value;
                            return Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(height: 10),
                                Text(
                                  status,
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Column(
                                  children: reports
                                      .map((report) =>
                                          _reportsTile(report: report))
                                      .toList(),
                                ),
                              ],
                            );
                          }).toList(),
                        ),
                  SizedBox(height: 20),
                  Text(
                    'Anonymous Reports',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  groupedAnonymousReports.isEmpty
                      ? _buildNoReportsView()
                      : Column(
                          // Display grouped anonymous reports
                          children:
                              groupedAnonymousReports.entries.map((entry) {
                            String status = entry.key;
                            List<Report> reports = entry.value;
                            return Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(height: 10),
                                Text(
                                  status,
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Column(
                                  children: reports
                                      .map((report) =>
                                          _reportsTile(report: report))
                                      .toList(),
                                ),
                              ],
                            );
                          }).toList(),
                        ),
                  SizedBox(
                    height: 20,
                  ),
                  Text(
                    'STATISTICS',
                    style: TextStyle(fontSize: 18.0),
                  ),
                  Divider(
                    height: 30.0,
                    color: Color.fromRGBO(8, 100, 175, 1.0),
                  ),
                  Text(
                    'Reports per Year of Study',
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 16,
                        fontWeight: FontWeight.bold),
                  ),
                  if (_perYear.isEmpty)
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.45,
                      child: Padding(
                        padding: EdgeInsets.all(8.0),
                        child: BarChart(
                          BarChartData(
                            barGroups: _getEmptyBarGroups(),
                            titlesData: FlTitlesData(
                              leftTitles: AxisTitles(
                                sideTitles: SideTitles(showTitles: false),
                              ),
                              bottomTitles: AxisTitles(
                                sideTitles: SideTitles(showTitles: false),
                              ),
                              topTitles: AxisTitles(
                                sideTitles: SideTitles(showTitles: false),
                              ),
                              rightTitles: AxisTitles(
                                sideTitles: SideTitles(showTitles: false),
                              ),
                            ),
                            borderData: FlBorderData(show: false),
                            gridData: FlGridData(show: false),
                            backgroundColor: Colors.grey[300],
                          ),
                        ),
                      ),
                    ),
                  if (_perYear.isNotEmpty)
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.45,
                      child: Padding(
                        padding: EdgeInsets.all(8.0),
                        child: BarChart(
                          BarChartData(
                            barGroups: _perYear.asMap().entries.map((entry) {
                              int index = entry.key;
                              ReportDataPerYear data = entry.value;
                              return BarChartGroupData(
                                x: index,
                                barRods: [
                                  BarChartRodData(
                                    toY: data.count.toDouble(),
                                    color: Color.fromRGBO(8, 100, 175, 1.0),
                                    width: 20,
                                    borderRadius: BorderRadius.circular(0),
                                    rodStackItems: [
                                      BarChartRodStackItem(
                                        0,
                                        data.count.toDouble() * 0.5,
                                        Color.fromRGBO(8, 100, 175, 1.0),
                                      ),
                                      BarChartRodStackItem(
                                        data.count.toDouble() * 0.5,
                                        data.count.toDouble(),
                                        Color.fromRGBO(8, 100, 175, 0.5),
                                      ),
                                    ],
                                    backDrawRodData: BackgroundBarChartRodData(
                                      show: true,
                                      toY: data.count.toDouble(),
                                      color: Colors.grey.withOpacity(
                                          0.2), // Background bar color
                                    ),
                                  ),
                                ],
                              );
                            }).toList(),
                            titlesData: FlTitlesData(
                              leftTitles: AxisTitles(
                                sideTitles: SideTitles(
                                  showTitles: true,
                                  interval: 1,
                                  getTitlesWidget:
                                      (double value, TitleMeta meta) {
                                    if (value % 1 == 0) {
                                      return Text(
                                        value.toInt().toString(),
                                        style: TextStyle(color: Colors.black),
                                      );
                                    }
                                    return Container();
                                  },
                                ),
                              ),
                              rightTitles: AxisTitles(
                                sideTitles: SideTitles(showTitles: false),
                              ),
                              bottomTitles: AxisTitles(
                                sideTitles: SideTitles(
                                  showTitles: true,
                                  interval: 2,
                                  getTitlesWidget:
                                      (double value, TitleMeta meta) {
                                    int index = value.toInt();
                                    if (index % 2 == 0 &&
                                        index >= 0 &&
                                        index < _perYear.length) {
                                      return Text(
                                        _perYear[index].year,
                                        style: TextStyle(color: Colors.black),
                                      );
                                    }
                                    return Container();
                                  },
                                ),
                              ),
                              topTitles: AxisTitles(
                                sideTitles: SideTitles(showTitles: false),
                              ),
                            ),
                            gridData: FlGridData(
                              show: true,
                              drawHorizontalLine: true,
                              drawVerticalLine: false,
                              getDrawingHorizontalLine: (value) {
                                return FlLine(
                                  color: Colors.blue,
                                  strokeWidth: 1,
                                  dashArray: [8, 8],
                                );
                              },
                            ),
                            backgroundColor: Colors.grey[350],
                            extraLinesData: ExtraLinesData(horizontalLines: []),
                          ),
                        ),
                      ),
                    ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    'Reports per GBV Type',
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 16,
                        fontWeight: FontWeight.bold),
                  ),
                  if (_abuses.isEmpty)
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.45,
                      child: Padding(
                        padding: EdgeInsets.all(16.0),
                        child: PieChart(
                          PieChartData(
                            sections: _getEmptySections(),
                            startDegreeOffset: 0,
                            sectionsSpace: 2,
                            pieTouchData: PieTouchData(
                              touchCallback:
                                  (FlTouchEvent event, pieTouchResponse) {},
                            ),
                          ),
                          swapAnimationDuration: Duration(milliseconds: 800),
                          swapAnimationCurve: Curves.easeInOut,
                        ),
                      ),
                    ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.45,
                    child: Padding(
                      padding: EdgeInsets.all(16.0),
                      child: PieChart(
                        PieChartData(
                          sections: _getSections(_abuses),
                          startDegreeOffset: 20,
                          sectionsSpace: 2,
                          pieTouchData: PieTouchData(
                            touchCallback:
                                (FlTouchEvent event, pieTouchResponse) {
                              setState(() {
                                if (!event.isInterestedForInteractions ||
                                    pieTouchResponse == null ||
                                    pieTouchResponse.touchedSection == null) {
                                  touchedIndex = -1;
                                  return;
                                }
                                final newIndex = pieTouchResponse
                                    .touchedSection!.touchedSectionIndex;
                                touchedIndex =
                                    touchedIndex == newIndex ? -1 : newIndex;
                              });
                            },
                          ),
                        ),
                        swapAnimationDuration: Duration(milliseconds: 800),
                        swapAnimationCurve: Curves.easeInOut,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  List<PieChartSectionData> _getSections(List<AbuseReport> reports) {
    int total = reports.fold(0, (sum, item) => sum + item.count);

    return reports.asMap().entries.map((entry) {
      int index = entry.key;
      AbuseReport report = entry.value;
      double percentage = (report.count / total) * 100;
      bool isTouched = index == touchedIndex;
      return PieChartSectionData(
        value: percentage,
        title: isTouched
            ? '${percentage.toStringAsFixed(1)}%'
            : '${report.abuseType}\n${percentage.toStringAsFixed(1)}%',
        color: _getColor(report.abuseType),
        radius: isTouched
            ? MediaQuery.of(context).size.width * 0.4
            : MediaQuery.of(context).size.width * 0.35,
        titleStyle: TextStyle(
          fontSize: isTouched ? 18 : 16,
          color: Colors.white,
        ),
      );
    }).toList();
  }

  List<BarChartGroupData> _getEmptyBarGroups() {
    return [
      BarChartGroupData(
        x: 0,
        barRods: [
          BarChartRodData(
            toY: 0,
            color: Colors.grey,
            width: 20,
            backDrawRodData: BackgroundBarChartRodData(
              show: true,
              toY: 1,
              color: Colors.grey.withOpacity(0.2),
            ),
          ),
        ],
      ),
    ];
  }

  List<PieChartSectionData> _getEmptySections() {
    return [
      PieChartSectionData(
        value: 1,
        title: 'No Data',
        color: Colors.grey[300],
        radius: 100,
        titleStyle: TextStyle(
          fontSize: 18,
          color: Colors.black,
        ),
      ),
    ];
  }

  Color _getColor(String abuseType) {
    switch (abuseType) {
      case 'Physical Violence':
        return Color.fromRGBO(0, 51, 102, 1.0);
      case 'Sexual Violence':
        return Color.fromRGBO(0, 76, 153, 1.0);
      case 'Psychological Violence':
        return Color.fromRGBO(0, 102, 204, 1.0);
      case 'Online Harassment':
        return Color.fromRGBO(0, 128, 255, 1.0);
      case 'Societal Violence':
        return Color.fromRGBO(51, 153, 255, 1.0);
      default:
        return Color.fromRGBO(8, 100, 175, 1.0);
    }
  }

  String _formatDateTime(DateTime date) {
    final formattedDate = DateFormat('dd/MM/yyyy').format(date.toLocal());
    final formattedTime = DateFormat('HH:mm').format(date.toLocal());

    return '$formattedDate | $formattedTime';
  }

  Color _getStatusColor(String status) {
    switch (status) {
      case 'Rejected':
        return Colors.red;
      case 'Pending':
        return Colors.orange;
      case 'Resolved':
        return Colors.green;
      default:
        return Color.fromRGBO(8, 100, 175, 1.0);
    }
  }

  Widget _buildNoReportsView() {
    return ListView(
      shrinkWrap: true,
      children: [
        Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.hourglass_empty,
                size: 32,
                color: Color.fromRGBO(8, 100, 175, 0.6),
              ),
              Text(
                'No Reports',
                style: TextStyle(
                    fontSize: 18,
                    color: Colors.grey,
                    fontWeight: FontWeight.w400),
              ),
            ],
          ),
        )
      ],
    );
  }

  Widget _reportsTile({required Report report}) => Column(
        children: [
          GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ReportActions(report: report),
                ),
              );
            },
            child: ListTile(
              title: Text(
                "Report: ${report.abuse_type.toString()}",
                style: TextStyle(
                  fontSize: 16,
                ),
              ),
              subtitle: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  RichText(
                    text: TextSpan(
                      text: 'Status: ',
                      style: TextStyle(
                          fontFamily: 'Montserrat',
                          fontSize: 14,
                          color: Colors.black),
                      children: [
                        TextSpan(
                          text: report.status
                              .toString()
                              .capitalizeFirstLetterOfEachWord(),
                          style: TextStyle(
                            fontFamily: 'Montserrat',
                            fontSize: 14,
                            color: _getStatusColor(report.status
                                .toString()
                                .capitalizeFirstLetterOfEachWord()),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 8),
                  Text(
                    _formatDateTime(
                        DateTime.parse(report.created_on.toString())),
                    style: TextStyle(fontSize: 12),
                  ),
                ],
              ),
              trailing: Padding(
                padding: EdgeInsets.fromLTRB(16, 0, 0, 0),
                child: Icon(Icons.arrow_forward_ios, size: 18),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(8.0, 0.0, 8.0, 0.0),
            child: Divider(
              height: 0.0,
              color: Colors.grey,
            ),
          )
        ],
      );
}
