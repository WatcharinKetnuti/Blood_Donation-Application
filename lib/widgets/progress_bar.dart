import 'package:arc_progress_bar_new/arc_progress_bar_new.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';


class ProgressBar extends StatelessWidget {
  var progressPercentage = 0.0.obs;

  final donationdate;

  ProgressBar({super.key, required this.donationdate,});

  @override
  Widget build(BuildContext context) {
    return
      Obx(() {
        final DateFormat formatter = DateFormat('yyyy-MM-dd');
        final DateTime DateNow = formatter.parse(DateTime.now().toString());
        final DateTime DateDonation = formatter.parse(donationdate);
        final int difference = DateDonation.difference(DateNow).inDays;

        if (difference <= 0) {
          progressPercentage.value = 100.0;
        } else {
          progressPercentage.value = (1 - (difference / 60)) * 100;
          progressPercentage.value = progressPercentage.value.clamp(0.0, 100.0);
        }
        return ArcProgressBar(
          percentage: progressPercentage.value,
          arcThickness: 25,
          innerPadding: 60,
          strokeCap: StrokeCap.round,
          handleSize: 0,
          foregroundColor: Colors.redAccent,
          backgroundColor: Colors.red.shade100,
          bottomCenterWidget: Column(
            children: [
              const Text(
                  "อีก"
              ),
              Text('${difference} วัน'),
            ],
          ),
        );
      });
  }
}
