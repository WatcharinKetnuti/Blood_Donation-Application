import 'package:get/get.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:blood_donation_application/controllers/api_service.dart';

import 'authenthication_manager.dart';

class LoginController extends GetxController {
  var isPasswordVisible = false.obs;
  var isLoading = false.obs;
  var errorMessage = ''.obs;

  final formKey = GlobalKey<FormState>();
  final email = TextEditingController(text: 'default@example.com');
  final password = TextEditingController(text: 'defaultpassword');
  final ApiService apiService = ApiService();
  final AuthenticationManager _authManager = Get.put(AuthenticationManager());



  String? validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'Email is required';
    }
    return null;
  }

  String? validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Password is required';
    }
    return null;
  }

  void togglePasswordVisibility() {
    isPasswordVisible.value = !isPasswordVisible.value;
    //print(isPasswordVisible);
  }

  Future<void> login() async {
    errorMessage.value = '';
    isLoading.value = true;
    bool isResponseReceived = false;

    print('=== login_controoler ===');

    Future.delayed(Duration(seconds: 3), () {
      if (!isResponseReceived) {
        isLoading.value = false;
        errorMessage.value = 'เกิดข้อผิดพลาดในการเชื่อมต่อเซิฟเวอร์ โปรดลองอีกครั้ง';
      }
    });

    var response = await apiService.login(email.text, password.text);

    isResponseReceived = true;

    print(response);

    if (response != null) {
      Get.snackbar('Success', 'Login successful');
      _authManager.login(response['token']);
    } else {
      errorMessage.value = 'อีเมล หรือ รหัสผ่านไม่ถูกต้อง';
    }
    isLoading.value = false;
  }
}
