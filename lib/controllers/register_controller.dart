import 'package:get/get.dart';

class RegisterController extends GetxController {
  var firstName = ''.obs;
  var lastName = ''.obs;
  var email = ''.obs;
  var password = ''.obs;
  var confirmPassword = ''.obs;
  var birthdate = ''.obs;
  var tel = ''.obs;
  var bloodType = ''.obs;
  var isLoading = false.obs;

  void register() async {
    isLoading.value = true;
    // Add your registration logic here
    await Future.delayed(Duration(seconds: 2)); // Simulate a network call
    isLoading.value = false;
    // Navigate to the next screen if registration is successful
    // Get.toNamed('/home');
  }
}