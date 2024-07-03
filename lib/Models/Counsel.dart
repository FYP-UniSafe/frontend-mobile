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

  String? start_time;
  String? end_time;
  String? timeSlot;
  String? physical_location;

  String? consultant_phone;
  String? consultant_office;
  String? reportId;
  String? client;
  String? consultant;

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
    this.client,
    this.reportId,
    this.consultant,
    this.consultant_office,
    this.consultant_phone,
    this.end_time,
    this.physical_location,
    this.start_time,
    this.timeSlot,
  });

  Map<String, dynamic> toJsonCounselData() {
    return {
      'student_full_name': student_full_name,
      'student_gender': student_gender,
      //'college': college,
      'date': date,
      'student_phone': student_phone,
      'student_email': student_email,
      'student_reg_no': student_reg_no,
      'session_type': session_type,
      'client': client,
      'consultantPhone': consultant_phone,
      'end_time': end_time,
      'physicalLocation': physical_location,
      'start_time': start_time,
      'timeSlot': timeSlot,
      'reportId': reportId,
      'consultant': consultant,
      'consultantOffice': consultant_office
    };
  }

  static Counsel fromJson(Map<String, dynamic> json) {
    return Counsel(
      student_full_name: json['student_full_name'],
      student_gender: json['student_gender'],
      student_phone: json['student_phone'],
      //college: json['college'],
      date: json['date'],
      created_on: json['created_on'],
      appointment_id: json['appointment_id'],
      student_email: json['student_email'],
      student_reg_no: json['student_reg_no'],
      session_type: json['session_type'],
      status: json['status'],
      client: json['client'],
      consultant: json['consultant'],
      consultant_office: json['consultant_office'],
      consultant_phone: json['consultant_phone'],
      timeSlot: json['timeSlot'],
      reportId: json['reportId'],
      physical_location: json['physical_location'],
      start_time: json['start_time'],
      end_time: json['end_time'],
    );
  }
}
