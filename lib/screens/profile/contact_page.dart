import 'package:flutter/material.dart';
import 'package:flutter_linkify/flutter_linkify.dart';
import 'package:url_launcher/url_launcher.dart';

class ContactPage extends StatefulWidget {
  const ContactPage({super.key});

  @override
  State<ContactPage> createState() => _ContactPageState();
}

class _ContactPageState extends State<ContactPage> {
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
          'Contact Us',
          style: TextStyle(
              fontSize: 20.0, fontWeight: FontWeight.bold, color: Colors.white),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: SizedBox(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height * 0.9,
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  'Related FAQs',
                  style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: 8.0,
                ),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'How do I report a GBV related incident?',
                    style:
                        TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
                  ),
                ),
                SizedBox(
                  height: 4.0,
                ),
                Text(
                  'You can report an incident at any time once you have logged in.',
                  style: TextStyle(fontSize: 16.0),
                ),
                SizedBox(
                  height: 8.0,
                ),
                Text(
                  "Simply navigate to the 'Report a GBV' page from the navigation bar at the bottom of your screen. From here you can fill out a form that captures the necessary information needed about an incident.",
                  style: TextStyle(fontSize: 16.0),
                ),
                Divider(
                  height: 30.0,
                  color: Color.fromRGBO(8, 100, 175, 1.0),
                ),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'How do I request for a counselling service appointment?',
                    style:
                        TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
                  ),
                ),
                SizedBox(
                  height: 4.0,
                ),
                Text(
                  'You can request for a counselling appointment at any time once you have logged in.',
                  style: TextStyle(fontSize: 16.0),
                ),
                SizedBox(
                  height: 8.0,
                ),
                Text(
                  "Simply navigate to the 'Seek Counsel' page from the navigation bar at the bottom of your screen. From here you can choose the nature of the counselling service that you require.",
                  style: TextStyle(fontSize: 16.0),
                ),
                Divider(
                  height: 30.0,
                  color: Color.fromRGBO(8, 100, 175, 1.0),
                ),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'How do I update my account details?',
                    style:
                        TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
                  ),
                ),
                SizedBox(
                  height: 4.0,
                ),
                Text(
                  'You can update your account details at any time once you have logged in.',
                  style: TextStyle(fontSize: 16.0),
                ),
                SizedBox(
                  height: 8.0,
                ),
                Text(
                  "Just access your account via the profile menu at the bottom of your screen. From here you can update your personal information, including email addresses and passwords, as well as any preferences that you have previously selected.",
                  style: TextStyle(fontSize: 16.0),
                ),
                Divider(
                  height: 30.0,
                  color: Color.fromRGBO(8, 100, 175, 1.0),
                ),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'General enquiries',
                    style:
                        TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
                  ),
                ),
                SizedBox(
                  height: 4.0,
                ),
                Linkify(
                  onOpen: _onOpen,
                  text:
                      "Please contact unisafe.reports@gmail.com for any queries relating to GBV incident reporting, counselling services or user account.",
                  style: TextStyle(fontSize: 16.0),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _onOpen(LinkableElement link) async {
    if (!await launchUrl(Uri.parse(link.url))) {
      throw Exception('Could not launch ${link.url}');
    }
  }
}
