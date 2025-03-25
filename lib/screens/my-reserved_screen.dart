import 'package:flutter/material.dart';
import '../widgets/progress_bar.dart';
import 'package:get/get.dart';
import '../controllers/my_reserved_controller.dart';

class MyReservedScreen extends StatelessWidget {
  final reservedController = Get.put(MyReservedController());

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
                  alignment: Alignment.center,
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
                  Column(
                    children: [
                      SizedBox(height: 16),
                      Text(
                        'บริจาควันที่: 12 มีนาคม 2564',
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      ProgressBar(),

                      SizedBox(height: 16,),
                      Text(
                        'สถานที่: โรงพยาบาลสมเด็จพระเทพ',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 16,),
                      Text(
                        '08.00 - 12.00 น.',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 16,),
                      Text(
                        'รายละเอียด: บริจาคโลหิตเพื่อช่วยเหลือผู้ป่วยโรคเลือด',
                      ),

                      SizedBox(height: 16,),
                      Text(
                        'หมายเหตุ: กรุณามาถึงก่อนเวลาที่กำหนด 15 นาที',
                      ),
                      SizedBox(height: 16,),
                      Text(
                        'หากมีข้อสงสัยกรุณาติดต่อ โทร 1669',
                      ),

                      SizedBox(height: 26,),

                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.redAccent,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(4)),
                            ),
                            child: const Padding(
                              padding: EdgeInsets.all(10.0),
                              child: Text(
                                'ยกเลิกการจอง',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                            onPressed: () {

                            }
                        ),
                      ),

                    ],
                  ),

                ),
              ],
            ),
          )
      );
  }
}

