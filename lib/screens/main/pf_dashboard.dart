import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../Providers/reportProvider.dart';

class PFDashboard extends StatefulWidget {
  const PFDashboard({super.key});

  @override
  State<PFDashboard> createState() => _PFDashboardState();
}

class _PFDashboardState extends State<PFDashboard> {
  @override
  Widget build(BuildContext context) {
    final reportProvider = Provider.of<ReportProvider>(context);
    final policeReports = reportProvider.getReportsForwardedToPolice();
    return Scaffold(
      body: policeReports.isEmpty
          ? Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.hourglass_empty,
                  size: 32,
                  color: Color.fromRGBO(8, 100, 175, 0.6),
                ),
                Text('No reports'),
              ],
            )
          : ListView.builder(
              itemCount: policeReports.length,
              itemBuilder: (context, index) {
                final report = policeReports[index];
                return ListTile(
                  title: Text(report.abuse_type.toString()),
                  subtitle: Text(report.description.toString()),
                  onTap: () {
                    // Navigate to the report details page
                  },
                );
              },
            ),
    );
  }
}
