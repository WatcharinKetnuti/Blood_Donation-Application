import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../controllers/my_reserved_controller.dart';
import '../widgets/progress_bar.dart';
import 'package:get/get.dart';


class MyReservedScreen extends StatelessWidget {
  final myReservedController = Get.put(MyReservedController());


  String formatDate(String date) {
    final parsedDate = DateTime.parse(date);
    return DateFormat('dd/MM/yyyy').format(parsedDate);
  }

    @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.redAccent,
      body: RefreshIndicator(
        onRefresh: () async {
          myReservedController.fetchReserved();
          return Future.value();
        },
        color: Colors.redAccent,
        backgroundColor: Colors.white,
        child: SingleChildScrollView(
          physics: AlwaysScrollableScrollPhysics(),
          child: Container(
            height: MediaQuery.of(context).size.height,
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(18.0),
                    child: Text(
                      'กำหนดการบริจาคโลหิตของคุณ',
                      style: TextStyle(
                        fontSize: 25.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  Obx(() {
                    final reservedData = myReservedController.reservedList;
                    if (myReservedController.isLoading.value) {
                      return CircularProgressIndicator();
                    }
                    if (reservedData.isEmpty) {
                      return Text(
                        'ไม่มีกำหนดการบริจาคโลหิตที่จองไว้',
                        style: TextStyle(
                          fontSize: 18.0,
                          color: Colors.white,
                        ),
                      );
                    }
                    return Container(
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
                      child: Column(
                        children: [
                          SizedBox(height: 16),
                          Text(
                            'บริจาควันที่: ${formatDate(reservedData[0].reserveDonationDate)}',
                            style: TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          ProgressBar(donationdate: reservedData[0].reserveDonationDate),
                          SizedBox(height: 16),
                          Text(
                            'สถานที่: ${reservedData[0].locationName}',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            '${reservedData[0].locationDetail}',
                          ),
                          SizedBox(height: 16),
                          Text(
                            '${reservedData[0].scheduleStartTime} - ${reservedData[0].scheduleEndTime} น.',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: 16),
                          Text(
                            'รายละเอียด: ${reservedData[0].scheduleDetail}',
                          ),
                          SizedBox(height: 26),
                          SizedBox(
                            width: double.infinity,
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.redAccent,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(4)
                                ),
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
                                myReservedController.cancelReserved(
                                  reservedData[0].reserveId
                                );
                              }
                            ),
                          ),
                        ],
                      ),
                    );
                  }),
                ],
              ),
            ),
          ),
        ),
      )
    );
  }
}

