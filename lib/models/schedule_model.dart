import 'dart:convert';

List<Schedule> scheduleListFromJson(String str) =>
    List<Schedule>.from(json.decode(str).map((x) => Schedule.fromJson(x)));

String scheduleListToJson(List<Schedule> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Schedule {
  final String scheduleId;
  final String scheduleStartDate;
  final String scheduleEndDate;
  final String scheduleStartTime;
  final String scheduleEndTime;
  final String scheduleBloodType;
  final String scheduleStatus;
  final String scheduleDetail;
  final String locationId;
  final String adminId;
  final String locationName;
  final String locationDetail;

  Schedule({
    required this.scheduleId,
    required this.scheduleStartDate,
    required this.scheduleEndDate,
    required this.scheduleStartTime,
    required this.scheduleEndTime,
    required this.scheduleBloodType,
    required this.scheduleStatus,
    required this.scheduleDetail,
    required this.locationId,
    required this.adminId,
    required this.locationName,
    required this.locationDetail,
  });

  factory Schedule.fromJson(Map<String, dynamic> json) {
    return Schedule(
      scheduleId: json['schedule_id'],
      scheduleStartDate: json['schedule_start_date'],
      scheduleEndDate: json['schedule_end_date'],
      scheduleStartTime: json['schedule_start_time'],
      scheduleEndTime: json['schedule_end_time'],
      scheduleBloodType: json['schedule_blood_type'],
      scheduleStatus: json['schedule_status'],
      scheduleDetail: json['schedule_detail'],
      locationId: json['location_id'],
      adminId: json['admin_id'],
      locationName: json['location_name'],
      locationDetail: json['location_address'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'schedule_id': scheduleId,
      'schedule_start_date': scheduleStartDate,
      'schedule_end_date': scheduleEndDate,
      'schedule_start_time': scheduleStartTime,
      'schedule_end_time': scheduleEndTime,
      'schedule_blood_type': scheduleBloodType,
      'schedule_status': scheduleStatus,
      'schedule_detail': scheduleDetail,
      'location_id': locationId,
      'admin_id': adminId,
      'location_name': locationName,
      'location_address': locationDetail,
    };
  }

}
