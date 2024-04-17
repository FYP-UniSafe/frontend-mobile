import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:loading_indicator/loading_indicator.dart';
import 'package:provider/provider.dart';
import 'package:unisafe/resources/validator.dart';

import '../../Models/User.dart';
import '../../Providers/authProvider.dart';
import '../../Services/stateObserver.dart';
import '../../Widgets/Flashbar/flashbar.dart';
import '../authorization/login.dart';
import '../authorization/password_reset.dart';

class AccountSecurity extends StatefulWidget {
  const AccountSecurity({super.key});

  @override
  State<AccountSecurity> createState() => _AccountSecurityState();
}

class _AccountSecurityState extends State<AccountSecurity> {
  final _formKey = GlobalKey<FormState>();
  bool _isHidden = true;
  bool _isHidden2 = true;
  late AuthProvider _authProvider;
  String old_password = '';
  String new_password = '';
  final _oldpasswordController = TextEditingController();
  final _newpasswordController = TextEditingController();

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
    _authProvider = Provider.of<AuthProvider>(context);
    super.didChangeDependencies();
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
            'Account Security',
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
                  child: Form(
                    key: _formKey,
                    child: ListView(
                      //padding: EdgeInsets.only(top: 4.0),
                      children: [
                        Text(
                          'In order to improve the security of your account, can you reset your password to a unique one.',
                          style: TextStyle(fontSize: 16.0),
                        ),
                        SizedBox(
                          height: 20.0,
                        ),
                        TextFormField(
                          controller: _oldpasswordController,
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
                            labelText: 'Current Password',
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
                          height: 8.0,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 12.0, vertical: 0.0),
                          child: Align(
                            alignment: Alignment.centerRight,
                            child: GestureDetector(
                              onTap: () => Navigator.of(context).push(
                                  MaterialPageRoute(
                                      builder: (BuildContext context) =>
                                          PasswordReset())),
                              child: Text(
                                'Forgot login details?',
                                style: TextStyle(
                                    color: Colors.blue, fontSize: 16.0),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 8.0,
                        ),
                        TextFormField(
                          controller: _newpasswordController,
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          obscureText: _isHidden2,
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
                            labelText: 'New Password',
                            suffixIcon: InkWell(
                              onTap: _togglePasswordView2,
                              child: Icon(
                                _isHidden2
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
                          onPressed: _changePassword,
                          style: ElevatedButton.styleFrom(
                            foregroundColor: Colors.white,
                            backgroundColor: Color.fromRGBO(8, 100, 175, 1.0),
                            padding: EdgeInsets.all(12.0),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5.0),
                            ),
                          ),
                          child: Text(
                            'Update Password',
                            style: TextStyle(
                                fontSize: 18.0, fontWeight: FontWeight.bold),
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
  void _togglePasswordView2() {
    setState(() {
      _isHidden2 = !_isHidden2;
    });
  }

  _changePassword() async {
    if (_formKey.currentState!.validate()) {
      if (_oldpasswordController.text.isNotEmpty&&_newpasswordController.text.isNotEmpty) {
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

        await _authProvider.changePassword(old_password:_oldpasswordController.text,new_password:  _newpasswordController.text,
        );
        if (_authProvider.isChanged != null &&
            _authProvider.isChanged == true) {
          Navigator.pop(context);

          Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (context) => Login()),
              (route) => false);
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
              'Password Change Failed',
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
