import 'package:flutter/material.dart';
import 'package:unisafe/screens/login.dart';

import '../resources/validator.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  bool _isHidden = true;
  List<String> colleges = [
    "CoSS", "CoICT", "CoET", "CoNAS", "CoHU", "CoAF", "MUCE", "DUCE", "MCHAS", "SoED", "UDBS", "UDSoL", "SJMC", "UDSE", "SoMG", "SoAF", "Other"
  ];

  List<String> genders = [
    "Male", "Female"
  ];

  String? college;
  String? gender;

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: Padding(
        padding: const EdgeInsets.fromLTRB(16.0, 0.0, 16.0, 0.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.07,
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
              'assets/images/unisafe_icon.png',
            ),
            Expanded(
              child: SizedBox(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height * 0.9,
                child: Form(
                  key: _formKey,
                  child: ListView(
                    padding: EdgeInsets.only(top: 8),
                    children: [
                      TextFormField(
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        style: TextStyle(color: Colors.black),
                        decoration: InputDecoration(
                          contentPadding:
                              EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(18.0),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(18),
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
                          contentPadding:
                              EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(18.0),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(18),
                            borderSide:
                                BorderSide(color: Colors.black, width: 1.1),
                          ),
                          labelText: 'Registration Number',
                        ),
                        validator: (text) =>
                            TextFormValidators.studentIDValidator(text),
                      ),
                      SizedBox(height: 16.0),
                      TextFormField(
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        style: TextStyle(color: Colors.black),
                        decoration: InputDecoration(
                          contentPadding:
                          EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(18.0),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(18),
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
                        borderRadius: BorderRadius.circular(18),
                        icon: Icon(Icons.arrow_drop_down),
                        hint: Text('Gender'),
                        validator: (text) =>
                            TextFormValidators.chooseItems(text),
                        decoration: InputDecoration(
                          contentPadding:
                          EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(18),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(18),
                            borderSide:
                            BorderSide(color: Colors.black, width: 1.3),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(18),
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
                          contentPadding:
                              EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                          labelText: 'Email',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(18.0),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(18),
                            borderSide:
                                BorderSide(color: Colors.black, width: 1.1),
                          ),
                        ),
                        validator: (text) =>
                            TextFormValidators.emailValidator(text!),
                      ),
                      SizedBox(height: 16.0),
                      DropdownButtonFormField(
                        //alignment: Alignment.bottomCenter,
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        borderRadius: BorderRadius.circular(18),
                        icon: Icon(Icons.arrow_drop_down),
                        hint: Text('College / School'),
                        validator: (text) =>
                            TextFormValidators.chooseItems(text),
                        decoration: InputDecoration(
                          contentPadding:
                              EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(18),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.black, width: 1.3),
                            borderRadius: BorderRadius.circular(18),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(18),
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
                      SizedBox(height: 16.0),
                      TextFormField(
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        obscureText: _isHidden,
                        style: TextStyle(color: Colors.black),
                        decoration: InputDecoration(
                          contentPadding:
                              EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(18.0),
                            //borderSide: BorderSide(width: 3),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(18),
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
                      SizedBox(height: 20.0),
                      ElevatedButton(
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {}
                        },
                        style: ElevatedButton.styleFrom(
                          foregroundColor: Colors.grey,
                          backgroundColor: Color.fromRGBO(54, 37, 85, 1.0),
                          padding: EdgeInsets.all(12.0),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(18.0),
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
                            style:
                                TextStyle(color: Colors.black, fontSize: 18.0),
                          ),
                          GestureDetector(
                            onTap: () => Navigator.of(context).push(MaterialPageRoute(
                                builder: (BuildContext context) => Login())),
                            child: Text(
                              'Login',
                              style:
                                  TextStyle(color: Colors.blue, fontSize: 18.0),
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
    );
  }

  void _togglePasswordView() {
    setState(() {
      _isHidden = !_isHidden;
    });
  }
}
