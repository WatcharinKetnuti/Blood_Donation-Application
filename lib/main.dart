import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import 'package:blood_donation_application/screens/authen_screen.dart';
void main() async {
  await GetStorage.init();
  runApp(GetMaterialApp(
    title: "Blood Donation Application",
    home: AuthenScreen() ,
  ));
}
