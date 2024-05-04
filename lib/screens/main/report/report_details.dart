import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:unisafe/Models/Report.dart';
import 'package:unisafe/resources/formats.dart';

import '../../../Providers/reportProvider.dart';
import '../../../Services/stateObserver.dart';

class ReportDetails extends StatefulWidget {
  final Report report;
  const ReportDetails({super.key, required this.report});

  @override
  State<ReportDetails> createState() => _ReportDetailsState();
}

class _ReportDetailsState extends State<ReportDetails> {
  final _appStateObserver = AppStateObserver();
  late ReportProvider _reportProvider;

  @override
  void didChangeDependencies() {
    _reportProvider = Provider.of<ReportProvider>(context);
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
    final report = widget.report;
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: Row(
            children: [
              Icon(
                Icons.arrow_back_ios,
                size: 20.0,
                color: Colors.white,
              ),
              SizedBox(
                width: 4.0,
              ),
              Text(
                'Back',
                style: TextStyle(
                    fontSize: 16.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
              )
            ],
          ),
        ),
      ),
      body: SizedBox(
        height: MediaQuery.of(context).size.height * 0.99,
        width: double.maxFinite,
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(12.0),
            child: Column(
              children: [
                Container(
                  width: double.maxFinite,
                  height: MediaQuery.of(context).size.height * 0.22,
                  color: _getStatusColor(report.status
                      .toString()
                      .capitalizeFirstLetterOfEachWord()),
                  child: Padding(
                    padding: EdgeInsets.all(12.0),
                    child: Column(
                      children: [
                        Text(
                          'REPORT SUMMARY',
                          style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.white),
                        ),
                        Divider(
                          height: 12.0,
                          color: Colors.white,
                        ),
                        Row(
                          children: [
                            Text(
                              'STATUS: ',
                              style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white),
                            ),
                            Text(
                              report.status.toString().toUpperCase(),
                              style:
                                  TextStyle(fontSize: 16, color: Colors.white),
                            ),
                          ],
                        ),
                        if (report.status
                                .toString()
                                .capitalizeFirstLetterOfEachWord() ==
                            'Rejected') ...[
                          Row(
                            children: [
                              Text(
                                'REASON: ',
                                style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white),
                              ),
                              Text(
                                report.rejection_reason.toString(),
                                style: TextStyle(
                                    fontSize: 16, color: Colors.white),
                              )
                            ],
                          )
                        ],
                        Row(
                          children: [
                            Text(
                              'REPORT ID: ',
                              style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white),
                            ),
                            Text(
                              report.report_id.toString(),
                              style:
                                  TextStyle(fontSize: 16, color: Colors.white),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Text(
                              'DATE CREATED: ',
                              style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white),
                            ),
                            Text(
                              _formatDateTime(
                                  DateTime.parse(report.created_on.toString())),
                              style:
                                  TextStyle(fontSize: 16, color: Colors.white),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                Container(
                  color: Color.fromRGBO(239, 238, 246, 1),
                  child: Padding(
                    padding: EdgeInsets.all(12.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          report.abuse_type.toString(),
                          style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Color.fromRGBO(8, 100, 175, 1)),
                        ),
                        SizedBox(height: 8),
                        Row(
                          children: [
                            Text(
                              'Description: ',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              report.description.toString(),
                              style: TextStyle(fontSize: 16),
                            ),
                          ],
                        ),
                        SizedBox(height: 3),
                        Row(
                          children: [
                            Text(
                              'Date and Time: ',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 16),
                            ),
                            Text(
                              _formatDateTime(DateTime.parse(
                                  report.date_and_time.toString())),
                              style: TextStyle(fontSize: 16),
                            ),
                          ],
                        ),
                        SizedBox(height: 3),
                        Row(
                          children: [
                            Text(
                              'Location: ',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 16),
                            ),
                            Text(
                              report.location.toString(),
                              style: TextStyle(fontSize: 16),
                            ),
                          ],
                        ),
                        Divider(
                          height: 24.0,
                          color: Color.fromRGBO(8, 100, 175, 1.0),
                        ),
                        Text(
                          "Victim's Details",
                          style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Color.fromRGBO(8, 100, 175, 1)),
                        ),
                        SizedBox(height: 8),
                        Row(
                          children: [
                            Text(
                              'Full Name: ',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 16),
                            ),
                            Text(
                              report.victim_full_name.toString(),
                              style: TextStyle(fontSize: 16),
                            ),
                          ],
                        ),
                        SizedBox(height: 3),
                        Row(
                          children: [
                            Text(
                              'Phone Number: ',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 16),
                            ),
                            Text(
                              report.victim_phone.toString(),
                              style: TextStyle(fontSize: 16),
                            ),
                          ],
                        ),
                        SizedBox(height: 3),
                        Row(
                          children: [
                            Text(
                              'Gender: ',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 16),
                            ),
                            Text(
                              report.victim_gender.toString(),
                              style: TextStyle(fontSize: 16),
                            ),
                          ],
                        ),
                        SizedBox(height: 3),
                        Row(
                          children: [
                            Text(
                              'Email: ',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 16),
                            ),
                            Text(
                              report.victim_email.toString(),
                              style: TextStyle(fontSize: 16),
                            ),
                          ],
                        ),
                        SizedBox(height: 3),
                        Row(
                          children: [
                            Text(
                              'Registration Number: ',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 16),
                            ),
                            Text(
                              report.victim_reg_no.toString(),
                              style: TextStyle(fontSize: 16),
                            ),
                          ],
                        ),
                        SizedBox(height: 3),
                        Row(
                          children: [
                            Text(
                              'College: ',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 16),
                            ),
                            Text(
                              report.victim_college.toString(),
                              style: TextStyle(fontSize: 16),
                            ),
                          ],
                        ),
                        Divider(
                          height: 24.0,
                          color: Color.fromRGBO(8, 100, 175, 1.0),
                        ),
                        Text(
                          "Perpetrator's Details",
                          style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Color.fromRGBO(8, 100, 175, 1)),
                        ),
                        SizedBox(height: 8),
                        Row(
                          children: [
                            Text(
                              'Full Name: ',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 16),
                            ),
                            Text(
                              report.perpetrator_fullname.toString(),
                              style: TextStyle(fontSize: 16),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Text(
                              'Gender: ',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 16),
                            ),
                            Text(
                              report.perpetrator_gender.toString(),
                              style: TextStyle(fontSize: 16),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Text(
                              'Relationship: ',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 16),
                            ),
                            Text(
                              report.relationship.toString(),
                              style: TextStyle(fontSize: 16),
                            ),
                          ],
                        ),
                      ],
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
