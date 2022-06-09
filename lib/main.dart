import 'package:dnlfqa_app/screens/wrapper.dart';
import 'package:timezone/timezone.dart' as tz;
import 'package:timezone/data/latest.dart' as tz;

import 'package:dnlfqa_app/firestore_functions.dart';
import 'package:dnlfqa_app/globals.dart';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'color_palette.dart';
import 'database_helpers.dart';
import 'meeting_class.dart';
import 'notification.dart';

var id;
// bool? isMember;
List<Meeting> weeklyMeetings = [];
List<Meeting> specialMeetings = [];

tz.TZDateTime _nextInstanceOfTime(String time, tz.TZDateTime now) {
  tz.TZDateTime scheduledDate =
      tz.TZDateTime(tz.local, now.year, now.month, now.day, int.parse(time));
  if (scheduledDate.isBefore(now)) {
    scheduledDate = scheduledDate.add(const Duration(days: 1));
  }
  print(scheduledDate);
  return scheduledDate;
}

Future<tz.TZDateTime> _notificationTime(
    String time, String? weekday, String? startDate, String? endDate) async {
  final tz.TZDateTime now = tz.TZDateTime.now(tz.local);
  tz.TZDateTime schedDate = _nextInstanceOfTime(time, now);

  if (weekday != null) {
    while (schedDate.weekday != int.parse(weekday)) {
      schedDate = schedDate.add(const Duration(days: 1));
    }
  } else if (startDate != null && endDate != null) {
    var startDateList = startDate.split(' ');
    var endDateList = endDate.split(' ');

    tz.TZDateTime sDate = tz.TZDateTime(tz.local, int.parse(startDateList[0]),
        int.parse(startDateList[1]), int.parse(startDateList[2]));
    tz.TZDateTime eDate = tz.TZDateTime(tz.local, int.parse(endDateList[0]),
        int.parse(endDateList[1]), int.parse(endDateList[2]));

    while (schedDate.isBefore(sDate) && !schedDate.isAfter(eDate)) {
      schedDate = schedDate.add(const Duration(days: 1));
    }
  }
  print(schedDate);
  return schedDate;
}

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  SharedPreferences pref = await SharedPreferences.getInstance();

  isMember = pref.get(SharedPrefName.IsMember) as bool?;

  String? dtCheck;

  final String dt = DateTime.now().day.toString();

  dtCheck = pref.get(SharedPrefName.VideoDate) as String?;

  if (dtCheck == null) {
    getDailyManna();
    dtCheck = pref.get(SharedPrefName.VideoDate) as String?;
  }

  if (dt != dtCheck) {
    id = await getDailyManna();
  } else {
    id = pref.get(SharedPrefName.VideoId);
  }

  dtCheck = pref.get(SharedPrefName.MeetDate) as String?;
  if (dtCheck == null) {
    getMeetings();
    dtCheck = pref.get(SharedPrefName.VideoDate) as String?;
  }
  if (dt != dtCheck) {
    MeetingsDatabase.instance.deleteAllEntry();
    getMeetings();
  }
  weeklyMeetings = await MeetingsDatabase.instance.readMeetings(true);
  specialMeetings = await MeetingsDatabase.instance.readMeetings(false);

  //testNotif();
  // NotificationApi.showScheduledNotification(
  //     title: "Helloo",
  //     body: 'body',
  //     scheduledDate: DateTime.now().add(Duration(seconds: 20)));

  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    NotificationApi.init(initScheduled: true);
    listenNotifications();

    print('reached testCron()');

    // TODO: The notification only works when the app is active. Remember to change that
    // for(int i = 0; i < weeklyMeetings.length; i++){
    //   weelyMeetingNotif(weeklyMeetings[i], i);
    // }
    //
    // for(int i = 0; i < specialMeetings.length; i++){
    //   specialMeetingNotif(specialMeetings[i], i);
    // }
    //notificationSetter();
    // print(meetings.length);
    // NotificationApi.showScheduledNotification(
    //     id: 1,
    //     title: "Don't forget the meeting",
    //     body: "You have meeting now.",
    //     payload: Meeting.meetingtoString(meetings[1]),
    //     scheduledDate: DateTime.now().add(const Duration(seconds: 12))
    // );

    // print('added notification');
  }

  @override
  Widget build(BuildContext context) {
    // NotificationApi.showScheduledNotification(
    //     id: 1,
    //     title: "Don't forget the meeting",
    //     body: "You have meeting now.",
    //     payload: Meeting.meetingtoString(meetings[1]),
    //     scheduledDate: DateTime.now().add(const Duration(seconds: 12))
    // );
    return MaterialApp(
      title: 'DNLF QA',
      theme: ThemeData(
        appBarTheme: AppBarTheme(),
        primarySwatch: ColorPalette.colorDMain,
      ),
      home: Wrapper(),
      // home: HomeNotMemberScreen(),
      // home: FormScreen(),
    );
  }

  void listenNotifications() {
    NotificationApi.onNotifications.stream.listen(onClickedNotification);
  }

  void onClickedNotification(
          String?
              payload) => /*Navigator.of(context).push(MaterialPageRoute(
      builder: (context) => MeetingDetailsScreen(meetStr: payload)
    )
  );*/
      null;
}
