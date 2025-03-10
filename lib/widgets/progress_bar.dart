import 'package:arc_progress_bar_new/arc_progress_bar_new.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';


class ProgressBar extends StatelessWidget {
  var progressPercentage = 10.0.obs;

  @override
  Widget build(BuildContext context) {
    return
      Obx(() {
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
              const Text("อีก"),
              Text('${progressPercentage.value}วัน'),
              const Text(""),
            ],
          ),
        );
      });
  }
}
