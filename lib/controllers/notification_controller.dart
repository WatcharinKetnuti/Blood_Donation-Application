import 'package:get/get.dart';
import '../models/my_reserved_model.dart';
import '../models/schedule_model.dart';
import '../services/api_service.dart';
import '../services/authenthication_manager.dart';

class NotificationController extends GetxController {
  ApiService request = ApiService();
  final AuthenticationManager _authManager = Get.put(AuthenticationManager());
  var reservedForNotification = <Reserved>[].obs;
  var scheduleListForNotification = <Schedule>[].obs;

  @override
  void onInit() {
    super.onInit();
  }

  void fetchReserved() async {
    print('=== fetchReserved-func ===');
    final memID = _authManager.member.value.memberID;
    await request.getReserved(memID,true).then((value) {
      if (value.statusCode == 200) {
        reservedForNotification.value = reservedFromJson(value.data);
        print('Noti reserve: ${reservedForNotification.length}');
      }
    }).catchError((onError) {
      printError();
    });
  }

  void fetchSchedules(location, date, blood) async {
    print('=== fetchSchedules-func ===');
    print('fetch ${location}');
    await request.getSchedule(location, date, blood).then((value) {
      if (value.statusCode == 200){
        scheduleListForNotification.value = scheduleListFromJson(value.data);
      }
    }).catchError((onError){
      printError();
    });
  }

}
