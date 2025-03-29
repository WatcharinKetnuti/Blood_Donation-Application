import 'dart:async';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:intl/intl.dart';
import 'package:workmanager/workmanager.dart';
import 'package:timezone/timezone.dart' as tz;
import 'package:timezone/data/latest.dart' as tz;
import 'controllers/my_reserved_controller.dart';
import 'controllers/notification_controller.dart';
import 'screens/authen_screen.dart';
import 'services/api_service.dart';
import 'services/authenthication_manager.dart';

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
ApiService request = ApiService();
final AuthenticationManager _authManager = Get.put(AuthenticationManager());
final mem = _authManager.member.value;
final notificationController = Get.put(NotificationController());

void startNotificationTimer() {
  const Duration interval = Duration(seconds: 10);
  Timer.periodic(interval, (Timer timer) async {
    const AndroidNotificationDetails androidDetails =
    AndroidNotificationDetails('', 'blood_donation_channel',
      channelDescription: 'Blood Donation Notifications',
      importance: Importance.max,
      priority: Priority.high,
    );

    const NotificationDetails notificationDetails = NotificationDetails(android: androidDetails);

    print('Triggering notification at ${DateTime.now()}');

    if (mem.memberID != '') {
      notificationController.fetchReserved();
      final data = notificationController.reservedForNotification;
      if(data.isNotEmpty) {
        final DateFormat formatter = DateFormat('yyyy-MM-dd');
        final DateTime DateNow = formatter.parse(DateTime.now().toString());
        final DateTime DateDonation = formatter.parse(data[0].reserveDonationDate);
        final int difference = DateDonation.difference(DateNow).inDays;
        var detail = "วันบริจาคเลือดของคุณ ${data[0].reserveDonationDate} อีก ${difference} วัน";
        if(difference == 0) {
          detail = "วันนี้คุณมีนัดบริจาคเลือด";
        }
        await flutterLocalNotificationsPlugin.show(
          0,
          'แจ้งเตือนการบริจาคเลือด',
          '$detail',
          notificationDetails,
        );
      }

      notificationController.fetchSchedules('','', true);
      final data2 = notificationController.scheduleListForNotification;
      print('data2: ${data2.length}');
      if(data2.isNotEmpty) {
        await flutterLocalNotificationsPlugin.show(
          1,
          'แจ้งเตื่อนกำหนดการบริจาคเลือด',
          'มีกำหนดการบริจาคที่สามารถจองได้ และกรุ๊ปเลือดตรงกับคุณ ${data2.length} รายการ',
          notificationDetails,
        );
      }
    }

  });
}

void main() async {
  print('= main.dart =');
  WidgetsFlutterBinding.ensureInitialized(); // Ensure Flutter bindings are initialized
  await GetStorage.init();

  tz.initializeTimeZones();


  // Initialize local notifications
  const AndroidInitializationSettings initializationSettingsAndroid =
      AndroidInitializationSettings('@mipmap/ic_launcher');
  const InitializationSettings initializationSettings =
      InitializationSettings(android: initializationSettingsAndroid);
  await flutterLocalNotificationsPlugin.initialize(initializationSettings);

  // Request notification permissions for Android 13+
  final androidPlugin = flutterLocalNotificationsPlugin
      .resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin>();
  if (androidPlugin != null) {
    final isEnabled = await androidPlugin.areNotificationsEnabled();
    if (isEnabled != null && !isEnabled) {
      await androidPlugin.requestNotificationsPermission();
    }
  }

  // Debugging: Log if notifications are enabled
  print('Notifications enabled: ${await androidPlugin?.areNotificationsEnabled()}');

  // Start the notification timer
  startNotificationTimer();

  runApp(GetMaterialApp(
    title: "Blood Donation Application",
    home: AuthenScreen(),
  ));
}






