import 'package:flutter/material.dart';
import '../widgets/progress_bar.dart';
import 'package:get/get.dart';
import '../controllers/reserved_controller.dart';

class ReservedScreen extends StatelessWidget {
  final reservedController = Get.put(ReservedController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.redAccent,
        body:Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.all(18.0),
                  child: Text(
                    'กำหนดการบริจาคโลหิต',
                    style: TextStyle(
                      fontSize: 25.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
                Container(
                  width: MediaQuery.of(context).size.width * 0.8,
                  padding: EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black12,
                        blurRadius: 10,
                        spreadRadius: 5,
                      ),
                    ],
                  ),
                  child:
                    ProgressBar(),
                ),
              ],
            ),
          )
      );
  }
}

