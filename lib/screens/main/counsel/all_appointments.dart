import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:unisafe/resources/formats.dart';

import '../../../Models/Counsel.dart';
import '../../../Providers/counselProvider.dart';
import '../../../Services/stateObserver.dart';

class AllAppointments extends StatefulWidget {
  const AllAppointments({super.key});

  @override
  State<AllAppointments> createState() => _AllAppointmentsState();
}

class _AllAppointmentsState extends State<AllAppointments> {
  final _appStateObserver = AppStateObserver();
  List<Counsel> _appointments = [];
  late CounselProvider _counselProvider;
  @override
  void didChangeDependencies() {
    _counselProvider = Provider.of<CounselProvider>(context);
    _appointments = _counselProvider.appointments;
    print("Appointments loaded: ${_appointments.length}");
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
          'Appointments',
          style: TextStyle(
              fontSize: 20.0, fontWeight: FontWeight.bold, color: Colors.white),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(8.0),
        child: SizedBox(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: _appointments.isNotEmpty
              ? RefreshIndicator(
                  onRefresh: () async {
                    await _counselProvider.getAppointments();
                  },
                  color: Color.fromRGBO(8, 100, 175, 1),
                  child: ListView.separated(
                    itemCount: _appointments.length,
                    itemBuilder: (context, i) {
                      return ListTile(
                        title: Text(
                          "${_appointments[i].session_type.toString()} Appointment",
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                        subtitle: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            RichText(
                              text: TextSpan(
                                text: 'Appointment ID: ',
                                style: TextStyle(
                                    fontFamily: 'Montserrat',
                                    fontSize: 14,
                                    color: Colors.black),
                                children: [
                                  TextSpan(
                                    text: _appointments[i]
                                        .appointment_id
                                        .toString(),
                                    style: TextStyle(
                                      fontFamily: 'Montserrat',
                                      fontSize: 14,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(
                              height: 2,
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
                                    text: _appointments[i]
                                        .status
                                        .toString()
                                        .capitalizeFirstLetterOfEachWord(),
                                    style: TextStyle(
                                      fontFamily: 'Montserrat',
                                      fontSize: 14,
                                      color: _getStatusColor(_appointments[i]
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
                                  _appointments[i].created_on.toString())),
                              style: TextStyle(fontSize: 12),
                            ),
                          ],
                        ),
                        trailing: Text(
                          _formatDate(
                              DateTime.parse(_appointments[i].date.toString())),
                          style: TextStyle(fontSize: 12),
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
                )
              : RefreshIndicator(
                  onRefresh: () async {
                    await _counselProvider.getAppointments();
                  },
                  child: ListView(
                    children: [
                      SizedBox(
                          height: MediaQuery.of(context).size.height * 0.35),
                      Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.hourglass_empty,
                              size: 40,
                              color: Color.fromRGBO(8, 100, 175, 0.6),
                            ),
                            Text(
                              'No Appointments',
                              style: TextStyle(
                                  fontSize: 18,
                                  color: Colors.grey,
                                  fontWeight: FontWeight.w400),
                            ),
                          ],
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
    final formattedDate = DateFormat('dd/MM/yyyy').format(date.toLocal());
    final formattedTime = DateFormat('HH:mm').format(date.toLocal());

    return formattedDate + " | " + formattedTime;
  }

  String _formatDate(DateTime date) {
    final formattedDate = DateFormat('dd/MM/yyyy').format(date.toLocal());

    return formattedDate;
  }

  Color _getStatusColor(String status) {
    switch (status) {
      case 'Cancelled':
        return Colors.red;
      case 'Requested':
        return Colors.orange;
      case 'Scheduled':
        return Colors.green;
      default:
        return Color.fromRGBO(8, 100, 175, 1.0);
    }
  }
}
