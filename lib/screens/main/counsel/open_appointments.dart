import 'package:flutter/material.dart';

import '../../../Services/stateObserver.dart';

class OpenAppointments extends StatefulWidget {
  const OpenAppointments({super.key});

  @override
  State<OpenAppointments> createState() => _OpenAppointmentsState();
}

class _OpenAppointmentsState extends State<OpenAppointments> {


  final _appStateObserver = AppStateObserver();
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
    return Scaffold();
  }
}
