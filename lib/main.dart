import 'package:blood_donation_application/services/authenthication_manager.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:workmanager/workmanager.dart';
import 'package:timezone/timezone.dart' as tz;
import 'package:timezone/data/latest.dart' as tz;

import 'package:blood_donation_application/screens/authen_screen.dart';
void main() async {
  await GetStorage.init();
  final AuthenticationManager _authManager = Get.put(AuthenticationManager());
  if (_authManager.member.value != null) {
      WidgetsFlutterBinding.ensureInitialized();
      initializeNotifications();
      registerBackgroundTasks();
  }
  runApp(GetMaterialApp(
    title: "Blood Donation Application",
    home: AuthenScreen() ,
  ));
}

// Notification setup
final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
FlutterLocalNotificationsPlugin();

// Dio instance
final Dio dio = Dio(BaseOptions(
  baseUrl: 'http://localhost/Blood_Donation-Web/',
));

Future<void> initializeNotifications() async {
  tz.initializeTimeZones();

  const AndroidInitializationSettings initializationSettingsAndroid =
  AndroidInitializationSettings('@mipmap/ic_launcher');

  final InitializationSettings initializationSettings =
  InitializationSettings(android: initializationSettingsAndroid);

  await flutterLocalNotificationsPlugin.initialize(initializationSettings);
}

void registerBackgroundTasks() {
  Workmanager().initialize(
    callbackDispatcher,
    isInDebugMode: false,
  );

  // Schedule daily check at 6 AM
  Workmanager().registerPeriodicTask(
    "birthdayCheck",
    "birthdayCheckTask",
    frequency: const Duration(hours: 24),
    initialDelay: Duration(seconds: 10),
    constraints: Constraints(
      networkType: NetworkType.connected,
    ),
  );
}

void callbackDispatcher() {
  Workmanager().executeTask((task, inputData) async {
    if (task == "birthdayCheckTask") {
      await checkBirthdaysAndNotify();
    }
    return Future.value(true);
  });
}

Future<void> checkBirthdaysAndNotify() async {
  final AuthenticationManager _authManager = Get.put(AuthenticationManager());
  final member_id = _authManager.member.value.memberID;
  var url = 'http://localhost/Blood_Donation-Web/api/noti_donation?member_id=$member_id';
  print(url);
  try {
    final response = await dio.get('/api/noti_donation?member_id=$member_id',);

    if (response.statusCode == 200) {
      final List<dynamic> notidata = response.data;

      if (notidata.isNotEmpty) {
        await showBirthdayNotification(notidata);
      }
    }
  } catch (e) {
    print('Unexpected error checking : $e');
  }
}

Future<void> showBirthdayNotification(List<dynamic> notidata) async {
  const AndroidNotificationDetails androidPlatformChannelSpecifics =
  AndroidNotificationDetails(
    'birthday_channel',
    'Birthday Notifications',
    importance: Importance.high,
    priority: Priority.high,
    showWhen: false,
  );

  const NotificationDetails platformChannelSpecifics =
  NotificationDetails(android: androidPlatformChannelSpecifics);

  String message = notidata.length == 1
      ? '${notidata[0]['name']} has a birthday coming up!'
      : '${notidata.length} people have birthdays coming up!';

  await flutterLocalNotificationsPlugin.zonedSchedule(
    0,
    'Upcoming Birthdays',
    message,
    _nextInstanceOfSixAM(),
    platformChannelSpecifics,
    androidScheduleMode: AndroidScheduleMode.exact,
    uiLocalNotificationDateInterpretation:
    UILocalNotificationDateInterpretation.absoluteTime,
  );
}

tz.TZDateTime _nextInstanceOfSixAM() {
  final tz.TZDateTime now = tz.TZDateTime.now(tz.local);
  tz.TZDateTime scheduledDate = tz.TZDateTime(
    tz.local,
    now.year,
    now.month,
    now.day,
    6,
  );

  if (scheduledDate.isBefore(now)) {
    scheduledDate = scheduledDate.add(const Duration(days: 1));
  }

  return scheduledDate;
}




