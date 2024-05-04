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
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(8.0),
          child: Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(0),
            ),
            elevation: 5,
            color: Colors.white,
            child: Padding(
              padding: EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                //mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Align(
                    alignment: Alignment.center,
                    child: Text(
                      '${report.abuse_type}',
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                  ),
                  Divider(
                    height: 16.0,
                    color: Color.fromRGBO(8, 100, 175, 1.0),
                  ),
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
                  SizedBox(height: 8),
                  Row(
                    children: [
                      Text(
                        'Date and Time: ',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 16),
                      ),
                      Text(
                        _formatDateTime(
                            DateTime.parse(report.date_and_time.toString())),
                        style: TextStyle(fontSize: 16),
                      ),
                    ],
                  ),
                  SizedBox(height: 8),
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
                  SizedBox(height: 8),
                  Text(
                    "Victim's Details",
                    style: TextStyle(
                        fontSize: 17,
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
                  SizedBox(height: 8),
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
                  SizedBox(height: 8),
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
                  SizedBox(height: 8),
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
                  SizedBox(height: 8),
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
                  SizedBox(height: 8),
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
                  SizedBox(height: 8),
                  Text(
                    "Perpetrator's Details",
                    style: TextStyle(
                        fontSize: 17,
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
                  SizedBox(height: 8),
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
                  SizedBox(height: 8),
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
                  Divider(
                    height: 16.0,
                    color: Color.fromRGBO(8, 100, 175, 1.0),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Report ID',
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                      Text(
                        'Created On',
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        report.report_id.toString(),
                        style: TextStyle(
                          fontSize: 14,
                        ),
                      ),
                      Text(
                        _formatDateTime(
                            DateTime.parse(report.created_on.toString())),
                        style: TextStyle(fontSize: 14),
                      ),
                    ],
                  ),
                  SizedBox(height: 8),
                  Text(
                    'Status',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    report.status.toString().capitalizeFirstLetterOfEachWord(),
                    style: TextStyle(
                      fontFamily: 'Montserrat',
                      fontSize: 16,
                      color: _getStatusColor(report.status
                          .toString()
                          .capitalizeFirstLetterOfEachWord()),
                    ),
                  ),
                  if (report.status
                          .toString()
                          .capitalizeFirstLetterOfEachWord() ==
                      'Rejected') ...[
                    Column(
                      children: [
                        Text('Rejection Reason'),
                        Text(report.rejection_reason.toString())
                      ],
                    )
                  ]
                ],
              ),
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
