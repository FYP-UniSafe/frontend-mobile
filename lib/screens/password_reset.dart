import 'package:flutter/material.dart';
import '../resources/validator.dart';

class PasswordReset extends StatefulWidget {
  const PasswordReset({super.key});

  @override
  State<PasswordReset> createState() => _PasswordResetState();
}

class _PasswordResetState extends State<PasswordReset> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            AppBar(
              leading: IconButton(
                icon: Icon(Icons.arrow_back),
                onPressed: () {
                  Navigator.pop(context);
                },
                iconSize: 28.0,
                color: Colors.black,
                padding: EdgeInsets.zero,
              ),
              title: Text(
                'Back',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20.0),
              ),
              backgroundColor: Colors.transparent,
              elevation: 0.0,
            ),
            SizedBox(
              height: 8,
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
                      Text(
                        'Forgot Password',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 18.0),
                      ),
                      SizedBox(
                        height: 8.0,
                      ),
                      Text(
                        'We will send you an email with a link to reset your password, please enter the email associated with your account below.',
                        style: TextStyle(fontSize: 16.0),
                      ),
                      SizedBox(
                        height: 24.0,
                      ),
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
                          'Send Link',
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
    );
  }
}
