import 'dart:io';

class Report implements Comparable<Report> {
  String? report_for;
  String? email;
  String? full_name;
  String? phone_number;
  String? gender;
  String? reg_no;
  String? college;
  String? abuse_type;
  String? dateTime;
  String? location;
  String? description;
  String? perpetrator_fullname;
  String? perpetrator_gender;
  String? relationship;
  String? report_id;
  String? status;
  String? assigned_gd;
  String? reporter;
  String? rejection_reason;
  String? reporter_full_name;
  String? reporter_gender;
  String? reporter_college;
  String? reporter_reg_no;
  String? reporter_email;
  String? reporter_phone;
  List<File>? evidence;
  String? police_status;
  String? assigned_officer;
  String? created_on;
  String? victim_email;
  String? victim_full_name;
  String? victim_phone;
  String? victim_gender;
  String? victim_reg_no;
  String? victim_college;
  String? date_and_time;
  String? other_location;

  Report({
    this.email,
    this.report_for,
    this.full_name,
    this.status,
    this.reporter_reg_no,
    this.reporter_phone,
    this.reporter_gender,
    this.reporter_full_name,
    this.reporter_email,
    this.reporter_college,
    this.reporter,
    this.report_id,
    this.relationship,
    this.police_status,
    this.perpetrator_gender,
    this.perpetrator_fullname,
    this.evidence,
    this.description,
    this.assigned_officer,
    this.assigned_gd,
    this.college,
    this.reg_no,
    this.gender,
    this.phone_number,
    this.location,
    this.abuse_type,
    this.dateTime,
    this.rejection_reason,
    this.created_on,
    this.victim_email,
    this.victim_full_name,
    this.victim_phone,
    this.victim_gender,
    this.victim_reg_no,
    this.victim_college,
    this.date_and_time,
    this.other_location,
  });

  Map<String, dynamic> toJsonReportData() => {
        // "report_for": "Self",
        "report_for": report_for,
        "victim_email": email,
        "victim_full_name": full_name,
        "victim_phone": phone_number,
        "victim_gender": gender,
        "victim_reg_no": reg_no,
        "victim_college": college,
        "abuse_type": abuse_type,
        "date_and_time": dateTime,
        "location": location,
        "other_location": other_location,
        "description": description,
        "perpetrator_fullname": perpetrator_fullname,
        "perpetrator_gender": perpetrator_gender,
        "relationship": relationship,
      };
  Map<String, dynamic> toJsonAnonymousReportData() => {
        "abuse_type": abuse_type,
        "date_and_time": dateTime,
        "location": location,
        "other_location": other_location,
        "description": description,
        "perpetrator_fullname": perpetrator_fullname,
        "perpetrator_gender": perpetrator_gender,
        "relationship": relationship,
      };

  factory Report.fromJson(Map<String, dynamic> json) {
    return Report(
      report_id: json["report_id"],
      report_for: json["report_for"],
      created_on: json["created_on"],
      status: json["status"],
      rejection_reason: json["rejection_reason"],
      reporter_full_name: json["reporter_full_name"],
      reporter_gender: json["reporter_gender"],
      reporter_college: json["reporter_college"],
      reporter_reg_no: json["reporter_reg_no"],
      reporter_email: json["reporter_email"],
      reporter_phone: json["reporter_phone"],
      victim_email: json["victim_email"],
      victim_full_name: json["victim_full_name"],
      victim_phone: json["victim_phone"],
      victim_gender: json["victim_gender"],
      victim_reg_no: json["victim_reg_no"],
      victim_college: json["victim_college"],
      abuse_type: json["abuse_type"],
      date_and_time: json["date_and_time"],
      location: json["location"],
      other_location: json["other_location"],
      description: json["description"],
      perpetrator_fullname: json["perpetrator_fullname"],
      perpetrator_gender: json["perpetrator_gender"],
      relationship: json["relationship"],
      police_status: json["police_status"],
      assigned_gd: json["assigned_gd"],
      reporter: json["reporter"],
      assigned_officer: json["assigned_officer"],
    );
  }

  @override
  int compareTo(Report other) => other.created_on!.compareTo(created_on!);
}
