import 'package:arc_progress_bar_new/arc_progress_bar_new.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';


class ProgressBar extends StatelessWidget {
  var progressPercentage = 0.0;

  @override
  Widget build(BuildContext context) {
    return
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ArcProgressBar(
            percentage: progressPercentage,
            arcThickness: 15,
            innerPadding: 48,
            strokeCap: StrokeCap.round,
            handleSize: 0,
            foregroundColor: Colors.redAccent,
            backgroundColor: Colors.red.shade100,
            bottomCenterWidget: Column(
              children: [
                Text('${progressPercentage}'),
                const Text("Day"),
                const Text("Left"),
              ],
            ),
          ),
        ],
      );
  }
}
