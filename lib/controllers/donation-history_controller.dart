import 'package:blood_donation_application/controllers/login_controller.dart';
import 'package:get/get.dart';
import 'package:dio/dio.dart';
import '../models/donation_history_model.dart';
import '../services/api_service.dart';
import '../services/authenthication_manager.dart';

class DonationHistoryController extends GetxController {
  final ApiService api = ApiService();
  final AuthenticationManager _authManager = Get.put(AuthenticationManager());
  
  var isLoading = false.obs;
  var donationList = <DonationHistory>[].obs;
  var donationCount = 0.obs;

  @override
  void onInit() {
    fetchDonationHistory();
    super.onInit();
  }

  void fetchDonationHistory() async {
    isLoading.value = true;
      //final response = await api.getDonationHistory(_authManager.member.value.memberID);
      await  api.getDonationHistory(_authManager.member.value.memberID).then((value) {
        if (value.statusCode == 200) {
          donationList.value = donationHistoryFromJson(value.data);
          donationCount.value = donationList.length;
          isLoading.value = false;
        } else {
          isLoading.value = true;
        }
        print('History: ${donationList.length}');
      }).catchError((onError){
        print('HistoryError: $onError');
        printError();
      });
  }
}