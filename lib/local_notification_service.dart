import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class LocalNotificationService {
  static final FlutterLocalNotificationsPlugin _notificationsPlugin =
      FlutterLocalNotificationsPlugin();

  static void initialize(BuildContext context) {
    // initializationSettings for Android
    const InitializationSettings initializationSettings =
        InitializationSettings(
      android: AndroidInitializationSettings("@mipmap/ic_launcher"),
    );

    /// TODO initialize method
    _notificationsPlugin.initialize(initializationSettings,
        onSelectNotification: (String route) async {
      print("onSelectNotification");
      if (route.isNotEmpty) {
        Navigator.of(context).pushNamed(route);

        print("Router Value: $route");

        //////// DemoScreen in case of Foreground Message ///////////////////
        // Navigator.of(context).push(
        //   MaterialPageRoute(builder: (context) => DemoScreen(id: id)),
        // );
        ////////////////////////////////////////////////////////////////////
      }
    });
  }

  static void createAndDisplayNotification(RemoteMessage message) async {
    try {
      final id = DateTime.now().millisecondsSinceEpoch ~/ 1000;

      const NotificationDetails notificationDetails = NotificationDetails(
        android: AndroidNotificationDetails(
          // "com.example.flutter_push_notification_app",
          "flutter_push_notification_app",
          "flutter_push_notification_app",
          importance: Importance.max,
          priority: Priority.high,
        ),
      );

      /// pop up show
      await _notificationsPlugin.show(
        id,
        message.notification.title,
        message.notification.body,
        notificationDetails,
        payload: message.data["route"],

        //////// In case of DemoScreen //////////////////////////////////////
        // this "id" key and "id" key of passing firebase's data must same
        // payload: message.data["_id"],
        ////////////////////////////////////////////////////////////////////
      );
    } on Exception catch (e) {
      print(e);
    }
  }
}
