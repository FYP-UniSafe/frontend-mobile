import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:unisafe/screens/main/counsel/counsel_page.dart';
import 'package:unisafe/screens/main/cu_dashboard.dart';
import 'package:unisafe/screens/main/gd_dashboard.dart';
import 'package:unisafe/screens/main/homepage.dart';
import 'package:unisafe/screens/main/pf_dashboard.dart';
import 'package:unisafe/screens/profile/profile_page.dart';
import 'package:unisafe/screens/main/report/report_page.dart';

import '../../Models/User.dart';
import '../../Services/stateObserver.dart';
import '../../Services/storage.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  List _pages = [];
  List _titles = [];

  User? user;
  int currentSelectedIndex = 0;
  late LocalStorageProvider _storageProvider;

  void updateCurrentIndex(int index) {
    setState(() {
      currentSelectedIndex = index;
    });
  }

  final _appStateObserver = AppStateObserver();
  @override
  void initState() {
    WidgetsBinding.instance.addObserver(_appStateObserver);
    _storageProvider =
        Provider.of<LocalStorageProvider>(context, listen: false);
    _initializePages();

    super.initState();
  }

  @override
  void didChangeDependencies() {
    _storageProvider = Provider.of<LocalStorageProvider>(context);
    _initializePages();
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(_appStateObserver);
    super.dispose();
  }

  Future<void> _initializePages() async {


    try{
      user = _storageProvider.user;
      if (user?.is_genderdesk == true) {
        _pages = [
          GDDashboard(),
          ProfilePage(),
        ];

        _titles = [
          'UniSafe',
          'Profile',
        ];
        if (currentSelectedIndex > _pages.length) {
          currentSelectedIndex = 0;
        }
      } else if (user?.is_consultant == true) {
        _pages = [
          CUDashboard(),
          ProfilePage(),
        ];
        _titles = [
          'UniSafe',
          'Profile',
        ];
      } else if (user?.is_police == true) {
        _pages = [
          PFDashboard(),
          ProfilePage(),
        ];
        _titles = [
          'UniSafe',
          'Profile',
        ];
      } else {
        _pages = [
          HomePage(),
          ReportPage(),
          CounselPage(),
          ProfilePage(),
        ];
        _titles = [
          'UniSafe',
          'Report a GBV',
          'Seek Counsel',
          'Profile',
        ];
        if (currentSelectedIndex > _pages.length) {
          currentSelectedIndex = 0;
        }
      }
    }catch(e){
      _pages = [
        HomePage(),
        ReportPage(),
        CounselPage(),
        ProfilePage(),
      ];
      _titles = [
        'UniSafe',
        'Report a GBV',
        'Seek Counsel',
        'Profile',
      ];
      if (currentSelectedIndex > _pages.length) {
        currentSelectedIndex = 0;
      }
    }
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
          if (user!=null?(user!.is_student??false):true)
            BottomNavigationBarItem(
                icon: Icon(
                  Icons.report,
                  size: 26.0,
                ),
                label: 'Report a GBV'),
          if (user!=null?(user!.is_student??false):true)
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
