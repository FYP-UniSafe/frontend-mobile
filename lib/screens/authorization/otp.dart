import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class Otp extends StatefulWidget {
  const Otp({super.key});

  @override
  State<Otp> createState() => _OtpState();
}

class _OtpState extends State<Otp> {
  FocusNode? pin2FocusNode;
  FocusNode? pin3FocusNode;
  FocusNode? pin4FocusNode;
  FocusNode? pin5FocusNode;
  FocusNode? pin6FocusNode;

  @override
  void initState() {
    super.initState();
    pin2FocusNode = FocusNode();
    pin3FocusNode = FocusNode();
    pin4FocusNode = FocusNode();
    pin5FocusNode = FocusNode();
    pin6FocusNode = FocusNode();
  }

  @override
  void dispose() {
    super.dispose();
    pin2FocusNode!.dispose();
    pin3FocusNode!.dispose();
    pin4FocusNode!.dispose();
    pin5FocusNode!.dispose();
    pin6FocusNode!.dispose();
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
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SizedBox(
                          width: 55.0,
                          child: TextFormField(
                            //autofocus: true,
                            obscureText: true,
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
                            ),
                            keyboardType: TextInputType.number,
                            textAlign: TextAlign.center,
                            onChanged: (value) {
                              nextField(value, pin2FocusNode);
                            },
                          ),
                        ),
                        SizedBox(
                          width: 55.0,
                          child: TextFormField(
                            focusNode: pin2FocusNode,
                            obscureText: true,
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
                            ),
                            keyboardType: TextInputType.number,
                            textAlign: TextAlign.center,
                            onChanged: (value) =>
                                nextField(value, pin3FocusNode),
                          ),
                        ),
                        SizedBox(
                          width: 55.0,
                          child: TextFormField(
                            focusNode: pin3FocusNode,
                            obscureText: true,
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
                            ),
                            keyboardType: TextInputType.number,
                            textAlign: TextAlign.center,
                            onChanged: (value) =>
                                nextField(value, pin4FocusNode),
                          ),
                        ),
                        SizedBox(
                          width: 55.0,
                          child: TextFormField(
                            focusNode: pin4FocusNode,
                            obscureText: true,
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
                            ),
                            keyboardType: TextInputType.number,
                            textAlign: TextAlign.center,
                            onChanged: (value) =>
                                nextField(value, pin5FocusNode),
                          ),
                        ),
                        SizedBox(
                          width: 55.0,
                          child: TextFormField(
                            focusNode: pin5FocusNode,
                            obscureText: true,
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
                            ),
                            keyboardType: TextInputType.number,
                            textAlign: TextAlign.center,
                            onChanged: (value) =>
                                nextField(value, pin6FocusNode),
                          ),
                        ),
                        SizedBox(
                          width: 55.0,
                          child: TextFormField(
                            focusNode: pin6FocusNode,
                            obscureText: true,
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
                            ),
                            keyboardType: TextInputType.number,
                            textAlign: TextAlign.center,
                            onChanged: (value) {
                              if (value.length == 1) {
                                pin6FocusNode!.unfocus();
                                // Then you need to check is the code is correct or not
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
                        onPressed: () {},
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
                onTap: () {
                  // OTP code resend
                },
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
}
