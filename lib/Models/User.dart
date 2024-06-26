import 'dart:developer';

class User {
  String? id;
  String? full_name;
  String? email;
  String? phone_number;
  String? gender;
  String? reg_no;
  String? college;
  String? staff_no;
  String? office;
  String? police_no;
  String? station;
  String? password;
  String? date_joined;
  bool? is_active;
  bool? is_staff;
  bool? is_consultant;
  bool? is_genderdesk;
  bool? is_student;
  bool? is_police;
  String? token;
  String? refresh;
  String? last_login;
  String? otp;
  String? new_password;
  String? old_password;
  Map? profile;

  User(
      {this.id,
      this.full_name,
      this.email,
      this.phone_number,
      this.gender,
      this.reg_no,
      this.college,
      this.staff_no,
      this.office,
      this.date_joined,
      this.police_no,
      this.is_staff,
      this.is_active,
      this.is_consultant,
      this.is_genderdesk,
      this.is_student,
      this.is_police,
      this.station,
      this.password,
      this.last_login,
      this.otp,
      this.token,
      this.refresh,
      this.new_password,
      this.old_password,
      this.profile});

  Map<String, dynamic> toLoginJson() => {
        "email": email,
        "password": password,
      };
  Map<String, dynamic> toRefreshJson() => {
        "refresh": refresh,
        "access": token,
      };

  Map<String, dynamic> toOtpJson() => {
        "email": email,
        "otp": otp,
      };
  Map<String, dynamic> toResetJson() => {
        "email": email,
        "otp": otp,
        "new_password": new_password,
      };

  Map<String, dynamic> toStudentSignupJson() => {
        "full_name": full_name,
        "phone_number": phone_number,
        "gender": gender,
        "reg_no": reg_no,
        "college": college,
        "email": email,
        "password": password,
      };

  Map<String, dynamic> toGenderDeskSignupJson() => {
        "email": email,
        "full_name": full_name,
        "phone_number": phone_number,
        "gender": gender,
        "password": password,
        "office": office,
        "staff_no": staff_no
      };

  Map<String, dynamic> toJsonStorage() => {
        "id": id,
        "email": email,
        "full_name": full_name,
        "phone_number": phone_number,
        "gender": gender,
        "is_active": is_active,
        "is_staff": is_staff,
        "is_student": is_student,
        "is_genderdesk": is_genderdesk,
        "is_consultant": is_consultant,
        "is_police": is_police,
        "date_joined": date_joined,
        "last_login": last_login,
        "token": token,
        "refresh": refresh,
        "reg_no": reg_no,
        "college": college,
        "profile": profile
      };

  Map<String, dynamic> toPasswordChangeJson() => {
        "old_password": old_password,
        "new_password": new_password,
      };

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'].toString(),
      full_name: json['full_name'],
      email: json['email'],
      gender: json['gender'],
      office: json['office'],
      date_joined: json['date_joined'].toString(),
      last_login: json['last_login'].toString(),
      is_consultant: json['is_consultant'] != null
          ? bool.parse(json['is_consultant'].toString())
          : false,
      is_active: json['is_active'] != null
          ? bool.tryParse(json['is_active'].toString())
          : false,
      is_staff: json['is_staff'] != null
          ? bool.tryParse(json['is_staff'].toString())
          : false,
      is_student: json['is_student'] != null
          ? bool.tryParse(json['is_student'].toString())
          : false,
      is_police: json['is_police'] != null
          ? bool.tryParse(json['is_police'].toString())
          : false,
      is_genderdesk: json['is_genderdesk'] != null
          ? bool.tryParse(json['is_genderdesk'].toString())
          : false,
      phone_number: json['phone_number'],
      token: json['tokens']['access'],
    );
  }

  factory User.fromLoginJson(Map<String, dynamic> json) {
    return User(
      id: json['user']['id'].toString(),
      full_name: json['user']['full_name'],
      email: json['user']['email'],
      gender: json['user']['gender'],
      office: json['user']['office'],
      date_joined: json['user']['date_joined'].toString(),
      last_login: json['user']['last_login'].toString(),
      is_consultant: json['user']['is_consultant'] != null
          ? bool.parse(json['user']['is_consultant'].toString())
          : false,
      is_active: json['user']['is_active'] != null
          ? bool.tryParse(json['user']['is_active'].toString())
          : false,
      is_staff: json['user']['is_staff'] != null
          ? bool.tryParse(json['user']['is_staff'].toString())
          : false,
      is_student: json['user']['is_student'] != null
          ? bool.tryParse(json['user']['is_student'].toString())
          : false,
      is_police: json['user']['is_police'] != null
          ? bool.tryParse(json['user']['is_police'].toString())
          : false,
      is_genderdesk: json['user']['is_genderdesk'] != null
          ? bool.tryParse(json['user']['is_genderdesk'].toString())
          : false,
      phone_number: json['user']['phone_number'],
      token: json['tokens']['access'],
      refresh: json['tokens']['refresh'],
      profile: json['user']['profile'],
      reg_no: json['user']['profile']['reg_no'],
      college: json['user']['profile']['college'],
    );
  }

  factory User.fromJsonStorage(Map<String, dynamic> json) {
    return User(
      id: json['id'].toString(),
      full_name: json['full_name'],
      email: json['email'],
      gender: json['gender'],
      office: json['office'],
      date_joined: json['date_joined'].toString(),
      last_login: json['last_login'].toString(),
      is_consultant: json['is_consultant'] != null
          ? bool.parse(json['is_consultant'].toString())
          : false,
      is_active: json['is_active'] != null
          ? bool.tryParse(json['is_active'].toString())
          : false,
      is_staff: json['is_staff'] != null
          ? bool.tryParse(json['is_staff'].toString())
          : false,
      is_student: json['is_student'] != null
          ? bool.tryParse(json['is_student'].toString())
          : false,
      is_police: json['is_police'] != null
          ? bool.tryParse(json['is_police'].toString())
          : false,
      is_genderdesk: json['is_genderdesk'] != null
          ? bool.tryParse(json['is_genderdesk'].toString())
          : false,
      phone_number: json['phone_number'],
      token: json['token'],
      refresh: json['refresh'],
      profile: json['profile'],
      reg_no: json['profile']['reg_no'],
      college: json['profile']['college'],
    );
  }
}
