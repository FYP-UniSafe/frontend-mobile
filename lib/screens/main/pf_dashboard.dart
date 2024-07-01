import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:unisafe/resources/formats.dart';
import '../../Models/Report.dart';
import '../../Providers/reportProvider.dart';

class PFDashboard extends StatefulWidget {
  const PFDashboard({super.key});

  @override
  State<PFDashboard> createState() => _PFDashboardState();
}

class _PFDashboardState extends State<PFDashboard> {
  late ReportProvider _reportProvider;
  List<Report> _policeReports = [];

  @override
  void initState() {
    super.initState();
    Provider.of<ReportProvider>(context, listen: false).fetchForwardedReports();
  }

  @override
  void didChangeDependencies() {
    _reportProvider = Provider.of<ReportProvider>(context);
    _policeReports = _reportProvider.getReportsForwardedToPolice();
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _policeReports.isEmpty
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
                  Text('No reports'),
                ],
              ),
            )
          : RefreshIndicator(
              onRefresh: () async {
                _reportProvider.fetchForwardedReports();
              },
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: _policeReports.map((report) {
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 16.0),
                        child: Card(
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
                                  _formatDateTime(DateTime.parse(
                                      report.created_on.toString())),
                                  style: TextStyle(fontSize: 12),
                                ),
                              ],
                            ),
                            onTap: () {},
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                ),
              ),
            ),
    );
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
      case 'In Progress':
        return Colors.grey;
      default:
        return Color.fromRGBO(8, 100, 175, 1.0);
    }
  }
}
