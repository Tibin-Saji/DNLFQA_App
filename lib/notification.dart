import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_native_timezone/flutter_native_timezone.dart';
import 'package:rxdart/rxdart.dart';
import 'package:timezone/timezone.dart' as tz;
import 'package:timezone/data/latest.dart' as tz;

class NotificationApi {
  static final _notifications = FlutterLocalNotificationsPlugin();
  static final onNotifications = BehaviorSubject<String?>();

  static Future showNotification({
    int id = 0,
    String? title,
    String? body,
    String? payload
}) async =>
      _notifications.show(
        id,
        title,
        body,
        await _notificationDetails(),
        payload: payload
      );

  static Future showScheduledNotification({
    int id = 0,
    String? title,
    String? body,
    String? payload,
    var scheduledDate
  }) async =>
      _notifications.zonedSchedule(
          id,
          title,
          body,
          //tz.TZDateTime.from(scheduledDate, tz.local),
          tz.TZDateTime.now(tz.local).add(const Duration(seconds: 10)),
          await _notificationDetails(),
          payload: payload,
          androidAllowWhileIdle: true,
          uiLocalNotificationDateInterpretation: UILocalNotificationDateInterpretation.absoluteTime,
          matchDateTimeComponents: DateTimeComponents.dayOfWeekAndTime
      );

  static Future init({bool initScheduled = false}) async {
    const android =  AndroidInitializationSettings('@mipmap/ic_launcher');
    const ios =  IOSInitializationSettings();
    const settings = InitializationSettings(android: android, iOS: ios);

    await _notifications.initialize(
      settings,
      onSelectNotification: ((payload) async {
        onNotifications.add(payload);
      })
    );

    if(initScheduled){
      tz.initializeTimeZones();
      final locationName = await FlutterNativeTimezone.getLocalTimezone();
      tz.setLocalLocation(tz.getLocation(locationName));
    }
  }

  static Future _notificationDetails() async {
    return const NotificationDetails(
      android: AndroidNotificationDetails(
          'Meetings Channel Id',
          'Meetings Channel',
          channelDescription: 'This is the channel for meetings notification',
          importance: Importance.max
      ),
      iOS: IOSNotificationDetails()
    );
  }

    //No for loop
    // for(Meeting meet in meetings) {
    //   var weekday = int.parse(meet.weekday!);
    //   var time = meet.time;
    //   var scheduledDate = _nextInstanceOfTime(time, now);
    //   while (scheduledDate.weekday != weekday) {
    //     scheduledDate = scheduledDate.add(const Duration(days: 1));
    //   }

}