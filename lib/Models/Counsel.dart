import 'dart:io';

class Counsel {
  String? student_email;
  String? student_full_name;
  String? student_phone;
  String? student_gender;
  String? appointment_id;
  String? student_reg_no;
  //String? college;
  String? date;
  String? session_type;
  String? created_on;
  String? status;

  Counsel({
    this.student_email,
    this.session_type,
    this.student_full_name,
    this.student_gender,
    //this.college,
    this.student_reg_no,
    this.student_phone,
    this.date,
    this.appointment_id,
    this.created_on,
    this.status,
  });

  Map<String, dynamic> toJsonCounselData() {
    return {
      'student_full_name': student_full_name,
      'student_gender': student_gender,
      //'college': college,
      'date': date,
      "student_phone":student_phone,
      'student_email': student_email,
      'student_reg_no': student_reg_no,
      'session_type': session_type,
    };
  }

  static Counsel fromJson(Map<String, dynamic> json) {
    return Counsel(
      student_full_name: json['student_full_name'],
      student_gender: json['student_gender'],
      //college: json['college'],
      date: json['date'],
      student_email: json['student_email'],
      student_reg_no: json['student_reg_no'],
      session_type: json['session_type'],
    );
  }
}
