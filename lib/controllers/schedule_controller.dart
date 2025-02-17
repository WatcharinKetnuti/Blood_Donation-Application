import 'package:get/get.dart';

import '../models/schedule_model.dart';
import '../services/schedule_api.dart';

class ScheduleController extends GetxController {
  var scheduleList = <Schedule>[].obs;
  final isLoading = true.obs;

  void fetchSchedules() async {
    Schedule_api request = Schedule_api();
    request.getSchedule().then((value) {
      if (value.statusCode == 200){
        scheduleList.value = scheduleListFromJson(value.data);
        isLoading.value = false;
      }else{
        isLoading.value = true;
        print('error');
      }
    }).catchError((onError){
      printError();
    });

  }
}