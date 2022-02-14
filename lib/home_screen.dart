import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_push_notification_app/local_notification_service.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  /// TODO initState Method
  @override
  void initState() {
    super.initState();

    LocalNotificationService.initialize(context);

    /// TODO Terminated State
    /// 1. This method call when app in terminated state and you get a notification
    // when you click on notification app open from terminated state and
    // you can get notification data in this method
    FirebaseMessaging.instance.getInitialMessage().then((message) {
      print("FirebaseMessaging.instance.getInitialMessage");
      if (message != null) {
        final routeFromMessage = message.data["route"];
        Navigator.of(context).pushNamed(routeFromMessage);

        print(message.notification.title);
        print(message.notification.body);
        print("Terminated Message ID: ${message.data["_id"]}");

        //////// In case of DemoScreen ///////////////////
        // if (message.data['_id'] != null) {
        //   Navigator.of(context).push(MaterialPageRoute(
        //       builder: (context) => DemoScreen(id: message.data['_id'])));
        // }
        //////////////////////////////////////////////////

        LocalNotificationService.createAndDisplayNotification(message);
      }
    });

    /// TODO Foreground State
    /// 2. This method only call when App in foreground it mean app must be opened
    FirebaseMessaging.onMessage.listen((message) {
      print("FirebaseMessaging.onMessage.listen");
      if (message.notification != null) {
        print(message.notification.title);
        print(message.notification.body);
        print("Foreground Message ID: ${message.data["_id"]}");
        LocalNotificationService.createAndDisplayNotification(message);
      }
    });

    /// TODO Background State
    /// 3. This method only call when App in background and not terminated(not closed)
    FirebaseMessaging.onMessageOpenedApp.listen((message) {
      print("FirebaseMessaging.onMessageOpenedApp.listen");
      if (message.notification != null) {
        final routeFromMessage = message.data["route"];
        Navigator.of(context).pushNamed(routeFromMessage);

        print(message.notification.title);
        print(message.notification.body);
        print("Background Message ID: ${message.data['_id']}");

        LocalNotificationService.createAndDisplayNotification(message);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Push Notification App"),
        centerTitle: true,
      ),
      body: Center(
        child: Text("Notification"),
      ),
    );
  }
}
