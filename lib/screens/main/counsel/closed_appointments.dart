import 'package:flutter/material.dart';

import '../../../Services/stateObserver.dart';

class ClosedAppointments extends StatefulWidget {
  const ClosedAppointments({super.key});

  @override
  State<ClosedAppointments> createState() => _ClosedAppointmentsState();
}

class _ClosedAppointmentsState extends State<ClosedAppointments> {


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
