import 'package:blood_donation_application/screens/authen_screen.dart';
import 'package:get/get.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import '../models/member_model.dart';
import '../services/api_service.dart';
import '../services/authenthication_manager.dart';


class LoginController extends GetxController {
  final ApiService apiService = ApiService();
  final AuthenticationManager _authManager = Get.put(AuthenticationManager());
  final box = GetStorage();

  final formKey = GlobalKey<FormState>();
  // final email = TextEditingController();
  // final password = TextEditingController();
  var isPasswordVisible = false.obs;
  var isLoading = false.obs;
  var errorMessage = ''.obs;



  final email = TextEditingController(text: 'default@example.com');
  final password = TextEditingController(text: 'defaultpassword');

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
        errorMessage.value = 'เกิดข้อผิดพลาดในการเชื่อมต่อเซิฟเวอร์';
      }
    });

    var response = await apiService.login(email.text, password.text);
    isResponseReceived = true;
    print(response);

    if (response != null) {
      box.write('member', response['0']);
      Get.snackbar('Success', 'Login successful');
      _authManager.login(response['token']);
      Get.offAll(() => AuthenScreen());
    } else {
      errorMessage.value = 'อีเมล หรือ รหัสผ่านไม่ถูกต้อง';
    }
    isLoading.value = false;
  }
}
