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
              'Location: ${schedule.locationName}',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Text(
              'Date: ${schedule.scheduleStartDate} - ${schedule.scheduleEndDate}',
              style: TextStyle(fontSize: 18),
            ),
            Text(
              'Start Time: ${schedule.scheduleStartTime} - ${schedule.scheduleEndTime}',
              style: TextStyle(fontSize: 18),
            ),
            Text(
              'Max Participants: ${schedule.scheduleMax}',
              style: TextStyle(fontSize: 18),
            ),
            Text(
              'Blood Type: ${schedule.scheduleBloodType}',
              style: TextStyle(fontSize: 18),
            ),
            SizedBox(height: 10),
            Text(
              'Detail:',
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
                  'Reserve',
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