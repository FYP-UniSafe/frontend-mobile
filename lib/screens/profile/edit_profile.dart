import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:unisafe/resources/validator.dart';
import 'dart:io';

import '../../Services/stateObserver.dart';
import '../../Services/storage.dart';

class EditProfile extends StatefulWidget {
  const EditProfile({super.key});

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  final _formKey = GlobalKey<FormState>();

  TextEditingController _fullName = TextEditingController();
  TextEditingController _phone = TextEditingController();
  TextEditingController _email = TextEditingController();

  late LocalStorageProvider storageProvider;

  final _appStateObserver = AppStateObserver();


  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(_appStateObserver);
    super.dispose();
  }

  @override
  void initState() {
    WidgetsBinding.instance.addObserver(_appStateObserver);
    final storageProviders =
        Provider.of<LocalStorageProvider>(context, listen: false);

    if (storageProviders.user!.full_name != null) {
      _fullName = TextEditingController(text: storageProviders.user!.full_name);
    }

    if (storageProviders.user!.phone_number != null) {
      _phone = TextEditingController(text: storageProviders.user!.phone_number);
    }

    if (storageProviders.user!.email != null) {
      _email = TextEditingController(text: storageProviders.user!.email);
    }

    super.initState();
  }

  @override
  void didChangeDependencies() {
    storageProvider = Provider.of<LocalStorageProvider>(context);

    super.didChangeDependencies();
  }

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
  String? college;

  final ImagePicker _picker = ImagePicker();

  Future<void> _changeProfileImage() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      File imageFile = File(pickedFile.path);
      await LocalStorage.storeProfileImage(imageFile, profile: '');

      setState(() {
        // Update your profile image widget with the new image
        //_profileImage = imageFile;
      });
    }
  }

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
            'Edit Profile',
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
              Center(
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
                    Positioned(
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
                            Icons.photo_camera,
                            size: 28.0,
                          ),
                          color: Colors.grey.shade700,
                          onPressed: _changeProfileImage,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 40.0,
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
                        SizedBox(height: 20.0),
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
                        SizedBox(height: 20.0),
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
                        SizedBox(height: 20.0),
                        DropdownButtonFormField(
                          //alignment: Alignment.bottomCenter,
                          autovalidateMode: AutovalidateMode.onUserInteraction,
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
                        SizedBox(height: 30.0),
                        ElevatedButton(
                          onPressed: () {
                            if (_formKey.currentState!.validate()) {}
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
                            'Update Profile',
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
        ));
  }
}
