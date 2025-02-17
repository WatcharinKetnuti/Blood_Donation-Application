import 'package:get/get.dart';

class LoginController extends GetxController {
  var email = ''.obs;
  var password = ''.obs;
  var isLoading = false.obs;

  void login() async {
    isLoading.value = true;
    // Add your login logic here
    await Future.delayed(Duration(seconds: 2)); // Simulate a network call
    isLoading.value = false;
    // Navigate to the next screen if login is successful
    // Get.toNamed('/home');
  }
}