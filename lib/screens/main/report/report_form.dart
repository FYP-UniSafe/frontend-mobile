import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:unisafe/resources/validator.dart';
import 'package:file_picker/file_picker.dart';

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
    "Cyber Violence"
  ];
  String? college;
  String? gender;
  String selectedOption = '';
  String? abuse;
  String? location;

  TextEditingController _dateController = TextEditingController();
  TextEditingController _timeController = TextEditingController();
  final _fullName = TextEditingController();
  final _email = TextEditingController();
  final _phone = TextEditingController();
  final _registration = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.98,
      child: Scaffold(
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
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
                color: Colors.white),
          ),
        ),
        body: Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                child: SizedBox(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height * 0.9,
                  child: Form(
                    key: _formKey,
                    child: ListView(
                      padding: EdgeInsets.only(top: 8.0),
                      children: [
                        Padding(
                          padding: EdgeInsets.fromLTRB(16.0, 0.0, 0.0, 0.0),
                          child: Text(
                            "1. Victim's Details",
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 18.0),
                          ),
                        ),
                        SizedBox(
                          height: 12.0,
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
                        Divider(
                          height: 30.0,
                          color: Color.fromRGBO(8, 100, 175, 1.0),
                        ),
                        Padding(
                          padding: EdgeInsets.fromLTRB(16.0, 0.0, 0.0, 0.0),
                          child: Text(
                            "2. Description of the Abuse",
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
                            );

                            if (pickedDate != null) {
                              final TimeOfDay? pickedTime =
                                  await showTimePicker(
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
                        SizedBox(
                          height: 16.0,
                        ),
                        TextFormField(
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
                        ),
                        SizedBox(
                          height: 16.0,
                        ),
                        TextFormField(
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
                                  FilePickerResult? result =
                                      await FilePicker.platform.pickFiles();

                                  if (result != null) {
                                  } else {}
                                },
                                child: Text(
                                  'Choose File',
                                  style: TextStyle(
                                    fontSize: 16.0,
                                    color: Color.fromRGBO(8, 100, 175, 1.0),
                                  ),
                                ))
                          ],
                        ),
                        Divider(
                          height: 30.0,
                          color: Color.fromRGBO(8, 100, 175, 1.0),
                        ),
                        Padding(
                          padding: EdgeInsets.fromLTRB(16.0, 0.0, 0.0, 0.0),
                          child: Text(
                            "3. Perpetrator's Details",
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 18.0),
                          ),
                        ),
                        SizedBox(
                          height: 12.0,
                        ),
                        TextFormField(
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
                            "4. Counselling Services",
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 18.0),
                          ),
                        ),
                        SizedBox(
                          height: 4.0,
                        ),
                        Padding(
                          padding: EdgeInsets.only(left: 38.0),
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
                          height: 20.0,
                        ),
                        SafeArea(
                          bottom: true,
                          top: false,
                          child: ElevatedButton(
                            onPressed: () {
                              if (_formKey.currentState!.validate()) {}
                            },
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
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  String _formatDateTime(DateTime date, TimeOfDay time) {
    final formattedDate = DateFormat('dd/MM/yyyy').format(date);
    final formattedTime = '${time.hour}:${time.minute}';
    return '$formattedDate $formattedTime';
  }
}
