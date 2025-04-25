import 'package:blood_donation_application/services/cache_manager.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../models/member_model.dart';
import '../services/api_service.dart';

class RegisterController extends GetxController {
  Dio dio = Dio();
  final ApiService api = ApiService();
  var isLoading = false.obs;
  var errorMessage = ''.obs;

  final formKey = GlobalKey<FormState>();
  // final  firstName = TextEditingController();
  // final  lastName = TextEditingController();
  // final  email = TextEditingController();
  // final  password = TextEditingController();
  // final  confirmPassword = TextEditingController();
  // final  birthdate = TextEditingController();
  // final  tel = TextEditingController();
  // final cardID = TextEditingController();
  // final address = TextEditingController();
  final  bloodType = TextEditingController();

  final firstName = TextEditingController(text: 'Default First Name');
  final lastName = TextEditingController(text: 'Default Last Name');
  final email = TextEditingController(text: 'default@example.com');
  final password = TextEditingController(text: 'defaultpassword');
  final confirmPassword = TextEditingController(text: 'defaultpassword');
  final birthdate = TextEditingController(text: '2000-01-01');
  final tel = TextEditingController(text: '0123456789');
  final cardID = TextEditingController(text: '1234567890123');
  final address = TextEditingController(text: '123 Default St, City, Country');




  String? validateFirstName(String? value) {
    if (value == null || value.isEmpty) {
      return 'First name is required';
    }
    return null;
  }

  String? validateLastName(String? value) {
    if (value == null || value.isEmpty) {
      return 'Last name is required';
    }
    return null;
  }

  String? validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'Email is required';
    } else if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(value)) {
      return 'Enter a valid email address';
    }
    return null;
  }

  String? validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Password is required';
    } else if (value.length < 6) {
      return 'Password must be at least 6 characters';
    }
    return null;
  }

  String? validateConfirmPassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Confirm password is required';
    } else if (value != password.text) {
      return 'Passwords do not match';
    }
    return null;
  }

  String? validateBirthdate(String? value) {
    if (value == null || value.isEmpty) {
      return 'Birthdate is required';
    }
    return null;
  }

  String? validateTel(String? value) {
    if (value == null || value.isEmpty) {
      return 'Phone number is required';
    } else if (!RegExp(r'^[0-9]{10}$').hasMatch(value)) {
      return 'Enter a valid 10-digit phone number';
    }
    return null;
  }

  String? validateBloodType(String? value) {
    if (value == null || value.isEmpty) {
      return 'Blood type is required';
    }
    return null;
  }

  String? validateCardID(String? value) {
    if (value == null || value.isEmpty) {
      return 'Card ID is required';
    } else if (!RegExp(r'^[0-9]{13}$').hasMatch(value)) {
      return 'Enter a valid 13-digit card ID';
    }
    return null;
  }

  String? validateAddress(String? value) {
    if (value == null || value.isEmpty) {
      return 'Address is required';
    }
    return null;
  }



  Future<void> register() async {
    isLoading(true);
    errorMessage.value = '';
    Member member = Member(
      memberID: '',
      memberFname: firstName.text,
      memberLname: lastName.text,
      memberEmail: email.text,
      memberPassword: password.text,
      memberBirthDate: DateTime.parse(birthdate.text),
      memberTel: tel.text,
      memberCardID: cardID.text,
      memberAddress: address.text,
      memberBloodType: bloodType.text,
    );

    try {
      await api.insertMember(member.toJson());
    } catch (e) {
      final error = e.toString().replaceFirst('Exception: ', '');
      errorMessage.value = error;
      //errorMessage.value = 'Failed to register';
    }
    isLoading(false);
  }


}