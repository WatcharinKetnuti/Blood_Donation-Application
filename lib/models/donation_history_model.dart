import 'dart:convert';

List<DonationHistory> donationHistoryFromJson(String str) => List<DonationHistory>.from(json.decode(str).map((x) => DonationHistory.fromJson(x)));

String donationHistoryToJson(List<DonationHistory> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class DonationHistory {
  final String donationId;
  final String memberId;
  final String donationDate;
  final String locationName;
  final String bloodType;

  DonationHistory({
    required this.donationId,
    required this.memberId,
    required this.donationDate,
    required this.locationName,
    required this.bloodType,
  });

  factory DonationHistory.fromJson(Map<String, dynamic> json) {
    return DonationHistory(
      donationId: json['donation_id'],
      memberId: json['member_id'],
      donationDate: json['donation_date'],
      locationName: json['location_name'],
      bloodType: json['blood_type'],
    );
  }

  Map<String, dynamic> toJson() => {
    "donation_id": donationId,
    "member_id": memberId,
    "donation_date": donationDate,
    "location_name": locationName,
    "blood_type": bloodType,
  };
}