import 'package:get/get.dart';
import '../models/location_model.dart';
import '../models/schedule_model.dart';
import '../services/api_service.dart';
import 'package:flutter/material.dart';

class ScheduleController extends GetxController {
  ApiService request = ApiService();

  var scheduleList = <Schedule>[].obs;
  var locationList = <Location>[].obs;
  final isLoading = true.obs;
  final location = TextEditingController();
  final date = TextEditingController();
  var blood = false.obs;


  @override
  void onInit() {
    super.onInit();

    fetchSchedules(location.text, date.text, blood.value);
    fetchLocations();
    print('locationlist');
  }

  void blood_valuechange(){
    blood.value = !blood.value;
    print(blood.value);
  }

  void refresh() {
    fetchSchedules(location.text, date.text, blood.value);
  }


  void fetchSchedules(location, date, blood) async {
    print('=== login_controoler fetchSchedules-func ===');
    print('fetch ${location}');
    await request.getSchedule(location, date, blood).then((value) {
      if (value.statusCode == 200){
        scheduleList.value = scheduleListFromJson(value.data);
        isLoading.value = false;
      }else{
        isLoading.value = true;
      }
    }).catchError((onError){
      printError();
    });
  }


  void fetchLocations() async {
    await request.getLocation().then((value) {
      if (value.statusCode == 200){
        locationList.value = locationFromJson(value.data);
        print(locationList.length);
        isLoading.value = false;
      }else{
        isLoading.value = true;
      }
    }).catchError((onError){
      printError();
    });

  }

  // void Filter() async {
  //   print('=== login_controoler Filter-func ===');
  //
  //
  //   var response = await apiService.login(email.text, password.text);
  //   isResponseReceived = true;
  //   print(response);
  //
  //   if (response != null) {
  //     box.write('member', response['0']);
  //     Get.snackbar('Success', 'Login successful');
  //     _authManager.login(response['token']);
  //     Get.offAll(() => AuthenScreen());
  //   } else {
  //     errorMessage.value = 'อีเมล หรือ รหัสผ่านไม่ถูกต้อง';
  //   }
  //   isLoading.value = false;
  // }
}