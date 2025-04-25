import 'package:get/get.dart';
import '../models/location_model.dart';
import '../models/schedule_model.dart';
import '../services/api_service.dart';
import 'package:flutter/material.dart';

class ScheduleController extends GetxController {
  ApiService request = ApiService();

  var scheduleList = <Schedule>[].obs;
  var locationList = <Location>[].obs;
  var blood = false.obs;
  final isLoading = true.obs;
  final location = TextEditingController();
  final date = TextEditingController();


  @override
  void onInit() {
    super.onInit();
    refresh();
  }

  void blood_valuechange(){
    blood.value = !blood.value;
    print(blood.value);
  }

  void refresh(){
    fetchSchedules(location.text, date.text, blood.value);
    fetchLocations();
  }


  void fetchSchedules(location, date, blood) async {
    print('=== fetchSchedules-func ===');

    //print('filter: ${location, date, blood}');

    await request.getSchedule(location, date, blood).then((value) {
      if (value.statusCode == 200){
        scheduleList.value = scheduleListFromJson(value.data);
        isLoading.value = false;
      }else{
        isLoading.value = true;
      }
      print('value: ${value.data}');
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