import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:provider/provider.dart';
import 'package:unisafe/Providers/profileProvider.dart';
import 'package:unisafe/screens/authorization/login.dart';
import 'package:unisafe/screens/main/main_screen.dart';
import 'package:unisafe/screens/main/onboarding.dart';
import 'Providers/authProvider.dart';
import 'Services/storage.dart';

Widget? _landingPage;

final storageProvider = LocalStorageProvider();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  dotenv.load(fileName: ".env");
  await Future.wait([initializeApp(), storageProvider.initialize()]);
  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(create: (context) => AuthProvider()),
    ChangeNotifierProvider(create: (context) => ProfileTypeProvider()),
    ChangeNotifierProvider.value(value: storageProvider),
  ], child: UniSafe()));
}

Future<void> initializeApp() async {
  try {
    late bool session;
    session = await LocalStorage.checkSession();
    if (!await LocalStorage.getOnboarding()) {
      _landingPage = const Onboarding();
    } else {
      if (session) {
        _landingPage = const MainScreen();
      } else {
        _landingPage = const Login();
      }
    }
  } catch (e) {
    _landingPage = Login();
  }
}

class UniSafe extends StatelessWidget {
  const UniSafe({super.key});

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    return MaterialApp(
      title: 'UniSafe',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        appBarTheme: AppBarTheme(
          color: Color.fromRGBO(8, 100, 175, 1.0),
          centerTitle: true,
          /*titleTextStyle: TextStyle(
              color: Colors.black,
              fontFamily: 'Montserrat',
              fontSize: 28,
              fontWeight: FontWeight.w100),*/
        ),
        fontFamily: 'Montserrat',
        iconTheme: IconThemeData(color: Colors.grey[600]),
        textSelectionTheme: TextSelectionThemeData(
          cursorColor: Colors.black,
        ),
        inputDecorationTheme: InputDecorationTheme(
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: Colors.black,
            ),
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.black),
          ),
          floatingLabelBehavior: FloatingLabelBehavior.never,
        ),
        //primarySwatch: Colors.blue,
        listTileTheme: ListTileThemeData(
          horizontalTitleGap: 4,
        ),
      ),
      routes: {
        '/option1Page': (context) => MainScreen(),
      },
      home: _landingPage,
    );
  }
}
