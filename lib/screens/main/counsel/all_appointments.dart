import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:unisafe/resources/formats.dart';

import '../../../Models/Counsel.dart';
import '../../../Providers/counselProvider.dart';
import '../../../Services/stateObserver.dart';
import 'appointmentDetails.dart';

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
    // Group appointments into physical and online
    Map<String, List<Counsel>> groupedAppointments = {
      'Physical': _appointments
          .where((appointment) => appointment.session_type == 'Physical')
          .toList(),
      'Online': _appointments
          .where((appointment) => appointment.session_type == 'Online')
          .toList(),
    };

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
          child: ListView(
            children: groupedAppointments.entries.map((entry) {
              String sessionType = entry.key;
              List<Counsel> appointments = entry.value;

              return Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Padding(
                    padding: EdgeInsets.only(
                      left: 8.0,
                      right: 8.0,
                      bottom: 8.0,
                      top: 8.0,
                    ),
                    child: Text(
                      '$sessionType Appointments'.toUpperCase(),
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
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
                                isStudent: true,
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
                                  text:
                                      appointments[i].appointment_id.toString(),
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
                                      text: appointments[i]
                                          .status
                                          .toString()
                                          .capitalizeFirstLetterOfEachWord(),
                                      style: TextStyle(
                                        fontFamily: 'Montserrat',
                                        fontSize: 14,
                                        color: _getStatusColor(appointments[i]
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
                                    appointments[i].created_on.toString())),
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
                ],
              );
            }).toList(),
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
