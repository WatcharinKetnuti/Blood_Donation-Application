import 'dart:convert';

List<Reserve> locationFromJson(String str) => List<Reserve>.from(json.decode(str).map((x) => Reserve.fromJson(x)));

String locationToJson(List<Reserve> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Reserve {
  final String memberId;
  final String scheduleId;
  final DateTime reserveDonationDate;

  Reserve({
    required this.memberId,
    required this.scheduleId,
    required this.reserveDonationDate,
  });

  factory Reserve.fromJson(Map<String, dynamic> json) => Reserve(
    memberId: json["member_id"],
    scheduleId: json["schedule_id"],
    reserveDonationDate: DateTime.parse(json["reserve_donation_date"]),
  );

  Map<String, dynamic> toJson() => {
    "member_id": memberId,
    "schedule_id": scheduleId,
    "reserve_donation_date": "${reserveDonationDate.year.toString().padLeft(4, '0')}-${reserveDonationDate.month.toString().padLeft(2, '0')}-${reserveDonationDate.day.toString().padLeft(2, '0')}",
  };
}
