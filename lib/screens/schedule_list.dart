import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../models/schedule.dart';
import 'package:intl/intl.dart';

class ScheduleListScreen extends StatefulWidget {
  const ScheduleListScreen({super.key});

  @override
  State<ScheduleListScreen> createState() => _ScheduleListScreenState();
}

class _ScheduleListScreenState extends State<ScheduleListScreen> {
  List<ScheduleList> schedules = [];
  bool isLoading = true;
  String errorMessage = '';


  @override
  void initState() {
    super.initState();
    get_API();
  }

  Future get_API() async {
    var url = 'http://10.5.50.85/Blood_Donation-Web/api/schedule_list.php';
    var response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      List jsonResponse = json.decode(response.body);
      setState(() {
        schedules =
            jsonResponse.map((data) => ScheduleList.fromJson(data)).toList();
        isLoading = false;
      });
    } else {
      setState(() {
        errorMessage = 'Failed to load schedules: ${response.statusCode}';
        isLoading = true;
      });
    }
  }

  String formatDate(String date) {
    final parsedDate = DateTime.parse(date);
    return DateFormat('dd/MM/yyyy').format(parsedDate);
  }

  String formatTime(String time) {
    final parsedTime = DateTime.parse('0000-00-00T$time');
    return DateFormat('HH:mm').format(parsedTime);
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: Colors.redAccent,
      appBar: AppBar(
        backgroundColor: Colors.redAccent,
        //title: Text("List View Page"),
      ),
      body: isLoading ? Center(child: CircularProgressIndicator()) : Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              'กำหนดการสามารถจองได้',
              style: TextStyle(
                fontSize: 25.0,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: schedules.length,
              itemBuilder: (context, index) {
                return Container(
                  margin: EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(28.0),
                  ),
                  child: ListTile(
                    contentPadding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 16.0),
                    leading: Icon(
                      Icons.calendar_today_outlined,
                      color: Colors.black54,
                      size: 30.0,
                    ),
                    title: Text(
                      "${schedules[index].locationName}",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 22.0,
                        color: Colors.black87,
                      ),
                    ),
                    subtitle: Text(
                      " ${formatDate(schedules[index].scheduleStartDate)} - ${formatDate(schedules[index].scheduleEndDate)} \n"
                      " ${formatTime(schedules[index].scheduleStartTime)} - ${formatTime(schedules[index].scheduleEndTime)} \n",
                      style: TextStyle(
                        fontSize: 18.0,
                        color: Colors.black54,
                      ),
                    ),
                    trailing: Text(
                      "จำนวนที่รับ: ${schedules[index].scheduleMax} คน\n"
                      "หมู่เลือด: ${schedules[index].scheduleBloodType} \n",
                      style: TextStyle(
                        fontSize: 16.0,
                        color: Colors.black54,
                      ),
                      textAlign: TextAlign.right,
                    ),
                    onTap: () {
                      //Navigator.pushNamed(context, '/detail');
                    },
                  ),
                );
              }
            ),
          ),
        ],
      ),
    );
  }

}
