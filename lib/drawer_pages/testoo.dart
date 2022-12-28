import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:todo/servecis/apinot.dart';
import 'package:todo/servecis/notification_services.dart';
import 'package:timezone/timezone.dart' as tz;
import 'package:timezone/data/latest.dart' as tz;

class TestNotification extends StatefulWidget {
  const TestNotification({super.key});

  @override
  State<TestNotification> createState() => _TestNotificationState();
}

class _TestNotificationState extends State<TestNotification> {

  //Notification
  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
  
  //
  late DateTime currentdate;

  @override
  void initState() {

    Noti.initialize(flutterLocalNotificationsPlugin);
    currentdate = DateTime(2022,12,12,20,24);

    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(backgroundColor: Colors.black,),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          GestureDetector(
            onTap: () {
              Noti.showScheduledNotification(
                title: 'My Title', 
                body: 'My yassine', 
                fln: flutterLocalNotificationsPlugin,
                scheduledDate: DateTime(2022,12,12,19,25),
              );
            },
            child: Container(
              height: 100,
              width: 100,
              decoration: BoxDecoration(
                color: const Color.fromARGB(255, 54, 244, 187),
                borderRadius: BorderRadius.circular(20),
              ),
            ),
          ),
          GestureDetector(
            onTap: () {
              Future.delayed(Duration(milliseconds: 5000), () {
                
              Noti.showBigTextNotification(
                title: 'My Messege Title Here', 
                body: 'My Long Messege Here', 
                fln: flutterLocalNotificationsPlugin
              );
              });
            },
            child: Container(
              height: 100,
              width: 100,
              decoration: BoxDecoration(
                color: Color.fromARGB(255, 228, 54, 244),
                borderRadius: BorderRadius.circular(20),
              ),
            ),
          ),
        ],
      ),
    );
  }
}