import 'package:flutter/material.dart';
import '../models/schedule_model.dart';

class ScheduleDetail extends StatelessWidget {
  final Schedule schedule;

  const ScheduleDetail({Key? key, required this.schedule}) : super(key: key);

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
            // TextField(
            //   controller: _dateController,
            //   readOnly: true,
            //   decoration: InputDecoration(
            //     labelText: 'Select Date',
            //     suffixIcon: IconButton(
            //       icon: Icon(Icons.calendar_today),
            //       onPressed: () => _selectDate(context),
            //     ),
            //   ),
            // ),
            SizedBox(height: 10),

            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  // Add your reserve logic here
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