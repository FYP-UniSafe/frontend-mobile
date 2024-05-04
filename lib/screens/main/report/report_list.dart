import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:unisafe/screens/main/report/report_details.dart';
import '../../../resources/formats.dart';
import '../../../Models/Report.dart';
import '../../../Providers/reportProvider.dart';
import '../../../Services/stateObserver.dart';

class ReportList extends StatefulWidget {
  const ReportList({super.key});

  @override
  State<ReportList> createState() => _ReportListState();
}

class _ReportListState extends State<ReportList> {
  final _appStateObserver = AppStateObserver();
  List<Report> _reports = [];
  late ReportProvider _reportProvider;
  @override
  void didChangeDependencies() {
    _reportProvider = Provider.of<ReportProvider>(context);
    _reports = _reportProvider.reports;
    super.didChangeDependencies();
  }

  @override
  void initState() {
    WidgetsBinding.instance.addObserver(_appStateObserver);
    super.initState();
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(_appStateObserver);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(
            Icons.arrow_back_ios,
            size: 20.0,
            color: Colors.white,
          ),
        ),
        title: Text(
          'Your Reports',
          style: TextStyle(
              fontSize: 20.0, fontWeight: FontWeight.bold, color: Colors.white),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(8.0),
        child: SizedBox(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: RefreshIndicator(
            onRefresh: () async {
              await _reportProvider.getReports();
            },
            color: Color.fromRGBO(8, 100, 175, 1),
            child: ListView.separated(
              itemCount: _reports.length,
              itemBuilder: (context, i) {
                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            ReportDetails(report: _reports[i]),
                      ),
                    );
                  },
                  child: ListTile(
                    title: Text(
                      "Report: ${_reports[i].abuse_type.toString()}",
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
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
                                text: _reports[i]
                                    .status
                                    .toString()
                                    .capitalizeFirstLetterOfEachWord(),
                                style: TextStyle(
                                  fontFamily: 'Montserrat',
                                  fontSize: 14,
                                  color: _getStatusColor(_reports[i]
                                      .status
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
                              _reports[i].created_on.toString())),
                          style: TextStyle(fontSize: 12),
                        ),
                      ],
                    ),
                    trailing: Padding(
                      padding: EdgeInsets.fromLTRB(16, 0, 0, 0),
                      child: Icon(
                        Icons.arrow_forward_ios,
                        size: 18,
                      ),
                    ),
                  ),
                );
              },
              separatorBuilder: (context, index) {
                return Padding(
                  padding: EdgeInsets.fromLTRB(8.0, 0.0, 8.0, 0.0),
                  child: Divider(
                    height: 0.0,
                    color: Color.fromRGBO(8, 100, 175, 1.0),
                  ),
                );
              },
            ),
          ),
        ),
      ),
    );
  }

  String _formatDateTime(DateTime date) {
    final formattedDate = DateFormat('dd/MM/yyyy').format(date);
    final formattedTime = DateFormat('HH:mm').format(date);

    return formattedDate + " | " + formattedTime;
  }

  Color _getStatusColor(String status) {
    switch (status) {
      case 'Rejected':
        return Colors.red;
      case 'Pending':
        return Color.fromRGBO(8, 100, 175, 1.0);
      case 'Resolved':
        return Colors.green;
      default:
        return Colors.black;
    }
  }
}
