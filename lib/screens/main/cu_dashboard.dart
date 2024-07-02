import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:unisafe/resources/formats.dart';

import '../../Models/Counsel.dart';
import '../../Providers/counselProvider.dart';
import '../../Services/stateObserver.dart';

class CUDashboard extends StatefulWidget {
  const CUDashboard({super.key});

  @override
  State<CUDashboard> createState() => _CUDashboardState();
}

class _CUDashboardState extends State<CUDashboard> {
  final _appStateObserver = AppStateObserver();
  List<Counsel> _allAppointments = [];
  late CounselProvider _counselProvider;
  @override
  void didChangeDependencies() {
    _counselProvider = Provider.of<CounselProvider>(context);
    _allAppointments = _counselProvider.appointments;
    print("Appointments loaded: ${_allAppointments.length}");
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
      body: Padding(
        padding: EdgeInsets.all(8.0),
        child: SizedBox(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: _allAppointments.isNotEmpty
              ? RefreshIndicator(
                  onRefresh: () async {
                    await _counselProvider.getAllAppointments();
                  },
                  color: Color.fromRGBO(8, 100, 175, 1),
                  child: ListView.separated(
                    itemCount: _allAppointments.length,
                    itemBuilder: (context, i) {
                      return ListTile(
                        title: Text(
                          "${_allAppointments[i].session_type.toString()} Appointment",
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
                                    text: _allAppointments[i]
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
                                    text: _allAppointments[i]
                                        .status
                                        .toString()
                                        .capitalizeFirstLetterOfEachWord(),
                                    style: TextStyle(
                                      fontFamily: 'Montserrat',
                                      fontSize: 14,
                                      color: _getStatusColor(_allAppointments[i]
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
                                  _allAppointments[i].created_on.toString())),
                              style: TextStyle(fontSize: 12),
                            ),
                          ],
                        ),
                        trailing: Text(
                          _formatDate(DateTime.parse(
                              _allAppointments[i].date.toString())),
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
                    await _counselProvider.getAllAppointments();
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

  String _formatDate(DateTime date) {
    final formattedDate = DateFormat('dd/MM/yyyy').format(date.toLocal());

    return formattedDate;
  }

  String _formatDateTime(DateTime date) {
    final formattedDate = DateFormat('dd/MM/yyyy').format(date.toLocal());
    final formattedTime = DateFormat('HH:mm').format(date.toLocal());

    return formattedDate + " | " + formattedTime;
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
