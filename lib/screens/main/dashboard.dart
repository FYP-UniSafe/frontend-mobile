import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:unisafe/Models/ReportDataPerYear.dart';

import '../../Models/AbuseReport.dart';
import '../../Providers/abuseReportProvider.dart';
import '../../Providers/reportDataPerYearProvider.dart';
import '../../Services/stateObserver.dart';
import '../../main.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({super.key});

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  final _appStateObserver = AppStateObserver();
  int? touchedIndex = 0;

  @override
  void initState() {
    WidgetsBinding.instance.addObserver(_appStateObserver);
    super.initState();

    Future.microtask(() =>
        Provider.of<ReportDataPerYearProvider>(context, listen: false)
            .fetchReports());
    Future.microtask(() =>
        Provider.of<AbuseReportProvider>(context, listen: false)
            .fetchReports());
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(_appStateObserver);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final reportDataPerYearProvider =
        Provider.of<ReportDataPerYearProvider>(context);
    final abuseReportProvider = Provider.of<AbuseReportProvider>(context);

    return Scaffold(
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: SizedBox(
          height: MediaQuery.of(context).size.height * 0.99,
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
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
                if (reportDataPerYearProvider.reports.isNotEmpty)
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.45,
                    child: Padding(
                      padding: EdgeInsets.all(8.0),
                      child: BarChart(
                        BarChartData(
                          barGroups: reportDataPerYearProvider.reports
                              .asMap()
                              .entries
                              .map((entry) {
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
                                      index <
                                          reportDataPerYearProvider
                                              .reports.length) {
                                    return Text(
                                      reportDataPerYearProvider
                                          .reports[index].year,
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
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.45,
                  child: Padding(
                    padding: EdgeInsets.all(16.0),
                    child: PieChart(
                      PieChartData(
                        sections: _getSections(abuseReportProvider.reports),
                        startDegreeOffset: 0,
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
}
