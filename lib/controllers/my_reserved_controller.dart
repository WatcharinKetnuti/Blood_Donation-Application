import 'package:get/get.dart';
import '../models/my_reserved_model.dart';
import '../services/api_service.dart';
import '../services/authenthication_manager.dart';

class MyReservedController extends GetxController {
  ApiService request = ApiService();
  final AuthenticationManager _authManager = Get.put(AuthenticationManager());
  var reservedList = <Reserved>[].obs;
  final isLoading = true.obs;


  @override
  void onInit() {
    super.onInit();

    fetchReserved();
  }

  void fetchReserved() async {
    print('=== fetchReserved-func ===');
    final memID = _authManager.member.value.memberID;
      await request.getReserved(memID).then((value) {
        if (value.statusCode == 200) {
          reservedList.value = reservedFromJson(value.data);
          isLoading.value = false;
        } else {
          isLoading.value = true;
        }
    }).catchError((onError) {
      printError();
    });
      print(reservedList.length);
     print('=== fetchReserved-func ===');
  }

  void cancelReserved(String resID) async {
    print('=== cancelReserved-func ===');
    var response =  await request.cancelReserved(resID);
    isLoading.value = true;

    if(response != null) {
      Get.snackbar('การยกเลิกจอง', response['message']);
      fetchReserved();
    }

    print('=== cancelReserved-func ===');

  }
}
