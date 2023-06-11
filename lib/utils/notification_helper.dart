import 'dart:convert';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/timezone.dart' as tz;
import 'package:timezone/data/latest.dart' as tz;
import 'package:http/http.dart' as http;

class FirebaseNotification
{
  /// singleton object
  static FirebaseNotification firebaseNotification = FirebaseNotification._();
  FirebaseNotification._();

  /// local notification plugin object
  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

  /// init notification
  Future<void> initNotification()
  async {
    AndroidInitializationSettings androidInitializationSettings = AndroidInitializationSettings('couch');
    DarwinInitializationSettings darwinInitializationSettings = DarwinInitializationSettings();

    InitializationSettings initializationSettings = InitializationSettings(android: androidInitializationSettings,iOS: darwinInitializationSettings);
    await flutterLocalNotificationsPlugin.initialize(initializationSettings);
    tz.initializeTimeZones();
    print('init notification-----------------');

  }

  /// show simple notification
  void showSimpleNotification()
  {
    AndroidNotificationDetails androidNotificationDetails = AndroidNotificationDetails('1', 'TheAkhilSarkar',sound: RawResourceAndroidNotificationSound('notification'));
    DarwinNotificationDetails darwinNotificationDetails = DarwinNotificationDetails();

    NotificationDetails notificationDetails = NotificationDetails(android: androidNotificationDetails,iOS: darwinNotificationDetails);
    flutterLocalNotificationsPlugin.show(1, 'Simple Notification', 'TheAkhilSarkar', notificationDetails);

    print('show notification-----------------');
  }

  /// schedule notification
  void scheduleNotification()
  {
    AndroidNotificationDetails androidNotificationDetails = AndroidNotificationDetails('1', 'TheAkhilSarkar',sound: RawResourceAndroidNotificationSound('notification'));
    DarwinNotificationDetails darwinNotificationDetails = DarwinNotificationDetails();

    NotificationDetails notificationDetails = NotificationDetails(android: androidNotificationDetails,iOS: darwinNotificationDetails);
    flutterLocalNotificationsPlugin.zonedSchedule(1, 'Simple Notification', 'TheAkhilSarkar', tz.TZDateTime.now(tz.local).add( Duration(seconds: 3)),notificationDetails,uiLocalNotificationDateInterpretation: UILocalNotificationDateInterpretation.absoluteTime,);

  }

  /// big picture notification
  Future<void> showBigPictureNotification()
  async {
    String link = 'https://i0.wp.com/kindstatus.com/wp-content/uploads/2021/09/gulzar-shayari-zindagi-in-hindi.jpg?resize=700%2C750&ssl=1';
    String bs64 = await uriToBase64(link);
    BigPictureStyleInformation bigPictureStyleInformation = BigPictureStyleInformation(ByteArrayAndroidBitmap.fromBase64String(bs64));

    AndroidNotificationDetails androidNotificationDetails = AndroidNotificationDetails('1', 'TheAkhilSarkar',sound: RawResourceAndroidNotificationSound('notification'),styleInformation: bigPictureStyleInformation);
    DarwinNotificationDetails darwinNotificationDetails = DarwinNotificationDetails();

    NotificationDetails notificationDetails = NotificationDetails(android: androidNotificationDetails,iOS: darwinNotificationDetails);
    flutterLocalNotificationsPlugin.zonedSchedule(1, 'Picture Notification', 'TheAkhilSarkar', tz.TZDateTime.now(tz.local).add( Duration(seconds: 3)),notificationDetails,uiLocalNotificationDateInterpretation: UILocalNotificationDateInterpretation.absoluteTime,);
    print('big picture notification ----------------');
  }

  /// uri to base64 converter
  Future<String> uriToBase64(String link)
  async {
    var response = await http.get(Uri.parse(link));
    var bs64 = base64Encode(response.bodyBytes);
    return bs64;
  }

  /// ==========================================================================================================================================

  /// Push Notification

  void showFirebasePushNotification(String title, String body)
  {
    AndroidNotificationDetails androidNotificationDetails = AndroidNotificationDetails('1', 'TheAkhilSarkar',sound: RawResourceAndroidNotificationSound('notification'));
    DarwinNotificationDetails darwinNotificationDetails = DarwinNotificationDetails();

    NotificationDetails notificationDetails = NotificationDetails(android: androidNotificationDetails,iOS: darwinNotificationDetails);
    flutterLocalNotificationsPlugin.show(1, '${title}', '${body}', notificationDetails);

    print('firebase notification-----------------');
  }

  FirebaseMessaging firebaseMessaging = FirebaseMessaging.instance;

  Future<void> initFirebaseMessaging()
  async {

    var fcmToken = await firebaseMessaging.getToken();
    print('fcm token $fcmToken --------------------');

    await firebaseMessaging.setAutoInitEnabled(true);
    NotificationSettings notificationSettings = await firebaseMessaging.requestPermission(
      sound: true,
      alert: true,
      announcement: true,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
    );

    FirebaseMessaging.onMessage.listen((event) {
      if(event.notification!=null)
      {
        String? title = event.notification!.title;
        String? body = event.notification!.body;
        FirebaseNotification.firebaseNotification.showFirebasePushNotification(title!, body!);
      }
    });

  }

}