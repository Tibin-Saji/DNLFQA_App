import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:dnlfqa_app/screens/home_screen.dart';
import 'package:dnlfqa_app/screens/settings_screen.dart';
import 'package:dnlfqa_app/screens/wishing_screen.dart';
import 'package:flutter/material.dart';
import 'color_palette.dart';

void main() {
  AwesomeNotifications().initialize(
      'resource://drawable/res_logo',
      [
        NotificationChannel(
          channelKey: 'basic_channel',
          channelName: 'Basic Notifications',
          //defaultColor: Colors.brown,
          importance: NotificationImportance.High,
          channelShowBadge: true,
          channelDescription: '',
        ),
        NotificationChannel(
            channelKey: 'scheduled_channel',
            channelName: 'Scheduled Notifications',
            //defaultColor: Colors.teal,
            locked: true,
            importance: NotificationImportance.High,
            soundSource: 'resource://raw/res_ping_message',
            channelDescription: ''
        ),
      ],
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'DNLF QA',
      theme: ThemeData(
        appBarTheme: AppBarTheme(
          //backgroundColor: Colors.black54,
          //color: Colors.red
        ),
        primarySwatch: ColorPalette.colorDMain,
      ),
      home: const HomeScreen(),
    );
  }
}