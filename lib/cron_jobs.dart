import 'package:cron/cron.dart';
import 'package:dnlfqa_app/firestore_functions.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'meeting_class.dart';
import 'notification.dart';

// void getVideoId (){
//   var cron = Cron();
//   var dt = DateTime(2022, 1, 3, 6, 0).subtract(DateTime(2022).timeZoneOffset);
//   var dt_str = "${dt.minute} ${dt.hour} * * *";
//
//   cron.schedule(Schedule.parse(dt_str), () async {
//     // print(dt_str);
//     var id = await  getDailyManna();
//     await SharedPreferences.getInstance().then((pref) => {
//         pref.setString('DailyMannaId', id)
//     });
//   });
// }

// void checkForMeetingChange(){
//   var cron = Cron();
//   cron.schedule(Schedule.parse('0 0 * * *'), () async {
//     var result = MeetingChange();
//   });
// }

void testNotif() {
  var cron = Cron();
  var time = DateTime.now().add(Duration(seconds: 20)).toString().split(' ')[1];
  var timeList = time.split(':');
  cron.schedule(
      Schedule.parse(
          '${timeList[2].split('.')[0]} ${timeList[1]} ${timeList[0]} * * *'),
      () {
    print(DateTime.now());
    NotificationApi.showNotification(
      title: "Don't forget the meeting",
      body: DateTime.now().toString(),
    );
  });
}

void weelyMeetingNotif(Meeting meet) {
  var cron = Cron();
  var time = '12:12';
  var timeList = time.split(':');
  cron.schedule(Schedule.parse('${timeList[1]} ${timeList[0]} * * *'), () {
    print(DateTime.now());
    NotificationApi.showNotification(
        title: "Don't forget the meeting",
        body: "You have meeting now.",
        payload: 'Hellooo'
        //scheduledDate: DateTime.now().add(const Duration(seconds: 12))
        );
  });
}

void specialMeetingNotif(Meeting meet, int id) {
  var cron = Cron();
  var time = '12:12';
  var timeList = time.split(':');
  cron.schedule(Schedule.parse('${timeList[1]} ${timeList[0]} * * *'), () {
    print(DateTime.now());
    NotificationApi.showNotification(
        id: id,
        title: "Don't forget the meeting",
        body: "You have meeting now.",
        payload: 'Hellooo'
        //scheduledDate: DateTime.now().add(const Duration(seconds: 12))
        );
  });
}
