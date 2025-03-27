import 'package:blood_donation_application/controllers/reserve_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import '../controllers/my_reserved_controller.dart';
import '../controllers/schedule_controller.dart';
import '../models/schedule_model.dart';
import '../services/authenthication_manager.dart';

class ScheduleDetail extends StatelessWidget {
  final Schedule schedule;
  final reserveController = Get.put (ReserveController());
  final myReservedController = Get.put(MyReservedController());
   ScheduleDetail({Key? key, required this.schedule}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(36.0),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '${schedule.locationName}',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Text(
              'วัน: ${schedule.scheduleStartDate} - ${schedule.scheduleEndDate}',
              style: TextStyle(fontSize: 18),
            ),
            Text(
              'เวลา: ${schedule.scheduleStartTime} - ${schedule.scheduleEndTime}',
              style: TextStyle(fontSize: 18),
            ),
            Text(
              'รับ: ${schedule.scheduleMax} คน',
              style: TextStyle(fontSize: 18),
            ),
            Text(
              'หมู่เลือด: ${schedule.scheduleBloodType == '' ? 'ไม่ระบุ' : schedule.scheduleBloodType}',
              style: TextStyle(fontSize: 18),
            ),
            SizedBox(height: 10),
            Text(
              'รายละเอียด:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: 200,
              child: Text(
                "\t\t ${schedule.scheduleDetail}",
                style: TextStyle(fontSize: 16),
              ),
            ),

            SizedBox(height: 10),

              Form(
                key: reserveController.formKey,
                child: TextFormField(
                  controller: reserveController.donationDate,
                  validator: reserveController.validateDonationdate,
                  decoration: const InputDecoration(
                    hintText: 'เลือกวันที่',
                    prefixIcon: Icon(Icons.calendar_today_outlined),
                    border: OutlineInputBorder(),
                  ),
                  readOnly: true,
                  onTap: () async {
                    DateTime? pickedDate = await showDatePicker(
                      context: context,
                      firstDate: DateTime.parse(schedule.scheduleStartDate),
                      lastDate: DateTime.parse(schedule.scheduleEndDate),
                    );
                    if (pickedDate != null) {
                      reserveController.donationDate.text = pickedDate.toString().split(' ')[0];
                    }
                  },
                ),
              ),


            SizedBox(height: 10),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  if (reserveController.formKey.currentState!.validate()) {
                    reserveController.scheduleId = schedule.scheduleId;
                    reserveController.reserve().then((_) {
                     myReservedController.fetchReserved();
                     Navigator.of(context).pop();
                    });
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.redAccent,
                  padding: EdgeInsets.symmetric(vertical: 16.0),
                ),
                child: Text(
                  'จอง',
                  style: TextStyle(fontSize: 18, color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}