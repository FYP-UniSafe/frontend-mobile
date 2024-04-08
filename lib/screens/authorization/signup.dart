import 'package:flutter/material.dart';
import 'package:unisafe/screens/authorization/login.dart';
import 'package:unisafe/screens/main/homepage.dart';
import 'package:unisafe/screens/main/main_screen.dart';
import 'package:unisafe/screens/profile/profile_page.dart';

import '../../resources/validator.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  bool _isHidden = true;
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

  final _student = TextEditingController();
  final _gender = TextEditingController();
  final _counsel = TextEditingController();
  final _police = TextEditingController();

  String? college;
  String? gender;
  String? selectedOption;
  String? fieldValue;

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    _student.text.isNotEmpty;
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.98,
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        body: Padding(
          padding: EdgeInsets.fromLTRB(16.0, 0.0, 16.0, 16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.04,
              ),
              Text(
                'Sign Up',
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 28.0,
                    fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 6.0),
              Text(
                'Join a Supportive Community',
                style: TextStyle(color: Colors.black, fontSize: 16.0),
              ),
              Image.asset(
                height: MediaQuery.of(context).size.height * 0.11,
                'assets/images/unisafe_icon.png',
              ),
              Expanded(
                child: SizedBox(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height * 0.9,
                  child: Form(
                    key: _formKey,
                    child: ListView(
                      padding: EdgeInsets.only(top: 8.0),
                      children: [
                        TextFormField(
                          initialValue: fieldValue,
                          onChanged: (value) {
                            setState(() {
                              fieldValue = value;
                            });
                          },
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
                        SizedBox(height: 16.0),
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
                            labelText: 'Phone Number',
                          ),
                          validator: (text) =>
                              TextFormValidators.phoneValidator(text!),
                        ),
                        SizedBox(height: 16.0),
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
                        SizedBox(height: 16.0),
                        TextFormField(
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          style: TextStyle(color: Colors.black),
                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.symmetric(
                                horizontal: 12.0, vertical: 12.0),
                            labelText: 'Email',
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
                              TextFormValidators.emailValidator(text!),
                        ),
                        SizedBox(height: 16.0),
                        TextFormField(
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          obscureText: _isHidden,
                          style: TextStyle(color: Colors.black),
                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.symmetric(
                                horizontal: 12.0, vertical: 12.0),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(5.0),
                              //borderSide: BorderSide(width: 3),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(5.0),
                              borderSide:
                                  BorderSide(color: Colors.black, width: 1.1),
                            ),
                            labelText: 'Password',
                            suffixIcon: InkWell(
                              onTap: _togglePasswordView,
                              child: Icon(
                                _isHidden
                                    ? Icons.visibility
                                    : Icons.visibility_off,
                                size: 20,
                                color: Colors.grey[600],
                              ),
                            ),
                          ),
                          validator: (text) =>
                              TextFormValidators.passwordValidator(text!),
                        ),
                        SizedBox(
                          height: 16.0,
                        ),
                        Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Text(
                            'Profile Type',
                            style: TextStyle(fontSize: 18.0),
                          ),
                        ),
                        RadioListTile(
                            visualDensity:
                                VisualDensity(horizontal: -4, vertical: -4),
                            dense: true,
                            activeColor: Color.fromRGBO(8, 100, 175, 1.0),
                            title: Text(
                              'Student',
                              style: TextStyle(fontSize: 16.0),
                            ),
                            value: 'option1',
                            groupValue: selectedOption,
                            onChanged: (value) {
                              setState(() {
                                selectedOption = value.toString();
                                college = null;
                              });
                            }),
                        RadioListTile(
                            visualDensity:
                                VisualDensity(horizontal: -4, vertical: -4),
                            dense: true,
                            activeColor: Color.fromRGBO(8, 100, 175, 1.0),
                            title: Text(
                              'Gender Desk',
                              style: TextStyle(fontSize: 16.0),
                            ),
                            value: 'option2',
                            groupValue: selectedOption,
                            onChanged: (value) {
                              setState(() {
                                selectedOption = value.toString();
                                college = null;
                              });
                            }),
                        RadioListTile(
                            visualDensity:
                                VisualDensity(horizontal: -4, vertical: -4),
                            dense: true,
                            activeColor: Color.fromRGBO(8, 100, 175, 1.0),
                            title: Text(
                              'Counselling Unit',
                              style: TextStyle(fontSize: 16.0),
                            ),
                            value: 'option3',
                            groupValue: selectedOption,
                            onChanged: (value) {
                              setState(() {
                                selectedOption = value.toString();
                                college = null;
                              });
                            }),
                        RadioListTile(
                            visualDensity:
                                VisualDensity(horizontal: -4, vertical: -4),
                            dense: true,
                            activeColor: Color.fromRGBO(8, 100, 175, 1.0),
                            title: Text(
                              'Police',
                              style: TextStyle(fontSize: 16.0),
                            ),
                            value: 'option4',
                            groupValue: selectedOption,
                            onChanged: (value) {
                              setState(() {
                                selectedOption = value.toString();
                                college = null;
                              });
                            }),
                        if (selectedOption == 'option1') ...[
                          TextFormField(
                            controller: _student,
                            onChanged: (value) {},
                            autovalidateMode:
                                AutovalidateMode.onUserInteraction,
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
                            autovalidateMode:
                                AutovalidateMode.onUserInteraction,
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
                        if (selectedOption == 'option2') ...[
                          TextFormField(
                            controller: _gender,
                            onChanged: (value) {},
                            autovalidateMode:
                                AutovalidateMode.onUserInteraction,
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
                              labelText: 'Staff ID',
                            ),
                            validator: (text) =>
                                TextFormValidators.staffIDValidator(text),
                          ),
                          SizedBox(
                            height: 16.0,
                          ),
                          DropdownButtonFormField(
                            //alignment: Alignment.bottomCenter,
                            autovalidateMode:
                                AutovalidateMode.onUserInteraction,
                            borderRadius: BorderRadius.circular(12.0),
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
                        if (selectedOption == 'option3') ...[
                          TextFormField(
                            controller: _counsel,
                            onChanged: (value) {},
                            autovalidateMode:
                                AutovalidateMode.onUserInteraction,
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
                              labelText: 'Staff ID',
                            ),
                            validator: (text) =>
                                TextFormValidators.staffIDValidator(text),
                          ),
                          SizedBox(
                            height: 16.0,
                          ),
                          DropdownButtonFormField(
                            //alignment: Alignment.bottomCenter,
                            autovalidateMode:
                                AutovalidateMode.onUserInteraction,
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
                        if (selectedOption == 'option4') ...[
                          TextFormField(
                            controller: _police,
                            onChanged: (value) {},
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
                              labelText: 'Police ID',
                            ),
                          ),
                          SizedBox(
                            height: 16.0,
                          ),
                          TextFormField(
                            autovalidateMode:
                                AutovalidateMode.onUserInteraction,
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
                              labelText: 'Station',
                            ),
                            validator: (text) =>
                                TextFormValidators.textFieldValidator(text),
                          ),
                        ],
                        SizedBox(height: 20.0),
                        ElevatedButton(
                          onPressed: () {
                            if (_formKey.currentState!.validate()) {
                              if (selectedOption == 'option1') {
                                Navigator.pushNamed(context, '/option1Page');
                              } else if (selectedOption == 'option2') {
                              } else if (selectedOption == 'option3') {
                              } else if (selectedOption == 'option4') {}
                            }
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
                            'Sign Up',
                            style: TextStyle(
                                fontSize: 18.0, fontWeight: FontWeight.bold),
                          ),
                        ),
                        SizedBox(height: 8.0),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'Already have an account? ',
                              style: TextStyle(
                                  color: Colors.black, fontSize: 18.0),
                            ),
                            GestureDetector(
                              onTap: () => Navigator.of(context).push(
                                  MaterialPageRoute(
                                      builder: (BuildContext context) =>
                                          Login())),
                              child: Text(
                                'Login',
                                style: TextStyle(
                                    color: Colors.blue, fontSize: 18.0),
                              ),
                            ),
                          ],
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

  void _togglePasswordView() {
    setState(() {
      _isHidden = !_isHidden;
    });
  }
}
