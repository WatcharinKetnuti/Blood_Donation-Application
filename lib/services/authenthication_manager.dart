import 'package:get/get.dart';
import '../models/member_model.dart';
import '../services/cache_manager.dart';

class AuthenticationManager extends GetxController with CacheManager {
  final isLogged = false.obs;
  var member = Member(
    memberID: '',
    memberFname: '',
    memberLname: '',
    memberBirthDate: DateTime.now(),
    memberTel: '',
    memberCardID: '',
    memberAddress: '',
    memberBloodType: '',
    memberEmail: '',
    memberPassword: '',
  ).obs;

  void logOut() {
    isLogged.value = false;
    removeToken();
    member.value = Member(
      memberID: '',
      memberFname: '',
      memberLname: '',
      memberBirthDate: DateTime.now(),
      memberTel: '',
      memberCardID: '',
      memberAddress: '',
      memberBloodType: '',
      memberEmail: '',
      memberPassword: '',
    );
  }

  void login(String? token) async {
    isLogged.value = true;
    //Token is cached
    await saveToken(token);
    print('=== AuthenticationManager ===');
    print('token ${getToken()}');
  }

  void checkLoginStatus() {
    final token = getToken();
    if (token != null) {
      isLogged.value = true;
    }
  }

  void getMember(){
    member.value = Member.fromJson(box.read('member'));
    print('=== AuthenticationManager ===');
    print('member ${member.value.memberFname}');
  }




}