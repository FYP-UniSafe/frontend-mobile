import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;
import 'package:loading_indicator/loading_indicator.dart';
import 'package:provider/provider.dart';
import 'package:unisafe/Providers/authProvider.dart';
import 'package:unisafe/Services/storage.dart';
import 'package:unisafe/screens/main/main_screen.dart';

import '../../Models/User.dart';
import '../../Services/stateObserver.dart';
import '../../Widgets/Flashbar/flashbar.dart';
import '../../resources/constants.dart';

class Otp extends StatefulWidget {
  const Otp({super.key});

  @override
  State<Otp> createState() => _OtpState();
}

class _OtpState extends State<Otp> {
  final _formKey = GlobalKey<FormState>();
  FocusNode? pin2FocusNode;
  FocusNode? pin3FocusNode;
  FocusNode? pin4FocusNode;
  FocusNode? pin5FocusNode;
  FocusNode? pin6FocusNode;

  List<TextEditingController> otp =
      List.generate(6, (index) => TextEditingController());

  late AuthProvider _authProvider;
  final _appStateObserver = AppStateObserver();

  @override
  void initState() {
    WidgetsBinding.instance.addObserver(_appStateObserver);
    pin2FocusNode = FocusNode();
    pin3FocusNode = FocusNode();
    pin4FocusNode = FocusNode();
    pin5FocusNode = FocusNode();
    pin6FocusNode = FocusNode();
    super.initState();
  }

  @override
  void didChangeDependencies() {
    _authProvider = Provider.of<AuthProvider>(context);
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(_appStateObserver);
    pin2FocusNode!.dispose();
    pin3FocusNode!.dispose();
    pin4FocusNode!.dispose();
    pin5FocusNode!.dispose();
    pin6FocusNode!.dispose();
    super.dispose();
  }

  void nextField(String value, FocusNode? focusNode) {
    if (value.length == 1) {
      focusNode!.requestFocus();
    }
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.98,
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        appBar: AppBar(
          // leading: IconButton(
          //   onPressed: () {
          //     Navigator.pop(context);
          //   },
          //   icon: Icon(
          //     Icons.arrow_back_ios,
          //     size: 20.0,
          //     color: Colors.white,
          //   ),
          // ),
          title: Text(
            'OTP Verification',
            style: TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
                color: Colors.white),
          ),
        ),
        body: Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(
                'We sent a code to your email.',
                style: TextStyle(
                  fontSize: 16.0,
                ),
              ),
              SizedBox(
                height: 6.0,
              ),
              Text(
                'Use the code to verify your account.',
                style: TextStyle(fontSize: 16.0),
              ),
              SizedBox(
                height: 6.0,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'This code will expire in ',
                    style: TextStyle(
                      fontSize: 16.0,
                    ),
                  ),
                  TweenAnimationBuilder(
                    tween: Tween(begin: 600.0, end: 0.0),
                    duration: Duration(
                      minutes: 10,
                    ),
                    builder: (_, double value, child) {
                      int minutes = value ~/ 60;
                      int seconds = (value % 60).toInt();
                      return Text(
                        '$minutes:${seconds.toString().padLeft(2, '0')}',
                        style: TextStyle(
                          fontSize: 16.0,
                          color: Color.fromRGBO(8, 100, 175, 1.0),
                        ),
                      );
                    },
                  ),
                ],
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.1,
              ),
              Form(
                key: _formKey,
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SizedBox(
                          width: 55.0,
                          child: TextFormField(
                            controller: otp[0],
                            //autofocus: true,
                            // obscureText: true,
                            style: TextStyle(
                              fontSize: 24,
                              color: Colors.black,
                            ),
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
                              errorBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(5.0),
                                borderSide:
                                    BorderSide(color: Colors.red, width: 1.1),
                              ),
                            ),
                            inputFormatters: [
                              LengthLimitingTextInputFormatter(1),
                              FilteringTextInputFormatter.digitsOnly
                            ],
                            keyboardType: TextInputType.number,
                            textAlign: TextAlign.center,
                            onChanged: (value) {
                              if (value.length == 1) {
                                FocusScope.of(context).nextFocus();
                              } else if (value.isEmpty) {
                                // FocusScope.of(context).previousFocus();
                              }
                            },
                            validator: (value) {
                              if (value!.isEmpty) {
                                return '';
                              } else {
                                return null;
                              }
                            },
                          ),
                        ),
                        SizedBox(
                          width: 55.0,
                          child: TextFormField(
                            controller: otp[1],
                            focusNode: pin2FocusNode,
                            // obscureText: true,
                            style: TextStyle(
                              fontSize: 24,
                              color: Colors.black,
                            ),
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
                              errorBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(5.0),
                                borderSide:
                                    BorderSide(color: Colors.red, width: 1.1),
                              ),
                            ),
                            keyboardType: TextInputType.number,
                            inputFormatters: [
                              LengthLimitingTextInputFormatter(1),
                              FilteringTextInputFormatter.digitsOnly
                            ],
                            textAlign: TextAlign.center,
                            onChanged: (value) {
                              if (value.length == 1) {
                                FocusScope.of(context).nextFocus();
                              } else if (value.isEmpty) {
                                FocusScope.of(context).previousFocus();
                              }
                            },
                            validator: (value) {
                              if (value!.isEmpty) {
                                return '';
                              } else {
                                return null;
                              }
                            },
                          ),
                        ),
                        SizedBox(
                          width: 55.0,
                          child: TextFormField(
                            controller: otp[2],
                            focusNode: pin3FocusNode,
                            // obscureText: true,
                            style: TextStyle(
                              fontSize: 24,
                              color: Colors.black,
                            ),
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
                              errorBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(5.0),
                                borderSide:
                                    BorderSide(color: Colors.red, width: 1.1),
                              ),
                            ),
                            keyboardType: TextInputType.number,
                            textAlign: TextAlign.center,
                            inputFormatters: [
                              LengthLimitingTextInputFormatter(1),
                              FilteringTextInputFormatter.digitsOnly
                            ],
                            onChanged: (value) {
                              if (value.length == 1) {
                                FocusScope.of(context).nextFocus();
                              } else if (value.isEmpty) {
                                FocusScope.of(context).previousFocus();
                              }
                            },
                            validator: (value) {
                              if (value!.isEmpty) {
                                return '';
                              } else {
                                return null;
                              }
                            },
                          ),
                        ),
                        SizedBox(
                          width: 55.0,
                          child: TextFormField(
                            controller: otp[3],
                            focusNode: pin4FocusNode,
                            // obscureText: true,
                            style: TextStyle(
                              fontSize: 24,
                              color: Colors.black,
                            ),
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
                              errorBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(5.0),
                                borderSide:
                                    BorderSide(color: Colors.red, width: 1.1),
                              ),
                            ),
                            inputFormatters: [
                              LengthLimitingTextInputFormatter(1),
                              FilteringTextInputFormatter.digitsOnly
                            ],
                            keyboardType: TextInputType.number,
                            textAlign: TextAlign.center,
                            onChanged: (value) {
                              if (value.length == 1) {
                                FocusScope.of(context).nextFocus();
                              } else if (value.isEmpty) {
                                FocusScope.of(context).previousFocus();
                              }
                            },
                            validator: (value) {
                              if (value!.isEmpty) {
                                return '';
                              } else {
                                return null;
                              }
                            },
                          ),
                        ),
                        SizedBox(
                          width: 55.0,
                          child: TextFormField(
                            controller: otp[4],
                            focusNode: pin5FocusNode,
                            // obscureText: true,
                            style: TextStyle(
                              fontSize: 24,
                              color: Colors.black,
                            ),
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
                              errorBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(5.0),
                                borderSide:
                                    BorderSide(color: Colors.red, width: 1.1),
                              ),
                            ),
                            inputFormatters: [
                              LengthLimitingTextInputFormatter(1),
                              FilteringTextInputFormatter.digitsOnly
                            ],
                            keyboardType: TextInputType.number,
                            textAlign: TextAlign.center,
                            onChanged: (value) {
                              if (value.length == 1) {
                                FocusScope.of(context).nextFocus();
                              } else if (value.isEmpty) {
                                FocusScope.of(context).previousFocus();
                              }
                            },
                            validator: (value) {
                              if (value!.isEmpty) {
                                return '';
                              } else {
                                return null;
                              }
                            },
                          ),
                        ),
                        SizedBox(
                          width: 55.0,
                          child: TextFormField(
                            controller: otp[5],
                            focusNode: pin6FocusNode,
                            // obscureText: true,
                            style: TextStyle(
                              fontSize: 24,
                              color: Colors.black,
                            ),
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
                              errorBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(5.0),
                                borderSide:
                                    BorderSide(color: Colors.red, width: 1.1),
                              ),
                            ),
                            keyboardType: TextInputType.number,
                            textAlign: TextAlign.center,
                            onChanged: (value) {
                              if (value.length == 1) {
                                FocusScope.of(context).unfocus();
                              } else if (value.isEmpty) {
                                FocusScope.of(context).previousFocus();
                              }
                            },
                            validator: (value) {
                              if (value!.isEmpty) {
                                return '';
                              } else {
                                return null;
                              }
                            },
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.15,
                    ),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: _verifyOtp,
                        style: ElevatedButton.styleFrom(
                          foregroundColor: Colors.white,
                          backgroundColor: Color.fromRGBO(8, 100, 175, 1.0),
                          padding: EdgeInsets.all(12.0),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5.0),
                          ),
                        ),
                        child: Text(
                          'Continue',
                          style: TextStyle(
                              fontSize: 18.0, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 20.0,
              ),
              GestureDetector(
                onTap: _resendOTP,
                child: Text(
                  "Resend OTP Code",
                  style: TextStyle(
                    fontSize: 16.0,
                    decoration: TextDecoration.underline,
                    color: Color.fromRGBO(8, 100, 175, 1.0),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  _verifyOtp() async {
    bool? otpGiven;
    String? otpValue;

    if (_formKey.currentState!.validate()) {
      for (TextEditingController value in otp) {
        if (value.text.isNotEmpty) {
          setState(() {
            otpGiven = true;
          });
        } else {
          setState(() {
            otpGiven = false;
          });
          break;
        }
      }

      if (otpGiven != null && otpGiven == true) {
        otp.forEach((element) {
          if (element.text.isNotEmpty) {
            if (otpValue != null) {
              setState(() {
                otpValue = '${otpValue}${element.text.toString()}';
              });
            } else {
              setState(() {
                otpValue = element.text.toString();
              });
            }
          }
        });
      }

      if (otpValue != null && otpValue!.length == 6) {
        print(otpValue);
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

        await _authProvider.verifyOtp(
            user: User(email: _authProvider.currentUser!.email, otp: otpValue));
        await Provider.of<LocalStorageProvider>(context, listen: false)
            .initialize();

        if (_authProvider.otpVerifed != null &&
            _authProvider.otpVerifed == true) {
          if (_authProvider.currentUser!.is_genderdesk == true) {
            Navigator.pop(context);

            Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (context) => MainScreen()),
                (route) => false);
          } else {
            Navigator.pop(context);

            Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (context) => MainScreen()),
                (route) => false);
          }
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
              'OTP Verification Failed',
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

  _resendOTP() async {
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

    await _authProvider.resendOTP();

    if (_authProvider.otpSent != null && _authProvider.otpSent == true) {
      Navigator.pop(context);
      Flashbar(
        flashbarPosition: FlashbarPosition.TOP,
        borderRadius: BorderRadius.circular(5),
        backgroundColor: Colors.black,
        icon: Icon(
          CupertinoIcons.exclamationmark_triangle,
          color: Colors.green,
          size: 32,
        ),
        titleText: Text(
          'Success',
          style: TextStyle(
              color: Colors.red,
              fontFamily: 'Poppins',
              fontSize: 18,
              fontWeight: FontWeight.w500),
        ),
        messageText: Text(
          'An OTP has been sent to you email',
          style: TextStyle(
              color: Colors.red,
              fontFamily: 'Poppins',
              fontSize: 16,
              fontWeight: FontWeight.w500),
        ),
        duration: Duration(seconds: 3),
      ).show(context);
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
          'OTP Resend Failed',
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
