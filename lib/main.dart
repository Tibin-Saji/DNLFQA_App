import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:dnlfqa_app/firestore_functions.dart';
import 'package:dnlfqa_app/globals.dart';
import 'package:dnlfqa_app/screens/home_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'color_palette.dart';

var id;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  //TODO: Add loading screen
  //TODO: make function to check if VideoId is up to date, else get from firestore and save it locally
  //TODO: make function to check if meetings are updated and if so, get them from firestore and save it in db

  var dtCheck;

  final String dt = DateTime.now().day.toString();
  SharedPreferences pref = await SharedPreferences.getInstance();
  dtCheck = pref.get(SharedPrefName.VideoDate);
  if(dtCheck == null){
    getDailyManna();
    dtCheck = pref.get(SharedPrefName.VideoDate);
  }
  if(dt != dtCheck){
    id = await getDailyManna();
  }
  else{
    id = pref.get(SharedPrefName.VideoId);
  }

  dtCheck = pref.get(SharedPrefName.MeetDate);
  if(dtCheck == null){
    getMeetings();
    dtCheck = pref.get(SharedPrefName.VideoDate);
  }
  if(dt != dtCheck){
    getMeetings();
  }

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


class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'DNLF QA',
      theme: ThemeData(
        appBarTheme: AppBarTheme(
        ),
        primarySwatch: ColorPalette.colorDMain,
      ),
      home: HomeScreen(id: id),
    );
  }
}