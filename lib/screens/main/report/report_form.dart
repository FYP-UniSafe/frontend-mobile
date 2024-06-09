import 'dart:developer';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';
import 'package:loading_indicator/loading_indicator.dart';
import 'package:provider/provider.dart';
import 'package:unisafe/Models/Report.dart';
import 'package:unisafe/Providers/reportProvider.dart';
import 'package:unisafe/Services/storage.dart';
import 'package:unisafe/resources/validator.dart';
import 'package:file_picker/file_picker.dart';

import '../../../Providers/selectionProvider.dart';
import '../../../Services/stateObserver.dart';
import '../../../Widgets/Flashbar/flashbar.dart';

class ReportForm extends StatefulWidget {
  const ReportForm({super.key});

  @override
  State<ReportForm> createState() => _ReportFormState();
}

class _ReportFormState extends State<ReportForm> {
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

  List<String> locations = [
    "Hall I",
    "Hall II",
    "Hall III",
    "Hall IV",
    "Hall V",
    "Hall VI",
    "Hall VII",
    "Magufuli Hostels",
    "Mabibo Hostels",
    "Kunduchi Hostels",
    "CoICT Hostels",
    "Ubungo Hostels",
    "Other"
  ];

  List<String> genders = ["Male", "Female"];
  List<String> abuses = [
    "Physical Violence",
    "Sexual Violence",
    "Psychological Violence",
    "Online Harassment"
  ];
  String? college;
  String? gender;
  String? _perpetratorGender;
  String selectedOption = '';
  String? abuse;
  String? location;
  List<File> _evidences = [];

  TextEditingController _description = TextEditingController();
  TextEditingController other_location = TextEditingController();
  TextEditingController _timeController = TextEditingController();
  final _fullName = TextEditingController();
  final _perpetrator = TextEditingController();
  final _perpetratorRelationship = TextEditingController();
  final _email = TextEditingController();
  final _phone = TextEditingController();
  final _registration = TextEditingController();
  late SelectionProvider selectionProvider;
  late LocalStorageProvider storageProvider;
  late ReportProvider reportProvider;
  String? reportDate;

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
    selectionProvider = Provider.of<SelectionProvider>(context);
    storageProvider = Provider.of<LocalStorageProvider>(context);
    reportProvider = Provider.of<ReportProvider>(context);
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
          'Report a GBV',
          style: TextStyle(
              fontSize: 20.0, fontWeight: FontWeight.bold, color: Colors.white),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              child: Form(
                key: _formKey,
                child: ListView(
                  //padding: EdgeInsets.only(top: 8.0),
                  children: [
                    if (storageProvider.user != null) ...[
                      Padding(
                        padding: EdgeInsets.only(left: 16.0, bottom: 6.0),
                        child: Text(
                          'Who are you reporting for?',
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: 8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            ConstrainedBox(
                              constraints: BoxConstraints(maxHeight: 35),
                              child: RadioListTile(
                                visualDensity:
                                    VisualDensity(horizontal: -4, vertical: -2),
                                dense: true,
                                activeColor: Color.fromRGBO(8, 100, 175, 1.0),
                                title: Text(
                                  'Myself',
                                  style: TextStyle(fontSize: 18.0),
                                ),
                                value: true,
                                groupValue: selectionProvider.isMyselfSelected,
                                onChanged: (value) {
                                  selectionProvider.isMyselfSelected = true;
                                },
                              ),
                            ),
                            ConstrainedBox(
                              constraints: BoxConstraints(maxHeight: 35),
                              child: RadioListTile(
                                visualDensity:
                                    VisualDensity(horizontal: -4, vertical: -2),
                                dense: true,
                                activeColor: Color.fromRGBO(8, 100, 175, 1.0),
                                title: Text(
                                  'Someone Else',
                                  style: TextStyle(fontSize: 18.0),
                                ),
                                value: false,
                                groupValue: selectionProvider.isMyselfSelected,
                                onChanged: (value) {
                                  selectionProvider.isMyselfSelected = false;
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                      if (selectionProvider.isMyselfSelected != null &&
                          !selectionProvider.isMyselfSelected!) ...[
                        SizedBox(
                          height: 8.0,
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
                          controller: _registration,
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
                        DropdownButtonFormField(
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
                      ],
                      Divider(
                        height: 30.0,
                        color: Color.fromRGBO(8, 100, 175, 1.0),
                      ),
                    ],
                    Padding(
                      padding: EdgeInsets.fromLTRB(16.0, 0.0, 0.0, 0.0),
                      child: Text(
                        "Description of the Abuse",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 18.0),
                      ),
                    ),
                    SizedBox(
                      height: 12.0,
                    ),
                    DropdownButtonFormField(
                      //alignment: Alignment.bottomCenter,
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      borderRadius: BorderRadius.circular(5.0),
                      icon: Icon(Icons.arrow_drop_down),
                      hint: Text('Type of Abuse'),
                      validator: (text) => TextFormValidators.chooseItems(text),
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
                      value: abuse,
                      items: abuses
                          .map((e) => DropdownMenuItem<String>(
                              value: e.toString(), child: Text(e)))
                          .toList(),
                      onChanged: (value) {
                        setState(() {
                          abuse = value;
                        });
                      },
                    ),
                    SizedBox(
                      height: 16.0,
                    ),
                    TextFormField(
                      controller: _timeController,
                      style: TextStyle(color: Colors.black),
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.symmetric(
                            horizontal: 12.0, vertical: 12.0),
                        labelText: 'Date and Time',
                        suffixIcon: Icon(Icons.calendar_today_outlined),
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
                        final DateTime? pickedDate = await showDatePicker(
                            context: context,
                            initialDate: DateTime.now(),
                            firstDate: DateTime(2000),
                            lastDate: DateTime.now(),
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
                                    onSurface: Colors.black, // body text color
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

                        if (pickedDate != null) {
                          final TimeOfDay? pickedTime = await showTimePicker(
                            builder: (context, child) {
                              return Theme(
                                data: ThemeData.light().copyWith(
                                    primaryColor:
                                        Color.fromRGBO(8, 100, 175, 1.0),
                                    hintColor: Color.fromRGBO(8, 100, 175, 1.0),
                                    colorScheme: ColorScheme.light(
                                        primary:
                                            Color.fromRGBO(8, 100, 175, 1.0)),
                                    buttonTheme: ButtonThemeData(
                                        textTheme: ButtonTextTheme.primary),
                                    textButtonTheme: TextButtonThemeData(
                                      style: TextButton.styleFrom(
                                        textStyle: TextStyle(
                                            fontWeight: FontWeight.bold),
                                        foregroundColor:
                                            Color.fromRGBO(8, 100, 175, 1.0),
                                      ),
                                    ),
                                    timePickerTheme: TimePickerThemeData(
                                      helpTextStyle: TextStyle(
                                          fontWeight: FontWeight.bold),
                                    )),
                                child: child!,
                              );
                            },
                            context: context,
                            initialTime: TimeOfDay.now(),
                          );

                          if (pickedTime != null) {
                            setState(() {
                              _timeController.text =
                                  '${_formatDateTime(pickedDate, pickedTime)}';
                            });
                          }
                        }
                      },
                    ),
                    SizedBox(
                      height: 16.0,
                    ),
                    DropdownButtonFormField(
                      //alignment: Alignment.bottomCenter,
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      borderRadius: BorderRadius.circular(5.0),
                      icon: Icon(Icons.arrow_drop_down),
                      hint: Text('Location'),
                      validator: (text) => TextFormValidators.chooseItems(text),
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
                      value: location,
                      items: locations
                          .map((e) => DropdownMenuItem<String>(
                              value: e.toString(), child: Text(e)))
                          .toList(),
                      onChanged: (value) {
                        setState(() {
                          location = value;
                        });
                      },
                    ),
                    if (location == 'Other') ...[
                      SizedBox(
                        height: 16.0,
                      ),
                      TextFormField(
                        controller: other_location,
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
                          labelText: "If location is 'other', please specify",
                        ),
                        validator: (text) =>
                            TextFormValidators.textFieldValidator(text),
                      ),
                    ],
                    SizedBox(
                      height: 16.0,
                    ),
                    TextFormField(
                      controller: _description,
                      minLines: 5,
                      maxLines: 10,
                      //textAlign: TextAlign.start,
                      style: TextStyle(color: Colors.black),
                      decoration: InputDecoration(
                        alignLabelWithHint: true,
                        contentPadding: EdgeInsets.symmetric(
                            horizontal: 12.0, vertical: 12.0),
                        labelText: 'Briefly describe what happened',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5.0),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5.0),
                          borderSide:
                              BorderSide(color: Colors.black, width: 1.1),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 16.0,
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 8.0),
                      child: Text(
                        'Evidence (if any):',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 16.0),
                      ),
                    ),
                    SizedBox(
                      height: 6.0,
                    ),
                    Row(
                      children: [
                        Padding(
                          padding: EdgeInsets.only(left: 16.0),
                          child: Text(
                            'Select a file:',
                            style: TextStyle(fontSize: 16.0),
                          ),
                        ),
                        TextButton(
                            onPressed: () async {
                              FilePickerResult? result = await FilePicker
                                  .platform
                                  .pickFiles(allowMultiple: true);

                              if (result != null) {
                                if (_evidences.isEmpty) {
                                  setState(() {
                                    _evidences = result.files
                                        .map((file) =>
                                            File(file.path.toString()))
                                        .toList();
                                  });
                                } else {
                                  setState(() {
                                    _evidences.addAll(result.files
                                        .map((file) =>
                                            File(file.path.toString()))
                                        .toList());
                                  });
                                }
                              } else {}
                            },
                            child: Text(
                              _evidences.isNotEmpty
                                  ? 'Add File'
                                  : 'Choose File',
                              style: TextStyle(
                                fontSize: 16.0,
                                color: Color.fromRGBO(8, 100, 175, 1.0),
                              ),
                            )),
                      ],
                    ),
                    if (_evidences.isNotEmpty)
                      SizedBox(
                        height: 80,
                        width: MediaQuery.of(context).size.width,
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: _evidences.length,
                          itemBuilder: (_, i) => Padding(
                            padding: EdgeInsets.all(4),
                            child: Stack(
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(8),
                                  child: Image.file(
                                    _evidences[i],
                                    width: 70,
                                    height: 70,
                                    fit: BoxFit.fill,
                                  ),
                                ),
                                Positioned(
                                  top: 0,
                                  right: 2,
                                  child: GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        _evidences.remove(_evidences[i]);
                                      });
                                    },
                                    child: Icon(
                                      CupertinoIcons.delete_solid,
                                      color: Colors.red,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    Divider(
                      height: 30.0,
                      color: Color.fromRGBO(8, 100, 175, 1.0),
                    ),
                    Padding(
                      padding: EdgeInsets.fromLTRB(16.0, 0.0, 0.0, 0.0),
                      child: Text(
                        "Perpetrator's Details",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 18.0),
                      ),
                    ),
                    SizedBox(
                      height: 12.0,
                    ),
                    TextFormField(
                      controller: _perpetrator,
                      style: TextStyle(color: Colors.black),
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.symmetric(
                            horizontal: 12.0, vertical: 12.0),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15.0),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5.0),
                          borderSide:
                              BorderSide(color: Colors.black, width: 1.1),
                        ),
                        labelText: 'Full Name',
                      ),
                    ),
                    SizedBox(
                      height: 16.0,
                    ),
                    DropdownButtonFormField(
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      borderRadius: BorderRadius.circular(5.0),
                      icon: Icon(Icons.arrow_drop_down),
                      hint: Text('Gender'),
                      validator: (text) => TextFormValidators.chooseItems(text),
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
                      value: _perpetratorGender,
                      items: genders
                          .map((e) => DropdownMenuItem<String>(
                              value: e.toString(), child: Text(e)))
                          .toList(),
                      onChanged: (value) {
                        setState(() {
                          _perpetratorGender = value;
                        });
                      },
                    ),
                    SizedBox(
                      height: 16.0,
                    ),
                    TextFormField(
                      controller: _perpetratorRelationship,
                      minLines: 3,
                      maxLines: 5,
                      //textAlign: TextAlign.start,
                      style: TextStyle(color: Colors.black),
                      decoration: InputDecoration(
                        alignLabelWithHint: true,
                        contentPadding: EdgeInsets.symmetric(
                            horizontal: 12.0, vertical: 12.0),
                        labelText:
                            'Describe your relationship with the perpetrator',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15.0),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5.0),
                          borderSide:
                              BorderSide(color: Colors.black, width: 1.1),
                        ),
                      ),
                    ),
                    Divider(
                      height: 30.0,
                      color: Color.fromRGBO(8, 100, 175, 1.0),
                    ),
                    Padding(
                      padding: EdgeInsets.fromLTRB(16.0, 0.0, 0.0, 0.0),
                      child: Text(
                        "Counselling Services",
                        textAlign: TextAlign.start,
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 18.0),
                      ),
                    ),
                    SizedBox(
                      height: 4.0,
                    ),
                    Padding(
                      padding: EdgeInsets.fromLTRB(16, 0, 0, 0),
                      child: Text(
                        'Are you in need of counselling services?',
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
                            'Yes',
                            style: TextStyle(fontSize: 18.0),
                          ),
                          value: 'yes',
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
                            'No',
                            style: TextStyle(fontSize: 18.0),
                          ),
                          value: 'no',
                          groupValue: selectedOption,
                          onChanged: (value) {
                            setState(() {
                              selectedOption = value.toString();
                            });
                          }),
                    ),
                    if (selectedOption == 'yes') ...[
                      Padding(
                        padding: EdgeInsets.only(
                            left: 16.0, top: 0.0, right: 16.0, bottom: 0.0),
                        child: Text(
                          "After submitting head over to the 'Seek Counsel' page to book an appointment",
                          style: TextStyle(fontSize: 16.0),
                        ),
                      )
                    ],
                    SizedBox(
                      height: 10.0,
                    ),
                    SafeArea(
                      bottom: true,
                      top: false,
                      child: ElevatedButton(
                        onPressed: _report,
                        style: ElevatedButton.styleFrom(
                          foregroundColor: Colors.white,
                          backgroundColor: Color.fromRGBO(8, 100, 175, 1.0),
                          padding: EdgeInsets.all(12.0),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5.0),
                          ),
                        ),
                        child: Text(
                          'Submit',
                          style: TextStyle(
                              fontSize: 18.0, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  String _formatDateTime(DateTime date, TimeOfDay time) {
    final formattedDate = DateFormat('yyyy-MM-ddT').format(date);
    final formattedTime =
        '${time.hour}:${time.minute < 10 ? '0${time.minute}' : time.minute}';
    setState(() {
      reportDate = "$formattedDate$formattedTime";
    });
    return "${DateFormat('dd/MM/yyyy').format(date)} | $formattedTime";
  }

  _report() async {
    if (_formKey.currentState!.validate()) {
      if (abuse != null &&
          _timeController.text.isNotEmpty &&
          location != null &&
          //other_location.text.isNotEmpty &&
          reportDate != null &&
          _description.text.isNotEmpty &&
          _perpetratorGender != null &&
          _perpetrator.text.isNotEmpty &&
          _perpetratorRelationship.text.isNotEmpty) {
        showDialog(
            context: context,
            barrierDismissible: false,
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

        if (storageProvider.user != null) {
          if (selectionProvider.isMyselfSelected != null &&
              selectionProvider.isMyselfSelected!) {
            await reportProvider.createReport(
                report: Report(
                    abuse_type: abuse,
                    location: location,
                    other_location: location == 'Other'
                        ? other_location.text.toString()
                        : location,
                    gender: storageProvider.user!.gender,
                    description: _description.text,
                    perpetrator_fullname: _perpetrator.text,
                    perpetrator_gender: _perpetratorGender,
                    full_name: storageProvider.user!.full_name,
                    reg_no: storageProvider.user!.reg_no,
                    phone_number: storageProvider.user!.phone_number,
                    email: storageProvider.user!.email,
                    college: storageProvider.user!.college,
                    dateTime: reportDate,
                    relationship: _perpetratorRelationship.text,
                    evidence: _evidences,
                    report_for: "Self"));
          } else {
            if (_fullName.text.isNotEmpty &&
                _phone.text.isNotEmpty &&
                gender != null &&
                _registration.text.isNotEmpty &&
                college != null &&
                _email.text.isNotEmpty) {
              await reportProvider.createReport(
                  report: Report(
                      abuse_type: abuse,
                      location: location,
                      other_location: location == 'Other'
                          ? other_location.text.toString()
                          : location,
                      description: _description.text,
                      perpetrator_fullname: _perpetrator.text,
                      perpetrator_gender: _perpetratorGender,
                      full_name: _fullName.text,
                      phone_number: _phone.text,
                      reg_no: _registration.text,
                      email: _email.text,
                      college: college,
                      gender: gender,
                      dateTime: reportDate,
                      relationship: _perpetratorRelationship.text,
                      evidence: _evidences,
                      report_for: "Else"));
            }
          }
        } else {
          await reportProvider.createAnonymousReport(
              report: Report(
                  abuse_type: abuse,
                  location: location,
                  other_location: location == 'Other'
                      ? other_location.text.toString()
                      : location,
                  description: _description.text,
                  perpetrator_fullname: _perpetrator.text,
                  perpetrator_gender: _perpetratorGender,
                  dateTime: reportDate,
                  relationship: _perpetratorRelationship.text,
                  evidence: _evidences));
        }

        if (reportProvider.isReported != null &&
            reportProvider.isReported == true) {
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
              'Report Submitted Successfully',
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
              'Report Submission Failed',
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
