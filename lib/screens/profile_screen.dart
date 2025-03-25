import 'package:blood_donation_application/controllers/login_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../services/authenthication_manager.dart';
import 'authen_screen.dart';

class ProfileScreen extends StatelessWidget {
  final AuthenticationManager _authManager = Get.put(AuthenticationManager());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.redAccent,
      body:
      Obx(() {
        //_authManager.getMember();
        final member = _authManager.member.value;
        return Center(
          child: Container(
            width: MediaQuery.of(context).size.width * 0.8,
            padding: EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
              boxShadow: [
                BoxShadow(
                  color: Colors.black12,
                  blurRadius: 10,
                  spreadRadius: 5,
                ),
              ],
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                CircleAvatar(
                  radius: 50,
                  backgroundImage: NetworkImage(
                      'https://upload.wikimedia.org/wikipedia/commons/9/99/Sample_User_Icon.png?20200919003010'),
                ),
                SizedBox(height: 16),
                Text(
                  '${member.memberFname} ${member.memberLname}',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  'รายละเอียด',
                  style: TextStyle(
                    color: Colors.grey,
                  ),
                ),
                SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.phone, color: Colors.grey),
                    SizedBox(width: 8),
                    Text('${member.memberTel}'),
                    SizedBox(width: 16),
                    Icon(CupertinoIcons.drop_fill, color: Colors.grey),
                    SizedBox(width: 8),
                    Text(member.memberBloodType ),
                  ],
                ),
                SizedBox(height: 8),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.email, color: Colors.grey),
                    SizedBox(width: 8),
                    Text(member.memberEmail ),
                  ],
                ),
                SizedBox(height: 8),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(CupertinoIcons.calendar, color: Colors.grey),
                    SizedBox(width: 8),
                    Text(member.memberBirthDate.toString() ),
                  ],
                ),
                SizedBox(height: 16),
                ListTile(
                  leading: Icon(Icons.logout, color: Colors.red),
                  title: Text('Log out', style: TextStyle(color: Colors.red)),
                  onTap: () {
                    _authManager.logOut();
                    Get.offAll(() => AuthenScreen());
                  },
                ),
              ],
            ),
          ),
        );
      }),
    );
  }
}
