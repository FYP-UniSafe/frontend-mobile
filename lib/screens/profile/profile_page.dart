import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:unisafe/Services/storage.dart';
import 'package:unisafe/screens/authorization/login.dart';
import 'package:unisafe/screens/authorization/otp.dart';
import 'package:unisafe/screens/chatbot.dart';
import 'package:unisafe/screens/profile/account_security.dart';
import 'package:unisafe/screens/profile/contact_page.dart';
import 'package:unisafe/screens/profile/edit_profile.dart';
import 'package:unisafe/screens/profile/profile_menu.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {


  late LocalStorageProvider storageProvider;


  @override
  void didChangeDependencies() {
   storageProvider = Provider.of<LocalStorageProvider>(context);
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.98,
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.all(16.0),
            child: Center(
              child: Stack(
                children: [
                  SizedBox(
                    width: 120,
                    height: 120,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(100),
                      child: Image(
                        image: AssetImage('assets/images/profile_image.jpg'),
                      ),
                    ),
                  ),
                  /*Positioned(
                    bottom: 0,
                    right: 0,
                    child: Container(
                      width: 35,
                      height: 35,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(100),
                      ),
                      child: IconButton(
                        icon: Icon(
                          Icons.camera_alt,
                          size: 28.0,
                        ),
                        color: Color.fromRGBO(54, 37, 85, 1.0),
                        onPressed: () {},
                      ),
                    ),
                  ),*/
                ],
              ),
            ),
          ),
          /* SizedBox(
            height: 10.0,
          ),*/
          Text(
           storageProvider.user!.full_name!,
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20.0),
          ),
          Text(
            storageProvider.user!.email!,
            style: TextStyle(fontSize: 16.0),
          ),
          SizedBox(
            height: 10.0,
          ),
          ProfileMenu(
            text: "Personal Details",
            icon: Icon(
              Icons.edit,
              size: 26.0,
              color: Color.fromRGBO(8, 100, 175, 1.0),
            ),
            press: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => EditProfile()),
            ),
          ),
          ProfileMenu(
            text: "Update Password",
            icon: Icon(
              Icons.key,
              size: 26.0,
              color: Color.fromRGBO(8, 100, 175, 1.0),
            ),
            press: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => AccountSecurity()),
            ),
          ),
          ProfileMenu(
            text: "Contact Us",
            icon: Icon(
              Icons.phone,
              size: 26.0,
              color: Color.fromRGBO(8, 100, 175, 1.0),
            ),
            press: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => ContactPage()),
            ),
          ),
          ProfileMenu(
              text: "Log Out",
              icon: Icon(
                Icons.logout,
                size: 26.0,
                color: Colors.red,
              ),
              press: () async {
                await LocalStorage.logout();
                Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(builder: (context) => Login()),
                    (route) => false);
              }),
        ],
      ),
    );
  }
}
