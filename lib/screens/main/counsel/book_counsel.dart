import 'package:flutter/material.dart';
import 'package:unisafe/resources/validator.dart';

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

  String? college;
  String selectedOption = '';
  TextEditingController _dateController = TextEditingController();
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
                    DropdownButtonFormField(
                      //alignment: Alignment.bottomCenter,
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      borderRadius: BorderRadius.circular(5.0),
                      icon: Icon(Icons.arrow_drop_down),
                      hint: Text('College / School'),
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
                        labelText: 'Registration Number',
                      ),
                      validator: (text) =>
                          TextFormValidators.studentIDValidator(text),
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
                        labelText: 'Email',
                      ),
                      validator: (text) =>
                          TextFormValidators.emailValidator(text!),
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
                      onTap: () {
                        _selectDate();
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
                          value: 'physical',
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
                          value: 'online',
                          groupValue: selectedOption,
                          onChanged: (value) {
                            setState(() {
                              selectedOption = value.toString();
                            });
                          }),
                    ),
                    SizedBox(
                      height: 16.0,
                    ),
                    TextFormField(
                      minLines: 6,
                      maxLines: 10,
                      //textAlign: TextAlign.start,
                      style: TextStyle(color: Colors.black),
                      decoration: InputDecoration(
                        alignLabelWithHint: true,
                        contentPadding: EdgeInsets.symmetric(
                            horizontal: 12.0, vertical: 12.0),
                        labelText: 'Comments (if any)',
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
                      height: 20.0,
                    ),
                    ElevatedButton(
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
                        'Book',
                        style: TextStyle(
                            fontSize: 18.0, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ],
                ),
              ))
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _selectDate() async {
    DateTime? _picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );

    if (_picked != null) {
      setState(() {
        _dateController.text = _picked.toString().split(" ")[0];
      });
    }
  }
}
