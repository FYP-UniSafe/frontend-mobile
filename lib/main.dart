import 'package:flutter/material.dart';
import 'screens/splash_screen.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'UniSafe',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: 'Montserrat',
        iconTheme: IconThemeData(color: Colors.grey[600]),
        primarySwatch: Colors.blue,
      ),
      home: SplashScreen(),
    );
  }
}
