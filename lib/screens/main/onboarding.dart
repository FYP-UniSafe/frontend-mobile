import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:unisafe/Services/storage.dart';
import 'package:unisafe/screens/authorization/login.dart';

import '../../Services/stateObserver.dart';

class Onboarding extends StatefulWidget {
  const Onboarding({super.key});

  @override
  State<Onboarding> createState() => _OnboardingState();
}

class _OnboardingState extends State<Onboarding> {
  final controller = PageController();
  bool isLastPage = false;

  final _appStateObserver = AppStateObserver();
  @override
  void initState() {
    WidgetsBinding.instance.addObserver(_appStateObserver);
    super.initState();
  }

  @override
  void dispose() {

    WidgetsBinding.instance.removeObserver(_appStateObserver);
    controller.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.98,
      child: Scaffold(
        body: Container(
          padding: EdgeInsets.only(bottom: 50.0),
          child: PageView(
            controller: controller,
            onPageChanged: (index) {
              setState(() => isLastPage = index == 2);
            },
            children: [
              Padding(
                padding: EdgeInsets.all(16.0),
                child: Container(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'UniSafe',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 28.0,
                          color: Color.fromRGBO(8, 100, 175, 1.0),
                          shadows: [
                            Shadow(
                              color: Colors.grey,
                              blurRadius: 4.0,
                              offset: Offset(5.0, 5.0),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 10.0,
                      ),
                      Text(
                        'Welcome to UniSafe!',
                        style: TextStyle(
                          fontSize: 18.0,
                        ),
                      ),
                      SizedBox(
                        height: 12.0,
                      ),
                      Image.asset(
                        'assets/images/welcome.png',
                        height: MediaQuery.of(context).size.height * 0.3,
                      ),
                      SizedBox(
                        height: 8.0,
                      ),
                      Padding(
                        padding: EdgeInsets.all(16.0),
                        child: Text(
                          'In a world that should be free from fear and violence, we recognize the urgent need of a platform that empowers individuals to speak out, report incidents, and collectively contribute to a safer and more just society.',
                          style: TextStyle(fontSize: 16.0),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.all(16.0),
                child: Container(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'UniSafe',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 28.0,
                          color: Color.fromRGBO(8, 100, 175, 1.0),
                          shadows: [
                            Shadow(
                              color: Colors.grey,
                              blurRadius: 4.0,
                              offset: Offset(5.0, 5.0),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 10.0,
                      ),
                      Text(
                        'SHARE YOUR STORY',
                        style: TextStyle(fontSize: 18.0),
                      ),
                      SizedBox(
                        height: 12.0,
                      ),
                      Image.asset('assets/images/share_story.png'),
                      SizedBox(
                        height: 12.0,
                      ),
                      Padding(
                        padding: EdgeInsets.all(16.0),
                        child: Text(
                          'Reporting is easy. All you need to do is tell us what happened, where, and when. You can use your mobile or a computer to report.',
                          style: TextStyle(fontSize: 16.0),
                        ),
                      )
                    ],
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.all(16.0),
                child: Container(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'UniSafe',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 28.0,
                          color: Color.fromRGBO(8, 100, 175, 1.0),
                          shadows: [
                            Shadow(
                              color: Colors.grey,
                              blurRadius: 4.0,
                              offset: Offset(5.0, 5.0),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 10.0,
                      ),
                      Text(
                        'SEEK PSYCHOLOGICAL HELP',
                        style: TextStyle(fontSize: 18.0),
                      ),
                      SizedBox(
                        height: 12.0,
                      ),
                      Image.asset(
                        'assets/images/counsel.png',
                        height: MediaQuery.of(context).size.height * 0.35,
                      ),
                      Padding(
                        padding: EdgeInsets.all(16.0),
                        child: Text(
                          'Get psychological help from professional counselors willing to provide you with the best legal advice.',
                          style: TextStyle(fontSize: 16.0),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
        bottomSheet: isLastPage
            ? Container(
                color: Colors.white,
                padding: EdgeInsets.symmetric(horizontal: 32.0, vertical: 32.0),
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () async {
                    await LocalStorage.storeOnboarding();
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (BuildContext context) => Login(),
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    elevation: 3,
                    backgroundColor: Color.fromRGBO(8, 100, 175, 1.0),
                    padding: EdgeInsets.all(12.0),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                  ),
                  child: Text(
                    'Join Us Today',
                    style: TextStyle(
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
              )
            : Container(
                color: Colors.white,
                padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
                height: MediaQuery.of(context).size.height * 0.12,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    TextButton(
                      onPressed: () => controller.jumpToPage(2),
                      child: Text(
                        'SKIP',
                        style: TextStyle(
                          fontSize: 16.0,
                          color: Color.fromRGBO(8, 100, 175, 1.0),
                        ),
                      ),
                    ),
                    Center(
                      child: SmoothPageIndicator(
                        controller: controller,
                        count: 3,
                        effect: WormEffect(
                          spacing: 12,
                          dotColor: Colors.grey,
                          dotWidth: 13.0,
                          dotHeight: 13.0,
                          activeDotColor: Color.fromRGBO(8, 100, 175, 1.0),
                        ),
                        onDotClicked: (index) => controller.animateToPage(index,
                            duration: Duration(milliseconds: 300),
                            curve: Curves.easeIn),
                      ),
                    ),
                    TextButton(
                      onPressed: () => controller.nextPage(
                          duration: Duration(milliseconds: 300),
                          curve: Curves.easeInOut),
                      child: Text(
                        'NEXT',
                        style: TextStyle(
                          fontSize: 16.0,
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
