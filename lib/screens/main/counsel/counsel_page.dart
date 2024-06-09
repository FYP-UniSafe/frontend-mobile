import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:unisafe/Services/storage.dart';
import 'package:unisafe/screens/main/counsel/all_appointments.dart';
import 'package:unisafe/screens/main/counsel/book_counsel.dart';

import '../../../Models/User.dart';
import '../../../Services/stateObserver.dart';

class CounselPage extends StatefulWidget {
  const CounselPage({super.key});

  @override
  State<CounselPage> createState() => _CounselPageState();
}

class _CounselPageState extends State<CounselPage> {
  final _appStateObserver = AppStateObserver();
  late LocalStorageProvider _storageProvider;
  late User _user;
  @override
  void initState() {
    WidgetsBinding.instance.addObserver(_appStateObserver);
    super.initState();
  }

  @override
  void didChangeDependencies() {
    _storageProvider = Provider.of<LocalStorageProvider>(context);
    try {
      _user = _storageProvider.user!;
    } catch (e) {}
    super.didChangeDependencies();
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
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(
                'LEGAL AND PSYCHOLOGICAL SERVICES',
                style: TextStyle(fontSize: 18.0),
              ),
              Divider(
                height: 30.0,
                color: Color.fromRGBO(8, 100, 175, 1.0),
              ),
              Text(
                'Welcome to our counselling services, a safe space where your journey towards healing begins. We understand the courage it takes to seek support, and we’re here to offer compassionate guidance as you navigate your healing process.',
                style: TextStyle(fontSize: 16.0),
              ),
              Container(
                color: Color.fromRGBO(255, 255, 255, 1.0),
                child: Image.asset(
                  'assets/images/counsel.png',
                  height: MediaQuery.of(context).size.height * 0.2,
                ),
              ),
              Text(
                'Our dedicated team is committed to providing you with confidential, non-judgmental support tailored to your needs. Please feel free to schedule a meeting at your convenience.',
                style: TextStyle(fontSize: 16.0),
              ),
              SizedBox(
                height: 16.0,
              ),
              if (_storageProvider.user != null)
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () => Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (BuildContext context) => BookCounsel(),
                      ),
                    ),
                    style: ElevatedButton.styleFrom(
                      elevation: 3,
                      backgroundColor: Color.fromRGBO(8, 100, 175, 1.0),
                      /*side: BorderSide(
                      width: 1.0,
                      color: Color.fromRGBO(8, 100, 175, 1.0),
                    ),*/
                      padding: EdgeInsets.all(12.0),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5.0),
                      ),
                    ),
                    child: Text(
                      'Book Session Here',
                      style: TextStyle(
                        fontSize: 18.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              SizedBox(
                height: 20.0,
              ),
              Text(
                'APPOINTMENTS',
                style: TextStyle(fontSize: 18.0),
              ),
              Divider(
                height: 30.0,
                color: Color.fromRGBO(8, 100, 175, 1.0),
              ),
              Text(
                'View scheduled appointments',
                style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 10.0,
              ),
              Text(
                'You can get help to know more about what to do if you or someone you know has been harassed.',
                style: TextStyle(fontSize: 16.0),
              ),
              SizedBox(
                height: 10.0,
              ),
              Container(
                color: Color.fromRGBO(255, 255, 255, 1.0),
                child: Image.asset(
                  'assets/images/appointments.png',
                  height: MediaQuery.of(context).size.height * 0.2,
                  width: double.infinity,
                ),
              ),
              if (_storageProvider.user != null) ...[
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      elevation: 3,
                      backgroundColor: Color.fromRGBO(8, 100, 175, 1.0),
                      foregroundColor: Colors.white,
                      /*side: BorderSide(
                          width: 1.0,
                          color: Color.fromRGBO(8, 100, 175, 1.0),
                        ),*/
                      padding: EdgeInsets.all(12.0),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5.0),
                      ),
                    ),
                    child: Row(
                      children: [
                        Expanded(
                          child: Align(
                            alignment: Alignment.center,
                            child: Text(
                              'All Appointments',
                              style: TextStyle(
                                  fontSize: 17, fontWeight: FontWeight.normal),
                            ),
                          ),
                        ),
                        Icon(
                          Icons.arrow_forward_ios,
                          size: 20.0,
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: 12.0,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.45,
                      child: ElevatedButton(
                        onPressed: () {},
                        style: ElevatedButton.styleFrom(
                          elevation: 3,
                          backgroundColor: Color.fromRGBO(8, 100, 175, 1.0),
                          foregroundColor: Colors.white,
                          /*side: BorderSide(
                          width: 1.0,
                          color: Color.fromRGBO(8, 100, 175, 1.0),
                        ),*/
                          padding: EdgeInsets.all(12.0),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5.0),
                          ),
                        ),
                        child: Row(
                          children: [
                            Expanded(
                              child: Align(
                                alignment: Alignment.center,
                                child: Text(
                                  'Open',
                                  style: TextStyle(
                                      fontSize: 17,
                                      fontWeight: FontWeight.normal),
                                ),
                              ),
                            ),
                            Icon(
                              Icons.arrow_forward_ios,
                              size: 20.0,
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.45,
                      child: ElevatedButton(
                        onPressed: () {},
                        style: ElevatedButton.styleFrom(
                          elevation: 3,
                          backgroundColor: Color.fromRGBO(8, 100, 175, 1.0),
                          foregroundColor: Colors.white,
                          /*side: BorderSide(
                          width: 1.0,
                          color: Color.fromRGBO(8, 100, 175, 1.0),
                        ),*/
                          padding: EdgeInsets.all(12.0),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5.0),
                          ),
                        ),
                        child: Row(
                          children: [
                            Expanded(
                              child: Align(
                                alignment: Alignment.center,
                                child: Text(
                                  'Closed',
                                  style: TextStyle(
                                      fontSize: 17,
                                      fontWeight: FontWeight.normal),
                                ),
                              ),
                            ),
                            Icon(
                              Icons.arrow_forward_ios,
                              size: 20.0,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ]
            ],
          ),
        ),
      ),
    );
  }
}
