import 'package:get/get.dart';

import '../models/schedule_model.dart';
import 'api_service.dart';

class ScheduleController extends GetxController {
  var scheduleList = <Schedule>[].obs;
  final isLoading = true.obs;
  ApiService request = ApiService();

  void fetchSchedules() async {
    request.getSchedule().then((value) {
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
}