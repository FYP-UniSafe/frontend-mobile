import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:unisafe/screens/main/counsel/counsel_page.dart';
import 'package:unisafe/screens/main/dashboard.dart';
import 'package:unisafe/screens/main/homepage.dart';
import 'package:unisafe/screens/profile/profile_page.dart';
import 'package:unisafe/screens/main/report/report_page.dart';

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
    final user = _storageProvider.user;
    if (user?.is_genderdesk == true) {
      _pages = [
        Dashboard(),
        ProfilePage(),
      ];

      _titles = [
        'UniSafe',
        'Profile',
      ];
      if (currentSelectedIndex > _pages.length) {
        currentSelectedIndex = 0;
      }
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
          if (!_isGenderDesk()!)
            BottomNavigationBarItem(
                icon: Icon(
                  Icons.report,
                  size: 26.0,
                ),
                label: 'Report a GBV'),
          if (!_isGenderDesk()!)
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

  bool? _isGenderDesk() {
    final user = _storageProvider.user;
    if (user != null) {
      return user.is_genderdesk;
    }
    return false;
  }
}
