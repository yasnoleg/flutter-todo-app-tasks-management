import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class LocalNotificationServices {
  static final _notification = FlutterLocalNotificationsPlugin();


  static Future _notificationDetails() async {
    return NotificationDetails(
      android: AndroidNotificationDetails('channel id', 'channel name',importance: Importance.max),
    );
  }


  static Future showNotifiation({
    int id = 0,
    String? title,
    String? body,
    String? payload,
  }) async => _notification.show(id, title, body, await _notificationDetails(), payload: payload);
}