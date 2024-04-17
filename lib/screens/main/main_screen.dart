import 'package:flutter/material.dart';
import 'package:unisafe/screens/main/counsel/counsel_page.dart';
import 'package:unisafe/screens/main/homepage.dart';
import 'package:unisafe/screens/profile/profile_page.dart';
import 'package:unisafe/screens/main/report/report_page.dart';

import '../../Services/stateObserver.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  List _pages = [
    HomePage(),
    ReportPage(),
    CounselPage(),
    ProfilePage(),
  ];
  List _titles = [
    'UniSafe',
    'Report a GBV',
    'Seek Counsel',
    'Profile',
  ];

  int currentSelectedIndex = 0;

  void updateCurrentIndex(int index) {
    setState(() {
      currentSelectedIndex = index;
    });

    /*switch (index) {
        case 0:
          // Navigate to the Home page
          break;
        case 1:
          // Navigate to the Report a GBV page
          break;
        case 2:
          // Navigate to the Settings page
          break;
        case 3:
          // Navigate to the Profile page
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => ProfilePage()));
          break;
      }*/
  }

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
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text(
          _titles[currentSelectedIndex],
          style: TextStyle(
              fontWeight: FontWeight.bold, fontSize: 20.0, color: Colors.white),
        ),
      ),
      body: _pages[currentSelectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        fixedColor: Color.fromRGBO(8, 100, 175, 1.0),
        onTap: updateCurrentIndex,
        currentIndex: currentSelectedIndex,
        showSelectedLabels: true,
        showUnselectedLabels: true,
        type: BottomNavigationBarType.fixed,
        items: [
          BottomNavigationBarItem(
              icon: Icon(
                Icons.home,
                size: 26.0,
              ),
              label: 'Home'),
          BottomNavigationBarItem(
              icon: Icon(
                Icons.report,
                size: 26.0,
              ),
              label: 'Report a GBV'),
          BottomNavigationBarItem(
              icon: Icon(
                Icons.assistant,
                size: 26.0,
              ),
              label: 'Seek Counsel'),
          BottomNavigationBarItem(
              icon: Icon(
                Icons.person,
                size: 26.0,
              ),
              label: 'Profile'),
        ],
      ),
    );
  }
}
