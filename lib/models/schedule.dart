class ScheduleList {
  final String scheduleId;
  final String scheduleStartDate;
  final String scheduleEndDate;
  final String scheduleStartTime;
  final String scheduleEndTime;
  final String scheduleMax;
  final String scheduleBloodType;
  final String scheduleStatus;
  final String scheduleDetail;
  final String locationId;
  final String adminId;
  final String locationName;
  final String locationDetail;

  ScheduleList({
    required this.scheduleId,
    required this.scheduleStartDate,
    required this.scheduleEndDate,
    required this.scheduleStartTime,
    required this.scheduleEndTime,
    required this.scheduleMax,
    required this.scheduleBloodType,
    required this.scheduleStatus,
    required this.scheduleDetail,
    required this.locationId,
    required this.adminId,
    required this.locationName,
    required this.locationDetail,
  });

  factory ScheduleList.fromJson(Map<String, dynamic> json) {
    return ScheduleList(
      scheduleId: json['schedule_id'],
      scheduleStartDate: json['schedule_start_date'],
      scheduleEndDate: json['schedule_end_date'],
      scheduleStartTime: json['schedule_start_time'],
      scheduleEndTime: json['schedule_end_time'],
      scheduleMax: json['schedule_max'],
      scheduleBloodType: json['schedule_blood_type'],
      scheduleStatus: json['schedule_status'],
      scheduleDetail: json['schedule_detail'],
      locationId: json['location_id'],
      adminId: json['admin_id'],
      locationName: json['location_name'],
      locationDetail: json['location_detail'],
    );
  }
}

class Schedule {
  final String title;

  Schedule({required this.title});

  factory Schedule.fromJson(Map<String, dynamic> json) {
    return Schedule(
      title: json['title'],
    );
  }
}