// ignore_for_file: prefer_const_constructors, unused_local_variable

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:provider/provider.dart';
import 'package:todo/Provider/background_provider.dart';
import 'package:todo/Provider/percent_provider.dart';
import 'package:todo/Provider/quill_controller_json_provider.dart';
import 'package:todo/data_base/databasehive.dart';
import 'package:todo/pages/homepage.dart';
import 'package:todo/pages/mainpage.dart';
import 'package:timezone/timezone.dart' as tz;
import 'package:timezone/data/latest.dart' as tz;

void main() async {
  await Hive.initFlutter();
  var box = await Hive.openBox("mybox");
  var boxs = await Hive.openBox("mylocal");
  
  tz.initializeTimeZones();
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => PercentUp()),
        ChangeNotifierProvider(create: (a) => ControllerJsonProvider()),
        ChangeNotifierProvider(create: (b) => BackProvider()),
      ],
      child: MyApp(),
    ),
  );
  SystemChrome.setSystemUIOverlayStyle(
    SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
    ),
  );
  SystemSound.play(SystemSoundType.click);
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) => MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      themeMode: ThemeMode.dark,
      darkTheme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: Colors.black,
      ),
     initialRoute: '/',
     routes: {
      '/': (context) => HomeMainPage(),
     },
    );
      
  
}

