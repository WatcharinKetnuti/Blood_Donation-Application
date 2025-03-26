import 'package:blood_donation_application/services/cache_manager.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../models/reserve_model.dart';
import '../services/api_service.dart';
import '../services/authenthication_manager.dart';

class ReserveController extends GetxController {
  Dio dio = Dio();
  final ApiService api = ApiService();
  final AuthenticationManager _authManager = Get.put(AuthenticationManager());
  var isLoading = false.obs;
  var errorMessage = ''.obs;

  final formKey = GlobalKey<FormState>();
  final donationDate = TextEditingController();
  late String scheduleId;



  String? validateDonationdate(String? value) {
    if (value == null || value.isEmpty) {
      return 'Donationdate is required';
    }
    return null;
  }


  Future<void> reserve() async {
    isLoading(true);
    errorMessage.value = '';
    Reserve reserve = Reserve(
        memberId: _authManager.member.value.memberID,
        scheduleId: scheduleId,
        reserveDonationDate: DateTime.parse(donationDate.text),
    );
    try {
      await api.insertReserve(reserve.toJson());
    } catch (e) {
      final error = e.toString().replaceFirst('Exception: ', '');
      //errorMessage.value = error;
      Get.snackbar(
        backgroundColor: Color.fromRGBO(255, 255, 255, 0.5),
          'ไม่สามารถจองได้', error
      );
    }
    isLoading(false);
  }


}