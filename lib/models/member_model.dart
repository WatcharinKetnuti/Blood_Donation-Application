import 'dart:convert';

List<Member> memberFromJson(String str) =>
    List<Member>.from(json.decode(str).map((x) => Member.fromJson(x)));

String memberToJson(List<Member> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Member {
  final String memberID;
  final String memberFname;
  final String memberLname;
  final DateTime memberBirthDate;
  final String memberTel;
  final String memberCardID;
  final String memberAddress;
  final String memberBloodType;
  final String memberEmail;
  final String memberPassword;

  Member({
    required this.memberID,
    required this.memberFname,
    required this.memberLname,
    required this.memberBirthDate,
    required this.memberTel,
    required this.memberCardID,
    required this.memberAddress,
    required this.memberBloodType,
    required this.memberEmail,
    required this.memberPassword,
  });

  factory Member.fromJson(Map<String, dynamic> json) {
    return Member(
      memberID: json['member_id'],
      memberFname: json['member_fname'],
      memberLname: json['member_lname'],
      memberBirthDate: DateTime.parse(json['member_birth_date']),
      memberTel: json['member_tel'],
      memberCardID: json['member_cardID'],
      memberAddress: json['member_address'],
      memberBloodType: json['member_blood_type'],
      memberEmail: json['member_email'],
      memberPassword: json['member_password'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'member_id': memberID,
      'member_fname': memberFname,
      'member_lname': memberLname,
      'member_birth_date': memberBirthDate.toIso8601String(),
      'member_tel': memberTel,
      'member_cardID': memberCardID,
      'member_address': memberAddress,
      'member_blood_type': memberBloodType,
      'member_email': memberEmail,
      'member_password': memberPassword,
    };
  }
}