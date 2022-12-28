import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/timezone.dart' as tz;

class Noti{
  static Future initialize(FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin) async {
    var androidInitialize = new AndroidInitializationSettings('@drawable/ic_stat_assignment');
    var initializationSettings = new InitializationSettings(android: androidInitialize);

    await flutterLocalNotificationsPlugin.initialize(initializationSettings);
  }

  static Future showBigTextNotification({var id =0, required String title,required String body, var payload, required FlutterLocalNotificationsPlugin fln}) async {
    AndroidNotificationDetails androidPlatformChannelSpecifics = new AndroidNotificationDetails(
      'chaid', 
      'chana',
      playSound: true,
      //sound:  RawResourceAndroidNotificationSound('notification'),
      importance: Importance.max,
      priority: Priority.high,  
    );

    var not = NotificationDetails(android: androidPlatformChannelSpecifics);
    await fln.show(0, title, body, not);
  }

  static Future showScheduledNotification({var id =0, required String title,required String body, var payload, required FlutterLocalNotificationsPlugin fln, required DateTime scheduledDate}) async {
    AndroidNotificationDetails androidPlatformChannelSpecifics = new AndroidNotificationDetails(
      'chaid', 
      'chana',
      playSound: true,
      //sound:  RawResourceAndroidNotificationSound('notification'),
      importance: Importance.max,
      priority: Priority.high,  
    );

    var not = NotificationDetails(android: androidPlatformChannelSpecifics);
    late var _local = tz.local;
    await fln.zonedSchedule(
      id, 
      title, 
      body, 
      tz.TZDateTime.from(scheduledDate, tz.local),
      not,  
      androidAllowWhileIdle: true,
      uiLocalNotificationDateInterpretation: UILocalNotificationDateInterpretation.absoluteTime,
    );
  }
}