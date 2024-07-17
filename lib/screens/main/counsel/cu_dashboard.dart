import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:collection/collection.dart';
import 'package:unisafe/main.dart';
import 'package:unisafe/resources/formats.dart';
import 'package:unisafe/screens/main/counsel/appointmentDetails.dart';

import '../../../Models/Counsel.dart';
import '../../../Providers/counselProvider.dart';
import '../../../Services/stateObserver.dart';

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
    _allAppointments = _counselProvider.allAppointments;
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
    final groupedAppointments =
        groupBy(_allAppointments, (Counsel counsel) => counsel.session_type);

    return Scaffold(
      body: Padding(
        padding: EdgeInsets.all(8.0),
        child: RefreshIndicator(
          onRefresh: () async {
            await Future.wait([
              counselProvider.getAllAppointments(),
            ]);
          },
          color: Color.fromRGBO(8, 100, 175, 1),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                child: ListView(
                  children: groupedAppointments.entries.map((entry) {
                    final sessionType = entry.key;
                    final appointments = entry.value;

                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Padding(
                          padding: EdgeInsets.only(left: 8.0, right: 8.0),
                          child: Text(
                            '$sessionType Appointments'.toUpperCase(),
                            style: TextStyle(
                              fontSize: 16,
                            ),
                          ),
                        ),
                        Divider(
                          height: 30.0,
                          color: Color.fromRGBO(8, 100, 175, 1.0),
                        ),
                        ListView.separated(
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          itemCount: appointments.length,
                          itemBuilder: (context, i) {
                            return GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => AppointmentDetails(
                                      appointment: appointments[i],
                                      isConsultant: true,
                                    ),
                                  ),
                                );
                              },
                              child: ListTile(
                                title: RichText(
                                  text: TextSpan(
                                    text: 'Appointment ID: ',
                                    style: TextStyle(
                                        fontFamily: 'Montserrat',
                                        fontSize: 14,
                                        color: Colors.black),
                                    children: [
                                      TextSpan(
                                        text: appointments[i]
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
                                subtitle: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    /* SizedBox(
                                      height: 4.0,
                                    ),
                                    RichText(
                                      text: TextSpan(
                                        text: 'Scheduled on: ',
                                        style: TextStyle(
                                            fontFamily: 'Montserrat',
                                            fontSize: 14,
                                            color: Colors.black),
                                        children: [
                                          TextSpan(
                                            text: _formatDate(DateTime.parse(
                                                appointments[i].date.toString())),
                                            style: TextStyle(fontSize: 12),
                                          ),
                                        ],
                                      ),
                                    ),*/
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
                                            text: appointments[i]
                                                .status
                                                .toString()
                                                .capitalizeFirstLetterOfEachWord(),
                                            style: TextStyle(
                                              fontFamily: 'Montserrat',
                                              fontSize: 14,
                                              color: _getStatusColor(appointments[
                                                      i]
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
                                          appointments[i]
                                              .created_on
                                              .toString())),
                                      style: TextStyle(fontSize: 12),
                                    ),
                                  ],
                                ),
                                trailing: Padding(
                                  padding: EdgeInsets.fromLTRB(16, 0, 0, 0),
                                  child:
                                      Icon(Icons.arrow_forward_ios, size: 18),
                                ),
                              ),
                            );
                          },
                          separatorBuilder: (context, index) {
                            return Padding(
                              padding: EdgeInsets.fromLTRB(8.0, 0.0, 8.0, 0.0),
                              child: Divider(
                                height: 0.0,
                                color: Colors.grey,
                              ),
                            );
                          },
                        ),
                      ],
                    );
                  }).toList(),
                ),
              ),
            ],
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
        return Colors.grey;
      case 'Missed':
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
