import 'package:dio/dio.dart';

class Schedule_api {
  var dio = Dio();

  Future<dynamic> getSchedule() async {
    try {
      return await dio.get(
          'http://localhost/Blood_Donation-Web/services/schedule_list.php');
    }
    catch (e) {
      print(e);
    }
  }
}