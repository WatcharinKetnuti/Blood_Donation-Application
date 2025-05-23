import 'package:blood_donation_application/controllers/schedule_controller.dart';
import 'package:blood_donation_application/models/location_model.dart';
import 'package:blood_donation_application/screens/scheduledetail_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import '../controllers/reserve_controller.dart';
import 'package:dropdown_search/dropdown_search.dart'; 

class ScheduleListScreen extends StatelessWidget {
  final scheduleController = Get.put(ScheduleController());
  final reserveController = Get.put(ReserveController());
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
        title: Text(
          'กำหนดการที่เปิดจอง',
          style: TextStyle(
            fontSize: 25.0,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        actions: [
          IconButton(
            icon: Icon(
                CupertinoIcons.bin_xmark_fill), // Icon on the top-right corner
            onPressed: () {
              scheduleController.location.text = '';
              scheduleController.blood.value = false;
              scheduleController.date.text = '';
              scheduleController.fetchLocations();
              scheduleController.fetchSchedules(
                  scheduleController.location.text,
                  scheduleController.date.text,
                  scheduleController.blood.value
              );
            },
          ),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: Column(
              children: [
                Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10.0),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black54.withOpacity(0.4),
                        spreadRadius: 1,
                        blurRadius: 5,
                        offset: Offset(0, 3),
                      )
                    ],
                  ),
                  padding: EdgeInsets.all(15.0),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: TextFormField(
                              controller: scheduleController.date,
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
                                  firstDate: DateTime.now(),
                                  lastDate: DateTime(2100),
                                );
                                if (pickedDate != null) {
                                  // Format the selected date as "dd MM yy"
                                  String formattedDate =
                                      DateFormat('dd-MM-yyyy')
                                          .format(pickedDate);
                                  scheduleController.date.text =
                                      formattedDate; // Update text field
                                  scheduleController.fetchSchedules(
                                      scheduleController.location.text,
                                      scheduleController.date.text,
                                      scheduleController.blood.value
                                  );
                                }
                              },
                            ),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Text('หมู่เลือดของคุณ: '),
                          Obx(() {
                            return Checkbox(
                                value: scheduleController.blood.value,
                                onChanged: (bool? value) {
                                  scheduleController.blood_valuechange();
                                  scheduleController.fetchSchedules(
                                      scheduleController.location.text,
                                      scheduleController.date.text,
                                      scheduleController.blood.value
                                  );
                                });
                          }),
                        ],
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Row(
                        children: [
                          Obx(() {
                              if (scheduleController.isLoading.value) {
                                return Center(child: CircularProgressIndicator());
                              }
                              return Expanded(
                                child: DropdownSearch<String>(
                                  popupProps: PopupProps.menu(
                                    showSearchBox: true,
                                    searchFieldProps: TextFieldProps(
                                      decoration: InputDecoration(
                                        hintText: "ค้นหาสถานที่",
                                        border: OutlineInputBorder(),
                                        contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                                      ),
                                    ),
                                    menuProps: MenuProps(
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                  ),
                                  items: scheduleController.locationList
                                      .map((Location location) => location.locationName)
                                      .toList(),
                                  dropdownDecoratorProps: DropDownDecoratorProps(
                                    dropdownSearchDecoration: InputDecoration(
                                      hintText: 'สถานที่',
                                      prefixIcon: Icon(Icons.location_on_outlined),
                                      border: OutlineInputBorder(),
                                    ),
                                  ),
                                  onChanged: (String? newValue) {
                                    if (newValue != null) {
                                      scheduleController.location.text = newValue;
                                      scheduleController.fetchSchedules(
                                          scheduleController.location.text,
                                          scheduleController.date.text,
                                          scheduleController.blood.value);
                                    }
                                  },
                                ),
                              );
                            }),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Obx(() {
            if (scheduleController.isLoading.value) {
              return Center(child: CircularProgressIndicator());
            } else if (scheduleController.scheduleList.isEmpty) {
              return Center(
                  child: Text('ไม่พบข้อมูล',
                      style: TextStyle(fontSize: 20.0, color: Colors.white)));
            } else {
              return SingleChildScrollView(
                child: Container(
                  height: MediaQuery.of(context).size.height * 0.5,
                  child: ListView.builder(
                      shrinkWrap: true,
                      itemCount: scheduleController.scheduleList.length,
                      itemBuilder: (context, index) {
                        return Container(
                          margin: EdgeInsets.symmetric(
                              vertical: 9.0, horizontal: 16.0),
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(1),
                            borderRadius: BorderRadius.circular(15.0),
                          ),
                          child: ListTile(
                              contentPadding: EdgeInsets.symmetric(
                                  vertical: 5.0, horizontal: 16.0),
                              title: Text(
                                "${scheduleController.scheduleList[index].locationName}",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20.0,
                                  color: Colors.black87,
                                ),
                              ),
                              subtitle: Text(
                                " ${formatDate(scheduleController.scheduleList[index].scheduleStartDate)} - ${formatDate(scheduleController.scheduleList[index].scheduleEndDate)} \n"
                                " ${formatTime(scheduleController.scheduleList[index].scheduleStartTime)} - ${formatTime(scheduleController.scheduleList[index].scheduleEndTime)} \n",
                                style: TextStyle(
                                  fontSize: 16.0,
                                  color: Colors.black54,
                                ),
                              ),
                              trailing: Text(
                                "หมู่เลือด: ${scheduleController.scheduleList[index].scheduleBloodType == "" ? "ไม่ระบุ" : scheduleController.scheduleList[index].scheduleBloodType} \n",
                                style: TextStyle(
                                  fontSize: 16.0,
                                  color: Colors.black54,
                                ),
                                textAlign: TextAlign.right,
                              ),
                              onTap: () {
                                showModalBottomSheet(
                                  constraints: BoxConstraints(
                                    maxHeight:
                                        MediaQuery.of(context).size.height *
                                            0.8,
                                  ),
                                  context: context,
                                  builder: (context) => ScheduleDetail(
                                    schedule:
                                        scheduleController.scheduleList[index],
                                  ),
                                ).whenComplete(() {
                                  reserveController.donationDate.text = '';
                                });
                              }),
                        );
                      }),
                ),
              );
            }
          }),
        ],
      ),
    );
  }
}
