import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:cupertino_icons/cupertino_icons.dart';
import 'package:url_launcher/url_launcher.dart';
import '../chatbot.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //resizeToAvoidBottomInset: true,
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: SizedBox(
          height: MediaQuery.of(context).size.height * 0.99,
          child: Stack(
            children: [
              SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Card(
                      //elevation: 30.0,
                      clipBehavior: Clip.antiAlias,
                      child: Stack(
                        children: [
                          Container(
                            width: double.infinity,
                            height: MediaQuery.of(context).size.height * 0.3,
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                image: AssetImage('assets/images/home.jpg'),
                                fit: BoxFit.cover,
                                colorFilter: ColorFilter.mode(
                                    Colors.black.withOpacity(0.3),
                                    BlendMode.dstATop),
                              ),
                            ),
                          ),
                          Positioned(
                            top: 10,
                            left: 10,
                            child: Text(
                              'Welcome to UniSafe!',
                              style: TextStyle(
                                shadows: [
                                  Shadow(
                                    color: Colors.grey,
                                    blurRadius: 4.0,
                                    offset: Offset(5.0, 5.0),
                                  )
                                ],
                                color: Color.fromRGBO(8, 100, 175, 1.0),
                                fontSize: 28.0,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          Positioned(
                            bottom: 6,
                            child: Container(
                              width: MediaQuery.of(context).size.width - 40,
                              child: Padding(
                                padding: EdgeInsets.all(16.0),
                                child: Text(
                                  "With UniSafe, you're not just downloading an app; you're becoming part of a movement towards fostering awareness, providing resources, and offering support to combat gender-based violence.",
                                  style: TextStyle(
                                    fontSize: 17.0,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 16.0,
                    ),
                    Text(
                      'In the light of addressing GBV around the world, different agencies have enforced policies that discourage the prevalence of GBV.',
                      style: TextStyle(fontSize: 16.0),
                    ),
                    Divider(
                      height: 30.0,
                      color: Color.fromRGBO(8, 100, 175, 1.0),
                    ),
                    GestureDetector(
                      onTap: () {
                        _launchUrl('https://www.unwomen.org/en');
                      },
                      child: Card(
                        //clipBehavior: Clip.antiAlias,
                        color: Colors.white,
                        //elevation: 10.0,
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            ListTile(
                              leading: Image.asset(
                                'assets/images/un_women.png',
                                height:
                                    MediaQuery.of(context).size.height * 0.3,
                                width: MediaQuery.of(context).size.width * 0.25,
                              ),
                              title: Row(
                                children: [
                                  Expanded(
                                    child: Text(
                                      'UN Women',
                                      style: TextStyle(fontSize: 17.0),
                                    ),
                                  ),
                                  Icon(
                                    CupertinoIcons.arrow_up_right_square,
                                    color: Colors.blue,
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              width: MediaQuery.of(context).size.width * 0.8,
                              child: Divider(
                                height: 10.0,
                                color: Color.fromRGBO(8, 100, 175, 1.0),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Positioned(
                                bottom: 12,
                                child: Text(
                                  "UN Women provides reports, data, and publications related to gender-based violence, including global and regional statistics.",
                                  style: TextStyle(fontSize: 16.0),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 12.0,
                    ),
                    GestureDetector(
                      onTap: () {
                        _launchUrl('https://genderdata.worldbank.org/');
                      },
                      child: Card(
                        //clipBehavior: Clip.antiAlias,
                        color: Colors.white,
                        //elevation: 10.0,
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            ListTile(
                              leading: Image.asset(
                                'assets/images/world-bank-group.png',
                                height:
                                    MediaQuery.of(context).size.height * 0.3,
                                width: MediaQuery.of(context).size.width * 0.25,
                              ),
                              title: Row(
                                children: [
                                  Expanded(
                                    child: Text(
                                      'Gender Data Portal (World Bank)',
                                      style: TextStyle(fontSize: 17.0),
                                    ),
                                  ),
                                  Icon(
                                    CupertinoIcons.arrow_up_right_square,
                                    color: Colors.blue,
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              width: MediaQuery.of(context).size.width * 0.8,
                              child: Divider(
                                height: 10.0,
                                color: Color.fromRGBO(8, 100, 175, 1.0),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Positioned(
                                bottom: 12,
                                child: Text(
                                  "The World Bank's Gender Data Portal offers global data on gender equality and social inclusion, including indicators related to violence against women and girls.",
                                  style: TextStyle(fontSize: 16.0),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 12.0,
                    ),
                    GestureDetector(
                      onTap: () {
                        _launchUrl(
                            'https://www.who.int/health-topics/violence-against-women#tab=tab_1');
                      },
                      child: Card(
                        //clipBehavior: Clip.antiAlias,
                        color: Colors.white,
                        //elevation: 10.0,
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            ListTile(
                              leading: Image.asset(
                                'assets/images/who_gbv.png',
                                height:
                                    MediaQuery.of(context).size.height * 0.3,
                                width: MediaQuery.of(context).size.width * 0.25,
                              ),
                              title: Row(
                                children: [
                                  Expanded(
                                    child: Text(
                                      'WHO Violence against Women',
                                      style: TextStyle(fontSize: 17.0),
                                    ),
                                  ),
                                  Icon(
                                    CupertinoIcons.arrow_up_right_square,
                                    color: Colors.blue,
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              width: MediaQuery.of(context).size.width * 0.8,
                              child: Divider(
                                height: 10.0,
                                color: Color.fromRGBO(8, 100, 175, 1.0),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Positioned(
                                bottom: 12,
                                child: Text(
                                  "WHO offers global statistics on violence against women, along with research reports, fact sheets, and data visualizations.",
                                  style: TextStyle(fontSize: 16.0),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Positioned(
                top: MediaQuery.of(context).size.height * 0.71,
                left: MediaQuery.of(context).size.width * 0.76,
                child: IconButton(
                  padding: EdgeInsets.all(15.0),
                  iconSize: 28.0,
                  style: ButtonStyle(
                    backgroundColor:
                        MaterialStateProperty.resolveWith((states) {
                      if (states.contains(MaterialState.pressed)) {
                        return Color.fromRGBO(8, 100, 175, 1.0);
                      }
                      return Color.fromRGBO(8, 100, 175, 1.0);
                    }),
                    foregroundColor: MaterialStateProperty.all(Colors.white),
                  ),
                  onPressed: () => Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => Chatbot()),
                  ),
                  icon: Icon(CupertinoIcons.chat_bubble_fill),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _launchUrl(String url) async {
    try {
      await launch(Uri.parse(url).toString());
    } catch (e) {
      throw Exception('Could not launch $url: $e');
    }
  }
}
