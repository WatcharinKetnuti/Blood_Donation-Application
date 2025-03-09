import 'package:get/get.dart';
import '../models/location_model.dart';
import '../models/schedule_model.dart';
import '../services/api_service.dart';
import 'package:flutter/material.dart';

class ScheduleController extends GetxController {
  var scheduleList = <Schedule>[].obs;
  var locationList = <Location>[].obs;
  final isLoading = true.obs;
  var blood = false.obs;

  ApiService request = ApiService();

  final  location = TextEditingController();

  @override
  void onInit() {
    super.onInit();

    fetchSchedules();
    fetchLocations();
    print('locationlist');
  }

  void blood_valuechange(){
    blood.value = !blood.value;
    print(blood.value);
  }


  void fetchSchedules() async {
    await request.getSchedule().then((value) {
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
}