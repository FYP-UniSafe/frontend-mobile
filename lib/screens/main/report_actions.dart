import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:loading_indicator/loading_indicator.dart';
import 'package:provider/provider.dart';
import 'package:unisafe/Models/Report.dart';
import 'package:unisafe/resources/formats.dart';
import '../../Providers/reportProvider.dart';
import '../../Services/stateObserver.dart';
import '../../Widgets/Flashbar/flashbar.dart';

class ReportActions extends StatefulWidget {
  final Report report;
  final bool isAnonymous;
  final bool? isPolice;
  const ReportActions(
      {super.key,
      required this.report,
      required this.isAnonymous,
      this.isPolice});

  @override
  State<ReportActions> createState() => _ReportDetailsState();
}

class _ReportDetailsState extends State<ReportActions> {
  final _appStateObserver = AppStateObserver();

  @override
  void didChangeDependencies() {
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
    final reportProvider = Provider.of<ReportProvider>(context);

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
                              widget.isPolice != null && widget.isPolice == true
                                  ? report.police_status
                                      .toString()
                                      .toUpperCase()
                                  : report.status.toString().toUpperCase(),
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
                        Row(
                          children: [
                            if (widget.isPolice ?? false) ...[
                              Column(
                                //mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'ASSIGNED POLICE: ',
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white),
                                  ),
                                  Text(
                                    report.assigned_officer.toString(),
                                    style: TextStyle(
                                        fontSize: 16, color: Colors.white),
                                  ),
                                ],
                              ),
                            ] else ...[
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'ASSIGNED GD: ',
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white),
                                  ),
                                  Text(
                                    report.assigned_gd.toString(),
                                    style: TextStyle(
                                        fontSize: 16, color: Colors.white),
                                  ),
                                ],
                              ),
                            ],
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
                        RichText(
                          text: TextSpan(
                            style: TextStyle(
                              fontSize: 16,
                              fontFamily: 'Montserrat',
                              color: Colors.black,
                            ),
                            children: [
                              TextSpan(
                                text: 'Description: ',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              TextSpan(
                                text: report.description.toString(),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 6),
                        RichText(
                          text: TextSpan(
                            style: TextStyle(
                              fontSize: 16,
                              fontFamily: 'Montserrat',
                              color: Colors.black,
                            ),
                            children: [
                              TextSpan(
                                text: 'Date and Time: ',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              TextSpan(
                                text: _formatDateTime(DateTime.parse(
                                    report.date_and_time.toString())),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 6),
                        RichText(
                          text: TextSpan(
                            style: TextStyle(
                              fontSize: 16,
                              fontFamily: 'Montserrat',
                              color: Colors.black,
                            ),
                            children: [
                              TextSpan(
                                text: 'Location: ',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              if (report.location.toString() != 'Other')
                                TextSpan(
                                  text: report.location.toString(),
                                ),
                              if (report.location.toString() == 'Other')
                                TextSpan(
                                  text: report.other_location.toString(),
                                ),
                            ],
                          ),
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
                            color: Color.fromRGBO(8, 100, 175, 1),
                          ),
                        ),
                        SizedBox(height: 8),
                        RichText(
                          text: TextSpan(
                            style: TextStyle(
                              fontSize: 16,
                              fontFamily: 'Montserrat',
                              color: Colors.black,
                            ),
                            children: [
                              TextSpan(
                                text: 'Full Name: ',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              TextSpan(
                                text: report.victim_full_name.toString(),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 6),
                        RichText(
                          text: TextSpan(
                            style: TextStyle(
                              fontSize: 16,
                              fontFamily: 'Montserrat',
                              color: Colors.black,
                            ),
                            children: [
                              TextSpan(
                                text: 'Phone Number: ',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              TextSpan(
                                text: report.victim_phone.toString(),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 6),
                        RichText(
                          text: TextSpan(
                            style: TextStyle(
                              fontSize: 16,
                              fontFamily: 'Montserrat',
                              color: Colors.black,
                            ),
                            children: [
                              TextSpan(
                                text: 'Gender: ',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              TextSpan(
                                text: report.victim_gender.toString(),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 6),
                        RichText(
                          text: TextSpan(
                            style: TextStyle(
                              fontSize: 16,
                              fontFamily: 'Montserrat',
                              color: Colors.black,
                            ),
                            children: [
                              TextSpan(
                                text: 'Email: ',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              TextSpan(
                                text: report.victim_email.toString(),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 6),
                        RichText(
                          text: TextSpan(
                            style: TextStyle(
                              fontSize: 16,
                              fontFamily: 'Montserrat',
                              color: Colors.black,
                            ),
                            children: [
                              TextSpan(
                                text: 'Registration Number: ',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              TextSpan(
                                text: report.victim_reg_no.toString(),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 6),
                        RichText(
                          text: TextSpan(
                            style: TextStyle(
                              fontSize: 16,
                              fontFamily: 'Montserrat',
                              color: Colors.black,
                            ),
                            children: [
                              TextSpan(
                                text: 'College: ',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              TextSpan(
                                text: report.victim_college.toString(),
                              ),
                            ],
                          ),
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
                        RichText(
                          text: TextSpan(
                            style: TextStyle(
                              fontSize: 16,
                              fontFamily: 'Montserrat',
                              color: Colors.black,
                            ),
                            children: [
                              TextSpan(
                                text: 'Full Name: ',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              TextSpan(
                                text: report.perpetrator_fullname.toString(),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 6),
                        RichText(
                          text: TextSpan(
                            style: TextStyle(
                              fontSize: 16,
                              fontFamily: 'Montserrat',
                              color: Colors.black,
                            ),
                            children: [
                              TextSpan(
                                text: 'Gender: ',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              TextSpan(
                                text: report.perpetrator_gender.toString(),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 6),
                        RichText(
                          text: TextSpan(
                            style: TextStyle(
                              fontSize: 16,
                              fontFamily: 'Montserrat',
                              color: Colors.black,
                            ),
                            children: [
                              TextSpan(
                                text: 'Relationship: ',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              TextSpan(
                                text: report.relationship.toString(),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: 10.0,
                ),
                if (widget.isPolice ?? false) ...[
                  if (report.status.toString().trim() != 'RESOLVED') ...[
                    if (report.police_status.toString().toLowerCase() !=
                        'received')
                      ElevatedButton(
                        onPressed: () async {
                          showDialog(
                            context: context,
                            barrierDismissible: false,
                            builder: (BuildContext context) {
                              return Dialog(
                                backgroundColor: Colors.transparent,
                                elevation: 0,
                                child: Container(
                                  height: 100,
                                  width: 100,
                                  alignment: Alignment.center,
                                  child: LoadingIndicator(
                                    indicatorType: Indicator.ballPulseRise,
                                    colors: [Color.fromRGBO(8, 100, 175, 1.0)],
                                  ),
                                ),
                              );
                            },
                          );

                          try {
                            if (widget.isAnonymous) {
                              await reportProvider.receiveAnonymousReport(
                                  report.report_id.toString());
                            } else {
                              await reportProvider
                                  .receiveReport(report.report_id.toString());
                            }
                            Navigator.pop(context);
                            Navigator.pop(context);
                          } catch (e) {
                            Navigator.pop(context);

                            Flashbar(
                              flashbarPosition: FlashbarPosition.TOP,
                              borderRadius: BorderRadius.circular(5),
                              backgroundColor: Colors.red,
                              icon: Icon(
                                CupertinoIcons.exclamationmark_triangle,
                                color: Colors.white,
                                size: 32,
                              ),
                              titleText: Text(
                                'Alert',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontFamily: 'Poppins',
                                    fontSize: 18,
                                    fontWeight: FontWeight.w500),
                              ),
                              messageText: Text(
                                '$e',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontFamily: 'Poppins',
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500),
                              ),
                              duration: Duration(seconds: 3),
                            ).show(context);
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          foregroundColor: Colors.white,
                          fixedSize:
                              Size(MediaQuery.of(context).size.width * 0.9, 50),
                          backgroundColor: Color.fromRGBO(8, 100, 175, 1.0),
                          padding: EdgeInsets.all(12.0),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5.0),
                          ),
                        ),
                        child: Text(
                          'Receive Report',
                          style: TextStyle(
                            fontSize: 16.0,
                          ),
                        ),
                      ),
                    SizedBox(
                      height: 8,
                    ),
                    if (report.police_status.toString().toLowerCase() ==
                        'received')
                      ElevatedButton(
                        onPressed: () async {
                          showDialog(
                            context: context,
                            barrierDismissible: false,
                            builder: (BuildContext context) {
                              return Dialog(
                                backgroundColor: Colors.transparent,
                                elevation: 0,
                                child: Container(
                                  height: 100,
                                  width: 100,
                                  alignment: Alignment.center,
                                  child: LoadingIndicator(
                                    indicatorType: Indicator.ballPulseRise,
                                    colors: [Color.fromRGBO(8, 100, 175, 1.0)],
                                  ),
                                ),
                              );
                            },
                          );

                          try {
                            if (widget.isAnonymous) {
                              await reportProvider.closeAnonymousReport(
                                  report.report_id.toString());
                            } else {
                              await reportProvider
                                  .closeReport(report.report_id.toString());
                            }
                            Navigator.pop(context);
                            Navigator.pop(context);
                          } catch (e) {
                            Navigator.pop(context);

                            Flashbar(
                              flashbarPosition: FlashbarPosition.TOP,
                              borderRadius: BorderRadius.circular(5),
                              backgroundColor: Colors.red,
                              icon: Icon(
                                CupertinoIcons.exclamationmark_triangle,
                                color: Colors.white,
                                size: 32,
                              ),
                              titleText: Text(
                                'Alert',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontFamily: 'Poppins',
                                    fontSize: 18,
                                    fontWeight: FontWeight.w500),
                              ),
                              messageText: Text(
                                '$e',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontFamily: 'Poppins',
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500),
                              ),
                              duration: Duration(seconds: 3),
                            ).show(context);
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          foregroundColor: Colors.white,
                          fixedSize:
                              Size(MediaQuery.of(context).size.width * 0.9, 50),
                          backgroundColor: Color.fromRGBO(8, 100, 175, 1.0),
                          padding: EdgeInsets.all(12.0),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5.0),
                          ),
                        ),
                        child: Text(
                          'Close Report',
                          style: TextStyle(
                            fontSize: 16.0,
                          ),
                        ),
                      ),
                  ],
                ] else ...[
                  if (report.status.toString() != 'REJECTED' &&
                      report.status.toString().trim() != 'RESOLVED') ...[
                    Padding(
                      padding: EdgeInsets.only(left: 8.0, right: 8.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          if (!report.status
                                  .toString()
                                  .toLowerCase()
                                  .contains("forwarded") &&
                              !report.status
                                  .toString()
                                  .toLowerCase()
                                  .contains("progress"))
                            ElevatedButton(
                              onPressed: () async {
                                showDialog(
                                  context: context,
                                  barrierDismissible: false,
                                  builder: (BuildContext context) {
                                    return Dialog(
                                      backgroundColor: Colors.transparent,
                                      elevation: 0,
                                      child: Container(
                                        height: 100,
                                        width: 100,
                                        alignment: Alignment.center,
                                        child: LoadingIndicator(
                                          indicatorType:
                                              Indicator.ballPulseRise,
                                          colors: [
                                            Color.fromRGBO(8, 100, 175, 1.0)
                                          ],
                                        ),
                                      ),
                                    );
                                  },
                                );

                                try {
                                  if (widget.isAnonymous) {
                                    await reportProvider.acceptAnonymousReport(
                                        report.report_id.toString());
                                  } else {
                                    await reportProvider.acceptReport(
                                        report.report_id.toString());
                                    /*Flashbar(
                                      flashbarPosition: FlashbarPosition.TOP,
                                      borderRadius: BorderRadius.circular(5),
                                      backgroundColor: Colors.green,
                                      icon: Icon(
                                        CupertinoIcons.check_mark_circled,
                                        color: Colors.white,
                                        size: 32,
                                      ),
                                      titleText: Text(
                                        'Success',
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontFamily: 'Poppins',
                                            fontSize: 18,
                                            fontWeight: FontWeight.w500),
                                      ),
                                      messageText: Text(
                                        'The report has been accepted successfully',
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontFamily: 'Poppins',
                                            fontSize: 16,
                                            fontWeight: FontWeight.w500),
                                      ),
                                      duration: Duration(seconds: 3),
                                    ).show(context);*/
                                  }
                                  Navigator.pop(context);
                                  Navigator.pop(context);
                                } catch (e) {
                                  Navigator.pop(context);

                                  Flashbar(
                                    flashbarPosition: FlashbarPosition.TOP,
                                    borderRadius: BorderRadius.circular(5),
                                    backgroundColor: Colors.red,
                                    icon: Icon(
                                      CupertinoIcons.exclamationmark_triangle,
                                      color: Colors.white,
                                      size: 32,
                                    ),
                                    titleText: Text(
                                      'Alert',
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontFamily: 'Poppins',
                                          fontSize: 18,
                                          fontWeight: FontWeight.w500),
                                    ),
                                    messageText: Text(
                                      'The report has already been accepted',
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontFamily: 'Poppins',
                                          fontSize: 16,
                                          fontWeight: FontWeight.w500),
                                    ),
                                    duration: Duration(seconds: 3),
                                  ).show(context);
                                }
                              },
                              style: ElevatedButton.styleFrom(
                                foregroundColor: Colors.white,
                                fixedSize: Size(
                                    MediaQuery.of(context).size.width * 0.9,
                                    50),
                                backgroundColor:
                                    Color.fromRGBO(8, 100, 175, 1.0),
                                padding: EdgeInsets.all(12.0),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(5.0),
                                ),
                              ),
                              child: Text(
                                'Accept Report',
                                style: TextStyle(
                                  fontSize: 16.0,
                                ),
                              ),
                            ),
                          SizedBox(
                            height: 8.0,
                          ),
                          ElevatedButton(
                            onPressed: () async {
                              showDialog(
                                context: context,
                                barrierDismissible: false,
                                builder: (BuildContext context) {
                                  return Dialog(
                                    backgroundColor: Colors.transparent,
                                    elevation: 0,
                                    child: Container(
                                      height: 100,
                                      width: 100,
                                      alignment: Alignment.center,
                                      child: LoadingIndicator(
                                        indicatorType: Indicator.ballPulseRise,
                                        colors: [
                                          Color.fromRGBO(8, 100, 175, 1.0)
                                        ],
                                      ),
                                    ),
                                  );
                                },
                              );

                              try {
                                if (widget.isAnonymous) {
                                  await reportProvider.closeAnonymousReport(
                                      report.report_id.toString());
                                } else {
                                  await reportProvider
                                      .closeReport(report.report_id.toString());
                                }
                                Navigator.pop(context);
                                Navigator.pop(context);
                              } catch (e) {
                                Navigator.pop(context);

                                Flashbar(
                                  flashbarPosition: FlashbarPosition.TOP,
                                  borderRadius: BorderRadius.circular(5),
                                  backgroundColor: Colors.red,
                                  icon: Icon(
                                    CupertinoIcons.exclamationmark_triangle,
                                    color: Colors.white,
                                    size: 32,
                                  ),
                                  titleText: Text(
                                    'Alert',
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontFamily: 'Poppins',
                                        fontSize: 18,
                                        fontWeight: FontWeight.w500),
                                  ),
                                  messageText: Text(
                                    '$e',
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontFamily: 'Poppins',
                                        fontSize: 16,
                                        fontWeight: FontWeight.w500),
                                  ),
                                  duration: Duration(seconds: 3),
                                ).show(context);
                              }
                            },
                            style: ElevatedButton.styleFrom(
                              foregroundColor: Colors.white,
                              fixedSize: Size(
                                  MediaQuery.of(context).size.width * 0.9, 50),
                              backgroundColor: Color.fromRGBO(8, 100, 175, 1.0),
                              padding: EdgeInsets.all(12.0),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(5.0),
                              ),
                            ),
                            child: Text(
                              'Close Report',
                              style: TextStyle(
                                fontSize: 16.0,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 8.0,
                    ),
                    if (!report.status
                        .toString()
                        .toLowerCase()
                        .contains("forwarded"))
                      Padding(
                        padding: EdgeInsets.only(left: 8.0, right: 8.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            if (!report.status
                                .toString()
                                .toLowerCase()
                                .contains("progress"))
                              ElevatedButton(
                                onPressed: () async {
                                  showDialog(
                                    context: context,
                                    barrierDismissible: false,
                                    builder: (BuildContext context) {
                                      return Dialog(
                                        backgroundColor: Colors.transparent,
                                        elevation: 0,
                                        child: Container(
                                          height: 100,
                                          width: 100,
                                          alignment: Alignment.center,
                                          child: LoadingIndicator(
                                            indicatorType:
                                                Indicator.ballPulseRise,
                                            colors: [
                                              Color.fromRGBO(8, 100, 175, 1.0)
                                            ],
                                          ),
                                        ),
                                      );
                                    },
                                  );

                                  try {
                                    if (widget.isAnonymous) {
                                      await reportProvider
                                          .rejectAnonymousReport(
                                        report.report_id.toString(),
                                        report.rejection_reason.toString(),
                                        report.status.toString(),
                                      );
                                    } else {
                                      await reportProvider.rejectReport(
                                        report.report_id.toString(),
                                        report.rejection_reason.toString(),
                                        report.status.toString(),
                                      );
                                    }
                                    Navigator.pop(context);
                                    Navigator.pop(context);
                                  } catch (e) {
                                    Navigator.pop(context);

                                    Flashbar(
                                      flashbarPosition: FlashbarPosition.TOP,
                                      borderRadius: BorderRadius.circular(5),
                                      backgroundColor: Colors.red,
                                      icon: Icon(
                                        CupertinoIcons.exclamationmark_triangle,
                                        color: Colors.white,
                                        size: 32,
                                      ),
                                      titleText: Text(
                                        'Alert',
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontFamily: 'Poppins',
                                            fontSize: 18,
                                            fontWeight: FontWeight.w500),
                                      ),
                                      messageText: Text(
                                        '$e',
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontFamily: 'Poppins',
                                            fontSize: 16,
                                            fontWeight: FontWeight.w500),
                                      ),
                                      duration: Duration(seconds: 3),
                                    ).show(context);
                                  }
                                },
                                style: ElevatedButton.styleFrom(
                                  foregroundColor: Colors.white,
                                  fixedSize: Size(
                                      MediaQuery.of(context).size.width * 0.9,
                                      50),
                                  backgroundColor:
                                      Color.fromRGBO(8, 100, 175, 1.0),
                                  padding: EdgeInsets.all(12.0),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(5.0),
                                  ),
                                ),
                                child: Text(
                                  'Reject Report',
                                  style: TextStyle(
                                    fontSize: 16.0,
                                  ),
                                ),
                              ),
                            SizedBox(
                              height: 8.0,
                            ),
                            ElevatedButton(
                              onPressed: () async {
                                showDialog(
                                  context: context,
                                  barrierDismissible: false,
                                  builder: (BuildContext context) {
                                    return Dialog(
                                      backgroundColor: Colors.transparent,
                                      elevation: 0,
                                      child: Container(
                                        height: 100,
                                        width: 100,
                                        alignment: Alignment.center,
                                        child: LoadingIndicator(
                                          indicatorType:
                                              Indicator.ballPulseRise,
                                          colors: [
                                            Color.fromRGBO(8, 100, 175, 1.0)
                                          ],
                                        ),
                                      ),
                                    );
                                  },
                                );

                                try {
                                  if (widget.isAnonymous) {
                                    await reportProvider.forwardAnonymousReport(
                                        report.report_id.toString());
                                  } else {
                                    await reportProvider.forwardReport(
                                        report.report_id.toString());
                                  }
                                  Navigator.pop(context);
                                  Navigator.pop(context);
                                } catch (e) {
                                  Navigator.pop(context);
                                  Flashbar(
                                    flashbarPosition: FlashbarPosition.TOP,
                                    borderRadius: BorderRadius.circular(5),
                                    backgroundColor: Colors.red,
                                    icon: Icon(
                                      CupertinoIcons.exclamationmark_triangle,
                                      color: Colors.white,
                                      size: 32,
                                    ),
                                    titleText: Text(
                                      'Alert',
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontFamily: 'Poppins',
                                          fontSize: 18,
                                          fontWeight: FontWeight.w500),
                                    ),
                                    messageText: Text(
                                      '$e',
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontFamily: 'Poppins',
                                          fontSize: 16,
                                          fontWeight: FontWeight.w500),
                                    ),
                                    duration: Duration(seconds: 3),
                                  ).show(context);
                                }
                              },
                              style: ElevatedButton.styleFrom(
                                foregroundColor: Colors.white,
                                fixedSize: Size(
                                    MediaQuery.of(context).size.width * 0.9,
                                    50),
                                backgroundColor:
                                    Color.fromRGBO(8, 100, 175, 1.0),
                                padding: EdgeInsets.all(12.0),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(5.0),
                                ),
                              ),
                              child: Text(
                                'Forward Report',
                                style: TextStyle(
                                  fontSize: 16.0,
                                ),
                              ),
                            )
                          ],
                        ),
                      )
                  ],
                ]
              ],
            ),
          ),
        ),
      ),
    );
  }

  String _formatDateTime(DateTime date) {
    final formattedDate = DateFormat('dd/MM/yyyy').format(date.toLocal());
    final formattedTime = DateFormat('HH:mm').format(date.toLocal());

    return formattedDate + " | " + formattedTime;
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
