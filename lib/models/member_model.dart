class Member {
  final String memberFname;
  final String memberLname;
  final DateTime memberBirthDate;
  final String memberTel;
  final String memberBloodType;
  final String memberEmail;
  final String memberPassword;

  Member({
    required this.memberFname,
    required this.memberLname,
    required this.memberBirthDate,
    required this.memberTel,
    required this.memberBloodType,
    required this.memberEmail,
    required this.memberPassword,
  });

  factory Member.fromJson(Map<String, dynamic> json) {
    return Member(
      memberFname: json['member_fname'],
      memberLname: json['member_lname'],
      memberBirthDate: DateTime.parse(json['member_birth_date']),
      memberTel: json['member_tel'],
      memberBloodType: json['member_blood_type'],
      memberEmail: json['member_email'],
      memberPassword: json['member_password'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'member_fname': memberFname,
      'member_lname': memberLname,
      'member_birth_date': memberBirthDate.toIso8601String(),
      'member_tel': memberTel,
      'member_blood_type': memberBloodType,
      'member_email': memberEmail,
      'member_password': memberPassword,
    };
  }
}