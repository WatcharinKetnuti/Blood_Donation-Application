import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/authenthication_manager.dart';

class ProfileScreen extends StatelessWidget {
  final AuthenticationManager _authManager = Get.put(AuthenticationManager());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.redAccent,
      body: Center(
        child: Container(
          width: 320,
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
              ),
              SizedBox(height: 16),
              Text(
                'Emma Phillips',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                'Fashion Model',
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
                  Text('(581)-307-6902'),
                ],
              ),
              SizedBox(height: 8),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.email, color: Colors.grey),
                  SizedBox(width: 8),
                  Text('emma.phillips@gmail.com'),
                ],
              ),
              SizedBox(height: 16),
              ListTile(
                leading: Icon(Icons.logout, color: Colors.red),
                title: Text('Log out', style: TextStyle(color: Colors.red)),
                onTap: () {
                  _authManager.logOut();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
