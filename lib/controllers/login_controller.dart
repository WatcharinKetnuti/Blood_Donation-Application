import 'package:get/get.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:blood_donation_application/controllers/api_service.dart';

class LoginController extends GetxController {
  var isPasswordVisible = false.obs;
  var isLoading = false.obs;
  var errorMessage = ''.obs;

  final formKey = GlobalKey<FormState>();
  final email = TextEditingController(text: 'default@example.com');
  final password = TextEditingController(text: 'defaultpassword');
  final ApiService apiService = ApiService();



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
    isLoading.value = true;
    var response = await apiService.login(email.text, password.text);
    if (response != null) {
      Get.snackbar('Success', 'Login successful');
    } else {
      errorMessage = 'อีเมล หรือ รหัสผ่านไม่ถูกต้อง'.obs;
    }
    isLoading.value = false;
  }
}
