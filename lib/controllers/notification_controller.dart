import 'package:get/get.dart';
import '../models/my_reserved_model.dart';
import '../services/api_service.dart';
import '../services/authenthication_manager.dart';

class NotificationController extends GetxController {
  ApiService request = ApiService();
  final AuthenticationManager _authManager = Get.put(AuthenticationManager());
  var reservedForNotification = <Reserved>[].obs;

  @override
  void onInit() {
    super.onInit();

    fetchReserved();
  }

  void fetchReserved() async {
    print('=== fetchReserved-func ===');
    final memID = _authManager.member.value.memberID;
    final noti = true;
    await request.getReserved(memID,noti).then((value) {
      if (value.statusCode == 200) {
        reservedForNotification.value = reservedFromJson(value.data);
      }
    }).catchError((onError) {
      printError();
    });
    print(reservedForNotification.length);
    print('=== fetchReserved-func ===');
  }

}
