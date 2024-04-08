import 'package:flutter/material.dart';
import 'package:unisafe/screens/main/report/report_form.dart';
import 'package:url_launcher/url_launcher.dart';

class ReportPage extends StatefulWidget {
  const ReportPage({super.key});

  @override
  State<ReportPage> createState() => _ReportPageState();
}

class _ReportPageState extends State<ReportPage> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.98,
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        body: Padding(
          padding: EdgeInsets.fromLTRB(16.0, 8.0, 16.0, 8.0),
          child: SizedBox(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height * 0.9,
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(
                    color: Color.fromRGBO(242, 242, 228, 1.0),
                    child: Image.asset(
                      'assets/images/report_gbv.jpg',
                      height: MediaQuery.of(context).size.height * 0.2,
                      width: double.infinity,
                    ),
                  ),
                  SizedBox(
                    height: 12.0,
                  ),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'Important Notice:',
                      style: TextStyle(
                          fontSize: 18.0,
                          fontWeight: FontWeight.bold,
                          color: Colors.red),
                    ),
                  ),
                  SizedBox(
                    height: 8.0,
                  ),
                  Text(
                    'UniSafe is committed to providing a safe and supportive platform for addressing Gender-Based Violence. Your reports help create a safer community. Please take note of the following:',
                    style:
                        TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: 8.0,
                  ),
                  Text(
                    '- Ensure that the information you provide is accurate and truthful. False reporting not only undermines the purpose of UniSafe but may also have legal consequences.',
                    style: TextStyle(
                      fontSize: 16.0,
                    ),
                  ),
                  SizedBox(
                    height: 4.0,
                  ),
                  Text(
                    '- Understand your legal obligations when using UniSafe. Misuse of the platform, such as false accusations, may result in legal consequences.',
                    style: TextStyle(
                      fontSize: 16.0,
                    ),
                  ),
                  SizedBox(
                    height: 16.0,
                  ),
                  Text(
                    'SHARE YOUR STORY',
                    style: TextStyle(fontSize: 18.0),
                  ),
                  Divider(
                    height: 30.0,
                    color: Color.fromRGBO(8, 100, 175, 1.0),
                  ),
                  Container(
                    color: Color.fromRGBO(255, 255, 255, 1.0),
                    child: Image.asset(
                      'assets/images/share_story.png',
                      height: MediaQuery.of(context).size.height * 0.2,
                      width: double.infinity,
                    ),
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () => Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (BuildContext context) => ReportForm(),
                        ),
                      ),
                      style: ElevatedButton.styleFrom(
                        elevation: 3,
                        backgroundColor: Colors.white,
                        side: BorderSide(
                          width: 1.0,
                          color: Color.fromRGBO(8, 100, 175, 1.0),
                        ),
                        padding: EdgeInsets.all(12.0),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5.0),
                        ),
                      ),
                      child: Text(
                        'Report Here',
                        style: TextStyle(
                          fontSize: 18.0,
                          fontWeight: FontWeight.bold,
                          color: Color.fromRGBO(8, 100, 175, 1.0),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 16.0,
                  ),
                  Text(
                    'For immediate response, please contact the Auxiliary Police using the number below.',
                    style: TextStyle(fontSize: 16.0),
                  ),
                  SizedBox(
                    height: 4.0,
                  ),
                  TextButton(
                    onPressed: () async {
                      final Uri url =
                          Uri(scheme: 'tel', path: '+255 73 777 7044');
                      if (await canLaunchUrl(url)) {
                        await launchUrl(url);
                      } else {
                        print('cannot launch this url');
                      }
                    },
                    child: Text(
                      '+255 73 777 7044',
                      style: TextStyle(
                        fontSize: 18.0,
                        fontWeight: FontWeight.bold,
                        color: Color.fromRGBO(8, 100, 175, 1.0),
                      ),
                    ),
                  ),
                  Divider(
                    height: 30.0,
                    color: Color.fromRGBO(8, 100, 175, 1.0),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
