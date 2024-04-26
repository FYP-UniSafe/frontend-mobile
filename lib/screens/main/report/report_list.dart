import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
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
      body: SizedBox(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: RefreshIndicator(
          onRefresh: () async {
            await _reportProvider.getReports();
          },
          color: Color.fromRGBO(8, 100, 175, 1),
          child: ListView.builder(
              physics: ClampingScrollPhysics(),
              itemCount: _reports.length,
              itemBuilder: (context, i) => Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    child: ListTile(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                            side: BorderSide(color: Colors.grey)),
                        title: Text(
                          "Report: ${_reports[i].abuse_type.toString()}",
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                        subtitle: Text(
                          "Status: ${_reports[i].status.toString()}",
                          style: TextStyle(fontSize: 16),
                        ),
                        trailing: Text(
                          _formatDateTime(DateTime.parse(
                              _reports[i].created_on.toString())),
                          style: TextStyle(fontSize: 16),
                        )),
                  )),
        ),
      ),
    );
  }

  String _formatDateTime(DateTime date) {
    final formattedDate = DateFormat('dd/MM/yyyy').format(date);
    final formattedTime = DateFormat('HH:mm').format(date);

    return formattedDate + " at " + formattedTime;
  }
}
