import 'package:arc_progress_bar_new/arc_progress_bar_new.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';


class ProgressBar extends StatelessWidget {
  var progressPercentage = 0.0.obs;

  final donationdate;

  ProgressBar({super.key, required this.donationdate,});

  @override
  Widget build(BuildContext context) {
    return
      Obx(() {
        final DateNow = DateTime.now();
        final DateDonation = DateTime.parse(donationdate);
        final difference = 1+DateDonation.difference(DateNow).inDays;

        progressPercentage.value = (difference == 0) ? 100 : (difference / 60) * 100;
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
              Text('${difference}วัน'),
            ],
          ),
        );
      });
  }
}
