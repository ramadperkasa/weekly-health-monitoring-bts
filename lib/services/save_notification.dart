import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class SaveNotification {
  Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

  Future<void> incrementCounter(message) async {
    final SharedPreferences prefs = await _prefs;

    Map<String, dynamic> messageStore = {
      "notificationTitle": message.notification.title,
      "notificationBody": message.notification.body,
      "id": message.data['id'],
      "title": message.data['title'],
      "expiredDate": message.data['expiredDate'],
      "status": message.data['status']
    };

    final notification = (prefs.getString('notification') ?? jsonEncode([]));

    List decodeNotification = jsonDecode(notification);

    decodeNotification.add(messageStore);

    prefs
        .setString("notification", jsonEncode(decodeNotification))
        .then((bool success) {
      return notification;
    });
  }
}
