class Report {
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
  String? reporter_full_name;
  String? reporter_gender;
  String? reporter_college;
  String? reporter_reg_no;
  String? reporter_email;
  String? reporter_phone;
  String? evidence;
  String? police_status;
  String? assigned_officer;

  Report({
    this.email,
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
  });

  Map<String, dynamic> toJsonReportData() => {
        "report_for": "Self",
        "victim_email": email,
        "victim_full_name": full_name,
        "victim_phone": phone_number,
        "victim_gender": gender,
        "victim_reg_no": reg_no,
        "victim_college": college,
        "abuse_type": abuse_type,
        "date_and_time": dateTime,
        "location": location,
        "description": description,
        "perpetrator_fullname": perpetrator_fullname,
        "perpetrator_gender": perpetrator_gender,
        "relationship": relationship,
        "report_id": report_id,
        "status": status,
        "assigned_gd": assigned_gd,
        "reporter": reporter,
        "reporter_full_name": reporter_full_name,
        "reporter_gender": reporter_gender,
        "reporter_college": reporter_college,
        "reporter_reg_no": reporter_reg_no,
        "reporter_email": reporter_email,
        "reporter_phone": reporter_phone,
        "evidence": evidence,
        "police_status": police_status,
        "assigned_officer": assigned_officer
      };
}
