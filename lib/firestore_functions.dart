import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dnlfqa_app/globals.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'database_helpers.dart';
import 'meeting_class.dart';

Future<String> getDailyManna() async {
  var snapshot = await FirebaseFirestore.instance
      .collection('Misc.')
      .doc('Constants')
      .get();
  final id = snapshot["DailyMannaId"];
  String? _id;
  SharedPreferences.getInstance()
      .then((pref) => _id = pref.get(SharedPrefName.VideoId) as String?);

  if (_id == id) {
    return id;
  }

  SharedPreferences.getInstance()
      .then((pref) => {pref.setString(SharedPrefName.VideoId, id)});
  SharedPreferences.getInstance().then((pref) => {
        pref.setString(SharedPrefName.VideoDate, DateTime.now().day.toString())
      });
  return id;
}

Future<void> getMeetings() async {
  CollectionReference _collectionRef =
      FirebaseFirestore.instance.collection('Meetings');

  QuerySnapshot querySnapshot = await _collectionRef.get();

  final List<Map<String, Object?>> allData = querySnapshot.docs
      .map((doc) => doc.data() as Map<String, Object?>)
      .toList();

  SharedPreferences.getInstance().then((pref) =>
      {pref.setString(SharedPrefName.MeetDate, DateTime.now().day.toString())});

  await MeetingsDatabase.instance.deleteAllEntry();
  for (int i = 0; i < allData.length; i++) {
    await MeetingsDatabase.instance
        .Insert(Meeting.fromJsonFirebase(allData[i]));
  }
}

//TODO: make travel class like that of meeting and change the function
// Travel detail 1 : date(day-month); Travel detail 2 : date(day-month)......
// Travel detail 1 :
Future<void> getTravel() async {
  var document = await FirebaseFirestore.instance
      .collection('Misc.')
      .doc('Travelling')
      .get();

  final String toQatarStr = document['ToQatar'];
  final String fromQatarStr = document['FromQatar'];
  final String otherStr = document['ToQatar'];

  SharedPreferences.getInstance().then((pref) =>
      {pref.setString(SharedPrefName.MeetDate, DateTime.now().day.toString())});

  for (int i = 0; i < otherStr.length; i++) {
    //await MeetingsDatabase.instance.deleteEntry(allData[i]['Name'] as String);

  }
}

Future<bool> checkMembership(String phone) async {
  var document = await FirebaseFirestore.instance
      .collection('Misc.')
      .doc('MemberPhoneNo')
      .get();
  String phoneStr = document["Numbers"];
  List<String> phoneNo = phoneStr.split(',');
  print(phoneNo);

  SharedPreferences pref = await SharedPreferences.getInstance();

  bool isMember = phoneNo.contains(phone);
  pref.setBool(SharedPrefName.IsMember, isMember);
  print('Is member : $isMember');
  return isMember;
}

// Future MeetingChange() async {
//   var  doc =
//   await FirebaseFirestore.instance.collection('Meetings').doc('DocChange').get();
//   bool docChange = doc['hasChanged'];
//
//   return docChange ? getMeetings() : null;
// }
