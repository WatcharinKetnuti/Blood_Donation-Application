import 'dart:convert';
import 'package:get/get.dart';
import 'authenthication_manager.dart';
import 'package:dio/dio.dart'as DIO;

class ApiService {
  // 10.0.2.2 android localhost

  final AuthenticationManager _authManager = Get.put(AuthenticationManager());
  final dio = DIO.Dio(DIO.BaseOptions(
    baseUrl: 'http://10.0.2.2/Blood_Donation-Web/',
  ));

  Future<Map<String, dynamic>?> login(String email, String password) async {
    print(' = api_service func login =');
    DIO.Response response = await dio.post("/api/login.php", data: {
      'member_email': email,
      'member_password': password,
    });

    if (response.statusCode == 200) {
      var result = json.decode(response.data);
      print(result);

      if(result['success'] == false) {
        return null;
      }else{
        print(result['0']['member_id']);
        return result;
      }
    }
    print(' = api_service func login =');
  }

  Future<dynamic> getReserved(String mem_ID, bool noti) async {
    print(' = api_service func getReserved =');
    try {
       var url = 'http://localhost/Blood_Donation-Web/api/reserved_list.php?member_id=$mem_ID&?noti=$noti';
       print(url);
      return await dio.get('/api/reserved_list.php?member_id=$mem_ID&?noti=$noti');
    }
    catch (e) {
      print(e);
    }
  }


  Future<dynamic> getSchedule(String location,String date,bool blood) async {
    _authManager.getMember();
    final blood_value = blood? _authManager.member.value.memberBloodType:'';
    print('blood: $blood_value');

    var url = 'http://localhost/Blood_Donation-Web/api/schedule_list.php?location=$location&date=$date&blood=$blood_value';
    print(url);
    try {
      return await dio.get('/api/schedule_list.php?location=$location&date=$date&blood=$blood_value');
    }
    catch (e) {
      print(e);
    }
  }

  Future<dynamic> getLocation() async {
    try {
      return await dio.get('/api/location_list.php');
    }
    catch (e) {
      print(e);
    }
  }

  Future<void> insertMember(Map<String, dynamic> data) async {
    try {
      DIO.Response response = await dio.post("/api/insert_member.php", data: data);
      print("Response data: ${response.data}");

      if (response.statusCode == 200) {
        var responseData = json.decode(response.data);
        if (responseData["success"] == false) {
          print("Failed to insert data: ${responseData}");
          print(responseData['message']);
          throw Exception(responseData['message']);
        } else {
          print("Data inserted successfully: ${responseData}");
        }
      } else {
        print("Server error: ${response.statusMessage}");
        throw Exception(response.statusMessage);
      }
    } catch (e) {
      print("Error: $e");
      throw e;
    }
  }

  Future<void> insertReserve(Map<String, dynamic> data) async {
    try {
      DIO.Response response = await dio.post("/api/insert_reserve.php", data: data);
      print("Response data: ${response.data}");

      if (response.statusCode == 200) {
        var responseData = json.decode(response.data);
        if (responseData["success"] == false) {
          print("Failed to insert data: ${responseData}");
          print(responseData['message']);
          throw Exception(responseData['message']);
        } else {
          print("Data inserted successfully: ${responseData}");
        }
      } else {
        print("Server error: ${response.statusMessage}");
        throw Exception(response.statusMessage);
      }
    } catch (e) {
      print("Error: $e");
      throw e;
    }
  }


  Future<dynamic> cancelReserved(String resID) async {

      DIO.Response response = await dio.post("/api/cancel_reserve.php", data: {
        'reserve_id': resID,
      });

      if (response.statusCode == 200) {
        var result = json.decode(response.data);
        print(result);

        return result;
      }

  }


}
