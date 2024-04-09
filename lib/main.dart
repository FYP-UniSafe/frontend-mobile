import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:unisafe/resources/provider_model.dart';
import 'package:unisafe/screens/main/main_screen.dart';
import 'package:unisafe/screens/main/onboarding.dart';
import 'package:unisafe/screens/profile/profile_page.dart';
import 'screens/main/splash_screen.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => ProfileTypeProvider(),
      child: MaterialApp(
        title: '',
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
        home: Onboarding(),
      ),
    );
  }
}
