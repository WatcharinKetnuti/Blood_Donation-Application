import 'dart:convert';

import 'package:intl/intl.dart';

List<Reserved> reservedFromJson(String str) => List<Reserved>.from(json.decode(str).map((x) => Reserved.fromJson(x)));

String reservedToJson(List<Reserved> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Reserved {
  final String reserveId;
  final String reserveDate;
  final String reserveStatus;
  final String memberId;
  final String locationName;
  final String locationDetail;
  final String scheduleStartDate;
  final String scheduleEndDate;
  final String scheduleStartTime;
  final String scheduleEndTime;
  final String scheduleDetail;
  final String reserveDonationDate;

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
    reserveDate: json["reserve_date"],
    reserveStatus: json["reserve_status"],
    memberId: json["member_id"],
    locationName: json["location_name"],
    locationDetail: json["location_address"],
    scheduleStartDate: json["schedule_start_date"],
    scheduleEndDate: json["schedule_end_date"],
    scheduleStartTime: json["schedule_start_time"],
    scheduleEndTime: json["schedule_end_time"],
    scheduleDetail: json["schedule_detail"],
    reserveDonationDate: json["reserve_donation_date"],
  );

  Map<String, dynamic> toJson() => {
    "reserve_id": reserveId,
    "reserve_date": reserveDate,
    "reserve_status": reserveStatus,
    "member_id": memberId,
    "location_name": locationName,
    "location_address": locationDetail,
    "schedule_start_date": scheduleStartDate,
    "schedule_end_date": scheduleEndDate,
    "schedule_start_time": scheduleStartTime,
    "schedule_end_time": scheduleEndTime,
    "schedule_detail": scheduleDetail,
    "reserve_donation_date": reserveDonationDate,
  };

  String formatDate(String date) {
    final parsedDate = DateTime.parse(date);
    return DateFormat('dd/MM/yyyy').format(parsedDate);
  }

}
