import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:m_whm/constants/color.dart';

import 'package:m_whm/screen/loading_screen.dart';
import 'package:m_whm/services/save_notification.dart';
import 'package:overlay_support/overlay_support.dart';

FirebaseMessaging messaging = FirebaseMessaging.instance;

const AndroidNotificationChannel channel = AndroidNotificationChannel(
  'main_notification_channel',
  'Main Notifications',
  'This channel is used for main notifications.',
  importance: Importance.defaultImportance,
);

class PushNotificationService {
  void handleInAppNotification(context) async {
    await FirebaseMessaging.instance.subscribeToTopic('new-question');
    final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
        FlutterLocalNotificationsPlugin();

    await flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(channel);

    messaging.getToken().then((token) {
      print('Token: $token');
    }).catchError((e) {
      print(e);
    });

    // RemoteMessage initialMessage =
    //     await FirebaseMessaging.instance.getInitialMessage();

    // if (initialMessage?.data['type'] == 'survey') {
    //   Navigator.push(
    //     context,
    //     MaterialPageRoute(
    //       builder: (context) {
    //         return LoadingScreen();
    //       },
    //     ),
    //   );
    // }

    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      if (message?.data['type'] == 'survey') {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) {
              return LoadingScreen();
            },
          ),
        );
      }
    });

    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      RemoteNotification notification = message.notification;
      AndroidNotification android = message.notification?.android;

      if (notification != null && android != null) {
        flutterLocalNotificationsPlugin.show(
            notification.hashCode,
            notification.title,
            notification.body,
            NotificationDetails(
              android: AndroidNotificationDetails(
                  channel.id, channel.name, channel.description,
                  icon: android?.smallIcon),
            ));
      }

      SaveNotification().incrementCounter(message);

      showSimpleNotification(
        Text('${notification.title}'),
        subtitle: Text('${notification.body}'),
        background: BaseColors.primary,
        duration: Duration(seconds: 2),
        foreground: Colors.white,
        slideDismissDirection: DismissDirection.up,
      );
    });

    NotificationSettings settings = await messaging.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );

    if (settings.authorizationStatus == AuthorizationStatus.authorized) {
      print('User granted permission');
    } else if (settings.authorizationStatus ==
        AuthorizationStatus.provisional) {
      print('User granted provisional permission');
    } else {
      print('User declined or has not accepted permission');
    }
  }
}
