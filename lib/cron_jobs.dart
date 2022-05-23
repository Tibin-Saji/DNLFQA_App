import 'package:cron/cron.dart';
import 'package:dnlfqa_app/firestore_functions.dart';
import 'package:shared_preferences/shared_preferences.dart';

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

