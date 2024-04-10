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
  String? last_login;

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
      this.token});

  Map<String, dynamic> toLoginJson() => {
        "email": email,
        "password": password,
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

  Map<String, dynamic> toJsonStorage() => {
        "id": id,
        "email": email,
        "full_name": full_name,
        "phone_number": phone_number,
        "gender": gender,
        "is_active": is_active,
        "is_staff": is_staff,
        "is_student": is_student,
        "date_joined": date_joined,
        "last_login": last_login,
        "token": token
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
    );
  }
}
