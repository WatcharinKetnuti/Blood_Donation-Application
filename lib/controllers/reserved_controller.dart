import 'package:get/get.dart';
import '../models/reserved_model.dart';
import '../services/api_service.dart';

class ReservedController extends GetxController {
  var reservedList = <Reserved>[].obs;
  final isLoading = true.obs;
  ApiService request = ApiService();

  @override
  void onInit() {
    super.onInit();

    fetchReserved();
  }

  void fetchReserved() async {
    request.getReserved().then((value) {
      if (value.statusCode == 200) {
        reservedList.value = reservedFromJson(value.data);
        isLoading.value = false;
      } else {
        isLoading.value = true;
      }
    }).catchError((onError) {
      printError();
    });
  }
}
