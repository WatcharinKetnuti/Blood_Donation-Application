import 'dart:convert';
import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';

class ApiService {
  final dio = Dio() = Dio(BaseOptions(
    baseUrl: 'http://localhost/Blood_Donation-Web/',
  ));

  Future<dynamic> getSchedule() async {
    try {
      return await dio.get('/api/schedule_list.php');
    }
    catch (e) {
      print(e);
    }
  }

  Future<void> insertMember(Map<String, dynamic> data) async {

      Response response = await dio.post("/api/insert_member.php", data: data);
      print("Response data: ${response.data}");
      var responseData = json.decode(response.data);
      print("Response data: ${responseData}");

      if (response.statusCode == 200) {
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

  }
}
