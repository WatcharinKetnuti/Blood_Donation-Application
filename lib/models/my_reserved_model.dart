import 'dart:convert';

List<Reserved> reservedFromJson(String str) => List<Reserved>.from(json.decode(str).map((x) => Reserved.fromJson(x)));

String reservedToJson(List<Reserved> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Reserved {
  final String reserveId;
  final DateTime reserveDate;
  final String reserveStatus;
  final String memberId;
  final String locationName;
  final String locationDetail;
  final DateTime scheduleStartDate;
  final DateTime scheduleEndDate;
  final String scheduleStartTime;
  final String scheduleEndTime;
  final String scheduleDetail;
  final DateTime reserveDonationDate;

  Reserved({
    required this.reserveId,
    required this.reserveDate,
    required this.reserveStatus,
    required this.memberId,
    required this.locationName,
    required this.locationDetail,
    required this.scheduleStartDate,
    required this.scheduleEndDate,
    required this.scheduleStartTime,
    required this.scheduleEndTime,
    required this.scheduleDetail,
    required this.reserveDonationDate,
  });

  factory Reserved.fromJson(Map<String, dynamic> json) => Reserved(
    reserveId: json["reserve_id"],
    reserveDate: DateTime.parse(json["reserve_date"]),
    reserveStatus: json["reserve_status"],
    memberId: json["member_id"],
    locationName: json["location_name"],
    locationDetail: json["location_detail"],
    scheduleStartDate: DateTime.parse(json["schedule_start_date"]),
    scheduleEndDate: DateTime.parse(json["schedule_end_date"]),
    scheduleStartTime: json["schedule_start_time"],
    scheduleEndTime: json["schedule_end_time"],
    scheduleDetail: json["schedule_detail"],
    reserveDonationDate: DateTime.parse(json["reserve_donation_date"]),
  );

  Map<String, dynamic> toJson() => {
    "reserve_id": reserveId,
    "reserve_date": reserveDate.toIso8601String(),
    "reserve_status": reserveStatus,
    "member_id": memberId,
    "location_name": locationName,
    "location_detail": locationDetail,
    "schedule_start_date": "${scheduleStartDate.year.toString().padLeft(4, '0')}-${scheduleStartDate.month.toString().padLeft(2, '0')}-${scheduleStartDate.day.toString().padLeft(2, '0')}",
    "schedule_end_date": "${scheduleEndDate.year.toString().padLeft(4, '0')}-${scheduleEndDate.month.toString().padLeft(2, '0')}-${scheduleEndDate.day.toString().padLeft(2, '0')}",
    "schedule_start_time": scheduleStartTime,
    "schedule_end_time": scheduleEndTime,
    "schedule_detail": scheduleDetail,
    "reserve_donation_date": "${reserveDonationDate.year.toString().padLeft(4, '0')}-${reserveDonationDate.month.toString().padLeft(2, '0')}-${reserveDonationDate.day.toString().padLeft(2, '0')}",
  };
}
