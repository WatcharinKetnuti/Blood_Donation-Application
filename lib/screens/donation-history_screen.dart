import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import '../controllers/donation-history_controller.dart';
import '../models/donation_history_model.dart';

class DonationHistoryScreen extends StatelessWidget {
  final DonationHistoryController historyController = Get.put(DonationHistoryController());

  String formatDate(DateTime date) {
    return DateFormat('dd/MM/yyyy').format(date);
  }

   @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.redAccent,
      appBar: AppBar(
        backgroundColor: Colors.redAccent,
        title: Text(
          'ประวัติการบริจาคเลือด',
          style: TextStyle(
            fontSize: 25.0,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          historyController.fetchDonationHistory();
          return Future.value();
        },
        color: Colors.redAccent,
        backgroundColor: Colors.white,
        child: SingleChildScrollView(
          physics: AlwaysScrollableScrollPhysics(),
          child: Container(
            height: MediaQuery.of(context).size.height - 
                   AppBar().preferredSize.height - 
                   MediaQuery.of(context).padding.top,
            child: Column(
              children: [
                Container(
                  margin: EdgeInsets.all(16.0),
                  padding: EdgeInsets.all(16.0),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10.0),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black12,
                        blurRadius: 10,
                        spreadRadius: 5,
                      ),
                    ],
                  ),
                  child: Obx(() {
                    return Column(
                      children: [
                        Text(
                          'จำนวนครั้งที่บริจาค',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          '${historyController.donationCount.value} ครั้ง',
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: Colors.redAccent,
                          ),
                        ),
                      ],
                    );
                  }),
                ),
                Expanded(
                  child: Obx(() {
                    if (historyController.isLoading.value) {
                      return Center(child: CircularProgressIndicator());
                    } else if (historyController.donationList.isEmpty) {
                      return Center(
                        child: Text(
                          'ยังไม่มีประวัติการบริจาคเลือด',
                          style: TextStyle(
                            fontSize: 18,
                            color: Colors.white,
                          ),
                        ),
                      );
                    } else {
                      return ListView.builder(
                        itemCount: historyController.donationList.length,
                        itemBuilder: (context, index) {
                          final donation = historyController.donationList[index];
                        
                          final sortedList = List<DonationHistory>.from(historyController.donationList);
                          sortedList.sort((a, b) => DateTime.parse(a.donationDate).compareTo(DateTime.parse(b.donationDate)));
                          final chronologicalIndex = sortedList.indexWhere((d) => d.donationId == donation.donationId) + 1;
              
                          return Container(
                            margin: EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            child: ListTile(
                              title: Text(
                                donation.locationName,
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              subtitle: Text(
                                'ครั้งที่ $chronologicalIndex',
                                style: TextStyle(
                                  color: Colors.grey[600],
                                ),
                              ),
                              trailing: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  Text(
                                    donation.donationDate,
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      );
                    }
                  }),
                ),
                SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }
}