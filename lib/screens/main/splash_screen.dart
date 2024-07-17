import 'package:flutter/material.dart';
import 'package:unisafe/screens/authorization/login.dart';
import 'package:unisafe/screens/main/onboarding.dart';
import '../../Services/stateObserver.dart';
import '../authorization/signup.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {


  final _appStateObserver = AppStateObserver();


  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(_appStateObserver);
    super.dispose();
  }


  @override
  void initState() {
    WidgetsBinding.instance.addObserver(_appStateObserver);
    _navigateToHome();
    super.initState();

  }

  Future<void> _navigateToHome() async {
    await Future.delayed(Duration(seconds: 2));
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => Onboarding()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Image.asset(
          'assets/images/splash_image.png',
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
