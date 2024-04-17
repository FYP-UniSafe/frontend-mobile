import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_libphonenumber/flutter_libphonenumber.dart';
import 'package:loading_indicator/loading_indicator.dart';
import 'package:provider/provider.dart';
import 'package:unisafe/Providers/authProvider.dart';
import 'package:unisafe/screens/authorization/login.dart';
import 'package:unisafe/screens/authorization/otp.dart';
import '../../Models/User.dart';
import '../../Providers/profileProvider.dart';
import '../../Services/stateObserver.dart';
import '../../Services/storage.dart';
import '../../Widgets/Flashbar/flashbar.dart';
import '../../resources/validator.dart';
import '../main/main_screen.dart';

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

  List<String> profiles = [
    "Student",
    "Gender Desk",
    "Counselling Unit",
    "Police"
  ];

  List<String> genders = ["Male", "Female"];

  final _student = TextEditingController();
  final _gender = TextEditingController();
  final _counsel = TextEditingController();
  final _policeID = TextEditingController();
  late ProfileTypeProvider profileTypeProvider;
  late AuthProvider _authProvider;

  final _fullName = TextEditingController();
  final _email = TextEditingController();
  final _password = TextEditingController();
  final _phone = TextEditingController();
  final _registration = TextEditingController();
  final _staffID = TextEditingController();
  final _policeStation = TextEditingController();

  String? college;
  String? gender;
  String? selectedOption;
  String? fieldValue;
  String? profile;

  final _formKey = GlobalKey<FormState>();

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
    profileTypeProvider = Provider.of<ProfileTypeProvider>(context);
    _authProvider = Provider.of<AuthProvider>(context);
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
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
                height: MediaQuery.of(context).size.height * 0.08,
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
                          controller: _fullName,
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
                          controller: _phone,
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
                          controller: _email,
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
                          controller: _password,
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
                        DropdownButtonFormField(
                          //alignment: Alignment.bottomCenter,
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          borderRadius: BorderRadius.circular(5.0),
                          icon: Icon(Icons.arrow_drop_down),
                          hint: Text('Profile Type'),
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
                          value: profileTypeProvider.selectedProfileType,
                          onChanged: (newValue) {
                            profileTypeProvider
                                .setSelectedProfileType(newValue.toString());
                          },
                          items: profiles.map((profile) {
                            return DropdownMenuItem(
                              child: Text(profile),
                              value: profile.toLowerCase().replaceAll(' ', '_'),
                            );
                          }).toList(),
                        ),
                        SizedBox(height: 16.0),
                        if (profileTypeProvider.selectedProfileType ==
                            'student') ...[
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              TextFormField(
                                controller: _registration,
                                onChanged: (value) {
                                  profileTypeProvider
                                      .setRegistrationNumber(value);
                                },
                                decoration: InputDecoration(
                                    contentPadding: EdgeInsets.symmetric(
                                        horizontal: 12.0, vertical: 12.0),
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(5.0),
                                    ),
                                    enabledBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Colors.black, width: 1.3),
                                      borderRadius: BorderRadius.circular(5.0),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(5.0),
                                    ),
                                    labelText: 'Registration Number'),
                              ),
                              SizedBox(height: 16.0),
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
                                    borderSide: BorderSide(
                                        color: Colors.black, width: 1.3),
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
                          ),
                        ],
                        if (profileTypeProvider.selectedProfileType ==
                                'gender_desk' ||
                            profileTypeProvider.selectedProfileType ==
                                'counselling_unit') ...[
                          TextFormField(
                            controller: _staffID,
                            onChanged: (value) {
                              profileTypeProvider.setStaffID(value);
                            },
                            decoration: InputDecoration(
                              labelText: 'Staff ID',
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
                          ),
                          SizedBox(height: 16.0),
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
                        if (profileTypeProvider.selectedProfileType ==
                            'police') ...[
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              TextFormField(
                                controller: _policeID,
                                onChanged: (value) {
                                  profileTypeProvider.setPoliceID(value);
                                },
                                decoration: InputDecoration(
                                  labelText: 'Police ID',
                                  contentPadding: EdgeInsets.symmetric(
                                      horizontal: 12.0, vertical: 12.0),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(5.0),
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Colors.black, width: 1.3),
                                    borderRadius: BorderRadius.circular(5.0),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(5.0),
                                  ),
                                ),
                              ),
                              SizedBox(height: 16.0),
                              TextFormField(
                                controller: _policeStation,
                                onChanged: (value) {
                                  profileTypeProvider.setStation(value);
                                },
                                decoration: InputDecoration(
                                  labelText: 'Station',
                                  contentPadding: EdgeInsets.symmetric(
                                      horizontal: 12.0, vertical: 12.0),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(5.0),
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Colors.black, width: 1.3),
                                    borderRadius: BorderRadius.circular(5.0),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(5.0),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                        SizedBox(height: 20.0),
                        ElevatedButton(
                          onPressed: () {
                            final profileType =
                                profileTypeProvider.selectedProfileType;
                            if (_formKey.currentState!.validate()) {
                              if (profileType == 'student') {
                                _studentSignup();
                              } else if (profileType == 'counselling_unit') {
                              } else if (profileType == 'gender_desk') {
                              } else if (profileType == 'police') {}
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
                        SafeArea(
                          bottom: true,
                          top: false,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                'Already have an account? ',
                                style: TextStyle(
                                    color: Colors.black, fontSize: 18.0),
                              ),
                              GestureDetector(
                                onTap: () => Navigator.pushAndRemoveUntil(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => Login()),
                                    (route) => false),
                                child: Text(
                                  'Login',
                                  style: TextStyle(
                                      color: Colors.blue, fontSize: 18.0),
                                ),
                              ),
                            ],
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

  void _togglePasswordView() {
    setState(() {
      _isHidden = !_isHidden;
    });
  }

  _studentSignup() async {
    if (_formKey.currentState!.validate()) {
      if (_email.text.isNotEmpty &&
          _password.text.isNotEmpty &&
          _fullName.text.isNotEmpty &&
          _registration.text.isNotEmpty &&
          college != null &&
          gender != null) {
        Map<String, dynamic> phoneNumber =
            await parse(_phone.text, region: 'TZ');
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

        await _authProvider.registerStudent(
            user: User(
                email: _email.text,
                password: _password.text,
                full_name: _fullName.text,
                gender: gender,
                college: college,
                phone_number: phoneNumber['e164'],
                reg_no: _registration.text));

        if (_authProvider.isLoggedIn != null &&
            _authProvider.isLoggedIn == true) {
          await Provider.of<LocalStorageProvider>(context,listen: false).initialize();
          Navigator.pop(context);

          Navigator.pushAndRemoveUntil(context,
              MaterialPageRoute(builder: (context) => Otp()), (route) => false);
        } else {
          Navigator.pop(context);
          Flashbar(
            flashbarPosition: FlashbarPosition.TOP,
            borderRadius: BorderRadius.circular(12),
            backgroundColor: Colors.black,
            icon: Icon(
              CupertinoIcons.exclamationmark_triangle,
              color: Colors.red,
              size: 32,
            ),
            titleText: Text(
              'Alert',
              style: TextStyle(
                  color: Colors.red,
                  fontFamily: 'Poppins',
                  fontSize: 18,
                  fontWeight: FontWeight.w500),
            ),
            messageText: Text(
              'Signup Failed',
              style: TextStyle(
                  color: Colors.red,
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
