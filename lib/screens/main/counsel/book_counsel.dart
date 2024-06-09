import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:loading_indicator/loading_indicator.dart';
import 'package:provider/provider.dart';
import 'package:unisafe/Providers/counselProvider.dart';
import 'package:unisafe/Services/storage.dart';
import 'package:unisafe/resources/validator.dart';

import '../../../Models/Counsel.dart';
import '../../../Models/User.dart';
import '../../../Services/stateObserver.dart';
import '../../../Widgets/Flashbar/flashbar.dart';

class BookCounsel extends StatefulWidget {
  const BookCounsel({super.key});

  @override
  State<BookCounsel> createState() => _BookCounselState();
}

class _BookCounselState extends State<BookCounsel> {
  final _formKey = GlobalKey<FormState>();
  List<String> colleges = [
    "CoSS",
    "CoICT",
    "CoET",
    "CoNAS",
    "CoHU",
    "CoAF",
    "MUCE",
    "DUCE",
    "MCHAS",
    "SoED",
    "UDBS",
    "UDSoL",
    "SJMC",
    "UDSE",
    "SoMG",
    "SoAF",
    "Other"
  ];
  List<String> genders = ["Male", "Female"];

  String? college;
  String? gender;
  String? selectedOption;
  TextEditingController _dateController = TextEditingController();
  TextEditingController _fullName = TextEditingController();
  TextEditingController _phone = TextEditingController();
  TextEditingController _email = TextEditingController();
  TextEditingController _reg_no = TextEditingController();
  late CounselProvider counselProvider;
  late LocalStorageProvider storageProvider;
  late User _user;

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
  void didChangeDependencies() {
    counselProvider = Provider.of<CounselProvider>(context);
    storageProvider = Provider.of<LocalStorageProvider>(context);
    try {
      _user = storageProvider.user!;
      if (_user.full_name != null) {
        _fullName = TextEditingController(text: _user.full_name);
      }
      if (_user.phone_number != null) {
        _phone = TextEditingController(text: _user.phone_number);
      }
      if (_user.email != null) {
        _email = TextEditingController(text: _user.email);
      }
      if (_user.reg_no != null) {
        _reg_no = TextEditingController(text: _user.reg_no);
      }
      if (_user.gender != null) {
        gender = _user.gender;
      }
    } catch (e) {
      log(e.toString());
    }

    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(
            Icons.arrow_back_ios,
            size: 20.0,
            color: Colors.white,
          ),
        ),
        title: Text(
          'Book Session',
          style: TextStyle(
              fontSize: 20.0, fontWeight: FontWeight.bold, color: Colors.white),
        ),
      ),
      body: SizedBox(
        height: MediaQuery.of(context).size.height * 0.98,
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            children: [
              Expanded(
                child: Form(
                  key: _formKey,
                  child: ListView(
                    children: [
                      Align(
                        alignment: Alignment.center,
                        child: Text(
                          'Request an Appointment',
                          style: TextStyle(
                              fontSize: 18.0, fontWeight: FontWeight.bold),
                        ),
                      ),
                      Divider(
                        height: 30.0,
                        color: Color.fromRGBO(8, 100, 175, 1.0),
                      ),
                      TextFormField(
                        controller: _fullName,
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        style: TextStyle(color: Colors.black),
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.symmetric(
                              horizontal: 12.0, vertical: 12.0),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5.0),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5.0),
                            borderSide:
                                BorderSide(color: Colors.black, width: 1.1),
                          ),
                          labelText: 'Full Name',
                        ),
                        validator: (text) =>
                            TextFormValidators.textFieldValidator(text),
                      ),
                      SizedBox(
                        height: 16.0,
                      ),
                      TextFormField(
                        controller: _phone,
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        style: TextStyle(color: Colors.black),
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.symmetric(
                              horizontal: 12.0, vertical: 12.0),
                          labelText: 'Phone Number',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5.0),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5.0),
                            borderSide:
                                BorderSide(color: Colors.black, width: 1.1),
                          ),
                        ),
                        validator: (text) =>
                            TextFormValidators.phoneValidator(text!),
                      ),
                      SizedBox(
                        height: 16.0,
                      ),
                      DropdownButtonFormField(
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        borderRadius: BorderRadius.circular(5.0),
                        icon: Icon(Icons.arrow_drop_down),
                        hint: Text('Gender'),
                        validator: (text) =>
                            TextFormValidators.chooseItems(text),
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.symmetric(
                              horizontal: 12.0, vertical: 12.0),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5.0),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5.0),
                            borderSide:
                                BorderSide(color: Colors.black, width: 1.3),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5.0),
                          ),
                        ),
                        value: gender,
                        items: genders
                            .map((e) => DropdownMenuItem<String>(
                                value: e.toString(), child: Text(e)))
                            .toList(),
                        onChanged: (value) {
                          setState(() {
                            gender = value;
                          });
                        },
                      ),
                      SizedBox(
                        height: 16.0,
                      ),
                      TextFormField(
                        controller: _email,
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        style: TextStyle(color: Colors.black),
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.symmetric(
                              horizontal: 12.0, vertical: 12.0),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5.0),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5.0),
                            borderSide:
                                BorderSide(color: Colors.black, width: 1.1),
                          ),
                          labelText: 'Email',
                        ),
                        validator: (text) =>
                            TextFormValidators.emailValidator(text!),
                      ),
                      SizedBox(
                        height: 16.0,
                      ),
                      TextFormField(
                        controller: _reg_no,
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        style: TextStyle(color: Colors.black),
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.symmetric(
                              horizontal: 12.0, vertical: 12.0),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5.0),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5.0),
                            borderSide:
                                BorderSide(color: Colors.black, width: 1.1),
                          ),
                          labelText: 'Registration Number',
                        ),
                        validator: (text) =>
                            TextFormValidators.studentIDValidator(text),
                      ),
                      SizedBox(
                        height: 16.0,
                      ),
                      /* DropdownButtonFormField(
                        //alignment: Alignment.bottomCenter,
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        borderRadius: BorderRadius.circular(5.0),
                        icon: Icon(Icons.arrow_drop_down),
                        hint: Text('College / School'),
                        validator: (text) =>
                            TextFormValidators.chooseItems(text),
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.symmetric(
                              horizontal: 12.0, vertical: 12.0),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5.0),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.black, width: 1.3),
                            borderRadius: BorderRadius.circular(5.0),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5.0),
                          ),
                        ),
                        value: college,
                        items: colleges
                            .map((e) => DropdownMenuItem<String>(
                                value: e.toString(), child: Text(e)))
                            .toList(),
                        onChanged: (value) {
                          setState(() {
                            college = value;
                          });
                        },
                      ),
                      SizedBox(
                        height: 16.0,
                      ),*/
                      TextFormField(
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        controller: _dateController,
                        style: TextStyle(color: Colors.black),
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.symmetric(
                              horizontal: 12.0, vertical: 12.0),
                          labelText: 'Select an Appointment Date',
                          suffixIcon: Icon(Icons.calendar_month_outlined),
                          enabledBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.black, width: 1.3),
                            borderRadius: BorderRadius.circular(5.0),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5.0),
                          ),
                        ),
                        readOnly: true,
                        onTap: () async {
                          final DateTime? _picked = await showDatePicker(
                              context: context,
                              initialDate: DateTime.now(),
                              firstDate: DateTime.now(),
                              lastDate: DateTime(2100),
                              builder: (context, child) {
                                return Theme(
                                  data: Theme.of(context).copyWith(
                                    textTheme: TextTheme(
                                        bodyMedium: TextStyle(
                                            fontWeight: FontWeight.bold)),
                                    colorScheme: ColorScheme.light(
                                      primary: Color.fromRGBO(8, 100, 175,
                                          1.0), // header background color
                                      onPrimary:
                                          Colors.white, // header text color
                                      onSurface:
                                          Colors.black, // body text color
                                    ),
                                    datePickerTheme: DatePickerThemeData(
                                        weekdayStyle: TextStyle(
                                            fontWeight: FontWeight.w700,
                                            color: Colors.black)),
                                    textButtonTheme: TextButtonThemeData(
                                      style: TextButton.styleFrom(
                                        textStyle: TextStyle(
                                            fontWeight: FontWeight.bold),
                                        foregroundColor:
                                            Color.fromRGBO(8, 100, 175, 1.0),
                                      ),
                                    ),
                                  ),
                                  child: child!,
                                );
                              });

                          if (_picked != null) {
                            setState(() {
                              _dateController.text = '${_selectDate(_picked)}';
                            });
                          }
                        },
                        validator: (text) =>
                            TextFormValidators.textFieldValidator(text),
                      ),
                      SizedBox(
                        height: 16.0,
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: 8.0),
                        child: Text(
                          'Preferred Session Type:',
                          style: TextStyle(
                              fontSize: 18.0, fontWeight: FontWeight.w500),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: 10.0),
                        child: RadioListTile(
                            visualDensity:
                                VisualDensity(horizontal: -4, vertical: -4),
                            dense: true,
                            activeColor: Color.fromRGBO(8, 100, 175, 1.0),
                            title: Text(
                              'Physical',
                              style: TextStyle(fontSize: 18.0),
                            ),
                            value: 'Physical',
                            groupValue: selectedOption,
                            onChanged: (value) {
                              setState(() {
                                selectedOption = value.toString();
                              });
                            }),
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: 10.0),
                        child: RadioListTile(
                            visualDensity:
                                VisualDensity(horizontal: -4, vertical: -4),
                            dense: true,
                            activeColor: Color.fromRGBO(8, 100, 175, 1.0),
                            title: Text(
                              'Online',
                              style: TextStyle(fontSize: 18.0),
                            ),
                            value: 'Online',
                            groupValue: selectedOption,
                            onChanged: (value) {
                              setState(() {
                                selectedOption = value.toString();
                              });
                            }),
                      ),
                      SizedBox(
                        height: 20.0,
                      ),
                      SafeArea(
                        bottom: true,
                        top: false,
                        child: ElevatedButton(
                          onPressed: _book,
                          style: ElevatedButton.styleFrom(
                            foregroundColor: Colors.white,
                            backgroundColor: Color.fromRGBO(8, 100, 175, 1.0),
                            padding: EdgeInsets.all(12.0),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5.0),
                            ),
                          ),
                          child: Text(
                            'Book',
                            style: TextStyle(
                                fontSize: 18.0, fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  String _selectDate(DateTime date) {
    DateFormat('YYYY-MM-DD').format(date);
    return "${DateFormat('yyyy-MM-dd').format(date)}";
  }

  _book() async {
    if (_formKey.currentState!.validate()) {
      showDialog(
          context: context,
          barrierDismissible: true,
          builder: (BuildContext context) {
            return Dialog(
              backgroundColor: Colors.transparent,
              elevation: 0,
              child: Container(
                height: 100,
                width: 100,
                alignment: Alignment.center,
                child: LoadingIndicator(
                  indicatorType: Indicator.ballPulseRise,
                  colors: [Color.fromRGBO(8, 100, 175, 1.0)],
                ),
              ),
            );
          });
      if (selectedOption != null &&
          gender != null &&
          _phone.text.isNotEmpty &&
          _email.text.isNotEmpty &&
          _reg_no.text.isNotEmpty &&
          _fullName.text.isNotEmpty &&
          _dateController.text.isNotEmpty) {
        await counselProvider.requestAppointment(
            appointment: Counsel(
          student_full_name: _fullName.text,
          student_phone: _phone.text,
          student_email: _email.text,
          student_reg_no: _reg_no.text,
          student_gender: gender,
          date: _dateController.text,
          session_type: selectedOption,
        ));
        if (counselProvider.isRequested != null &&
            counselProvider.isRequested == true) {
          await Flashbar(
            flashbarPosition: FlashbarPosition.TOP,
            borderRadius: BorderRadius.circular(5),
            backgroundColor: Colors.green,
            icon: Icon(
              CupertinoIcons.check_mark_circled,
              color: Colors.white,
              size: 32,
            ),
            titleText: Text(
              'Success',
              style: TextStyle(
                  color: Colors.white,
                  fontFamily: 'Poppins',
                  fontSize: 18,
                  fontWeight: FontWeight.w500),
            ),
            messageText: Text(
              'Appointment Request Successful',
              style: TextStyle(
                  color: Colors.white,
                  fontFamily: 'Poppins',
                  fontSize: 16,
                  fontWeight: FontWeight.w500),
            ),
            duration: Duration(seconds: 3),
          ).show(context);
          Navigator.pop(context);
          Navigator.pop(context);
        } else {
          Navigator.pop(context);
          Flashbar(
            flashbarPosition: FlashbarPosition.TOP,
            borderRadius: BorderRadius.circular(5),
            backgroundColor: Colors.red,
            icon: Icon(
              CupertinoIcons.exclamationmark_triangle,
              color: Colors.white,
              size: 32,
            ),
            titleText: Text(
              'Alert',
              style: TextStyle(
                  color: Colors.white,
                  fontFamily: 'Poppins',
                  fontSize: 18,
                  fontWeight: FontWeight.w500),
            ),
            messageText: Text(
              'Appointment Request Failed',
              style: TextStyle(
                  color: Colors.white,
                  fontFamily: 'Poppins',
                  fontSize: 16,
                  fontWeight: FontWeight.w500),
            ),
            duration: Duration(seconds: 3),
          ).show(context);
        }
      }
    }
  }
}
