import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:unisafe/resources/formats.dart';
import 'package:unisafe/screens/main/report_actions.dart';
import '../../../Models/Report.dart';
import '../../../Providers/reportProvider.dart';

class PFDashboard extends StatefulWidget {
  const PFDashboard({super.key});

  @override
  State<PFDashboard> createState() => _PFDashboardState();
}

class _PFDashboardState extends State<PFDashboard> {
  late ReportProvider _reportProvider;
  List<Report> _policeReports = [];
  List<Report> _anonymousPoliceReports = [];
  @override
  void initState() {
    super.initState();
    Provider.of<ReportProvider>(context, listen: false).fetchForwardedReports();
    Provider.of<ReportProvider>(context, listen: false)
        .fetchAnonymousForwardedReports();
  }

  void didChangeDependencies() {
    _reportProvider = Provider.of<ReportProvider>(context);
    _policeReports = _reportProvider.getReportsForwardedToPolice();
    _anonymousPoliceReports =
        _reportProvider.getAnonymousReportsForwardedToPolice();
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _policeReports.isEmpty || _anonymousPoliceReports.isEmpty
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
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
          : RefreshIndicator(
              onRefresh: () async {
                await Future.wait([
                  _reportProvider.fetchForwardedReports(),
                  _reportProvider.fetchAnonymousForwardedReports()
                ]);
              },
              color: Color.fromRGBO(8, 100, 175, 1),
              child: SingleChildScrollView(
                child: Padding(
                  padding: EdgeInsets.only(
                      left: 16.0, right: 16.0, top: 8.0, bottom: 8.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'REPORTS',
                        style: TextStyle(fontSize: 18.0),
                      ),
                      Divider(
                        height: 30.0,
                        color: Color.fromRGBO(8, 100, 175, 1.0),
                      ),
                      if (_policeReports.isNotEmpty) ...[
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            'Named Reports',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        _buildReportSection(_policeReports, isAnonymous: false),
                      ],
                      if (_anonymousPoliceReports.isNotEmpty) ...[
                        SizedBox(height: 16),
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            'Anonymous Reports',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        _buildReportSection(_anonymousPoliceReports,
                            isAnonymous: true),
                      ],
                    ],
                  ),
                ),
              ),
            ),
    );
  }

  Widget _buildReportSection(List<Report> reports,
      {required bool isAnonymous}) {
    return Column(
      children: reports.map((report) {
        return Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            GestureDetector(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (_) => ReportActions(
                              report: report,
                              isAnonymous: isAnonymous,
                              isPolice: true,
                            )));
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
                    SizedBox(
                      height: 4.0,
                    ),
                    RichText(
                      text: TextSpan(
                        text: 'ID: ',
                        style: TextStyle(
                            fontFamily: 'Montserrat',
                            fontSize: 14,
                            color: Colors.black),
                        children: [
                          TextSpan(
                            text: report.report_id.toString(),
                            style: TextStyle(
                              fontFamily: 'Montserrat',
                              fontSize: 14,
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 4.0,
                    ),
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
                              color: _getStatusColor(report.status.toString()),
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
      }).toList(),
    );
  }

  String _formatDateTime(DateTime date) {
    final formattedDate = DateFormat('dd/MM/yyyy').format(date.toLocal());
    final formattedTime = DateFormat('HH:mm').format(date.toLocal());

    return '$formattedDate | $formattedTime';
  }

  Color _getStatusColor(String status) {
    switch (status) {
      case 'RESOLVED':
        return Colors.green;
      default:
        return Color.fromRGBO(8, 100, 175, 1.0);
    }
  }
}
