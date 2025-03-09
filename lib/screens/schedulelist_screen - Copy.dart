import 'package:blood_donation_application/controllers/schedule_controller.dart';
import 'package:blood_donation_application/models/location_model.dart';
import 'package:blood_donation_application/models/schedule_model.dart';
import 'package:blood_donation_application/screens/scheduledetail_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'dart:convert';
import 'package:intl/intl.dart';
import '../widgets/list_card.dart';

class ScheduleListScreen extends StatelessWidget {
  final scheduleController = Get.put(ScheduleController());

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
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(18.0),
            child: Column(
              children: [
                Text(
                  'กำหนดการบริจาคโลหิต',
                  style: TextStyle(
                    fontSize: 25.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                Row(
                  children: [
                    Expanded(
                      child:Container(
                      color: Colors.white,
                      child: TextFormField(
                        //controller: registerController.birthdate,
                        decoration: const InputDecoration(
                          hintText: 'วันบริจาค',
                          prefixIcon: Icon(Icons.calendar_today_outlined),
                          border: OutlineInputBorder(),
                        ),
                        readOnly: true,
                        onTap: () async {
                          DateTime? pickedDate = await showDatePicker(
                            context: context,
                            initialDate: DateTime.now(),
                            firstDate: DateTime(1900),
                            lastDate: DateTime(2100),
                          );
                          if (pickedDate != null) {
                            //registerController.birthdate.text =
                             //   pickedDate.toString().split(' ')[0];
                          }
                        },
                      ),
                    ),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Expanded(child:
                    Container(
                      color: Colors.white,
                      child:
                      DropdownButtonFormField<String>(
                        value:  scheduleController.locationList.isNotEmpty ? scheduleController.locationList.first.locationName : null,
                        items: scheduleController.locationList.map((Location value) {
                          return DropdownMenuItem<String>(
                            value: value.locationName,
                            child: Text(value.locationName),
                          );
                        }).toList(),
                        decoration: const InputDecoration(
                          hintText: 'กรุ๊ปเลือดของคุณ',
                          border: OutlineInputBorder(),
                        ),
                        onChanged: (String? newValue) {
                          scheduleController.location.text = newValue!;
                        },
                      ),
                    ),
                    )
                  ],
                ),
              ],
            ),
          ),
          GetX<ScheduleController>(builder: (controller) {
            if (controller.isLoading.value) {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
            return ListView.builder(
                shrinkWrap: true,
                itemCount: controller.scheduleList.length,
                itemBuilder: (context, index) {
                  return Container(
                    margin:
                        EdgeInsets.symmetric(vertical: 9.0, horizontal: 16.0),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(1),
                      borderRadius: BorderRadius.circular(15.0),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black54.withOpacity(0.4),
                          spreadRadius: 2,
                          blurRadius: 5,
                        )
                      ],
                    ),
                    child: ListTile(
                        contentPadding: EdgeInsets.symmetric(
                            vertical: 5.0, horizontal: 16.0),
                        leading: Icon(
                          Icons.calendar_today_outlined,
                          color: Colors.black54,
                          size: 30.0,
                        ),
                        title: Text(
                          "${controller.scheduleList[index].locationName}",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 22.0,
                            color: Colors.black87,
                          ),
                        ),
                        subtitle: Text(
                          " ${formatDate(controller.scheduleList[index].scheduleStartDate)} - ${formatDate(controller.scheduleList[index].scheduleEndDate)} \n"
                          " ${formatTime(controller.scheduleList[index].scheduleStartTime)} - ${formatTime(controller.scheduleList[index].scheduleEndTime)} \n",
                          style: TextStyle(
                            fontSize: 18.0,
                            color: Colors.black54,
                          ),
                        ),
                        trailing: Text(
                          "จำนวนที่รับ: ${controller.scheduleList[index].scheduleMax} คน\n"
                          "หมู่เลือด: ${controller.scheduleList[index].scheduleBloodType} \n",
                          style: TextStyle(
                            fontSize: 16.0,
                            color: Colors.black54,
                          ),
                          textAlign: TextAlign.right,
                        ),
                        onTap: () {
                          // Navigator.push(
                          //     context,
                          //     CupertinoPageRoute(builder: (context) => const SecondRoute())
                          // );
                          showModalBottomSheet(
                            constraints: BoxConstraints(
                              maxHeight:
                                  MediaQuery.of(context).size.height * 0.8,
                            ),
                            context: context,
                            builder: (context) => ScheduleDetail(
                              schedule: controller.scheduleList[index],
                            ),
                          );
                        }),
                  );
                });
          }),
        ],
      ),
    );
  }
}
