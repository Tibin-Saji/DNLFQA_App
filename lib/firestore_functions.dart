import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dnlfqa_app/globals.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'database_helpers.dart';
import 'meeting_class.dart';


Future<String> getDailyManna() async {
  var snapshot = await FirebaseFirestore.instance
      .collection('Misc.')
      .doc('Constants').get();
  final id = snapshot["DailyMannaId"];
  SharedPreferences.getInstance().then((pref) => {
        pref.setString(SharedPrefName.VideoId, id)
  });
  SharedPreferences.getInstance().then((pref) =>{
      pref.setString(SharedPrefName.VideoDate, DateTime.now().day.toString())
  });
  return id;
}

Future<void> getMeetings() async {
  CollectionReference _collectionRef =
  FirebaseFirestore.instance.collection('Meetings');

  QuerySnapshot querySnapshot = await _collectionRef.get();

  final List<Map<String, Object?>> allData =
  querySnapshot.docs.map((doc) => doc.data() as Map<String, Object?>).toList();

  SharedPreferences.getInstance().then((pref) => {
    pref.setString(SharedPrefName.MeetDate!, DateTime.now().day.toString())
  });

  for(int i = 0; i < allData.length; i++){
    //await MeetingsDatabase.instance.deleteEntry(allData[i]['Name'] as String);
    await MeetingsDatabase.instance.Insert(Meeting.fromJsonFirebase(allData[i]));
  }
}

// Future MeetingChange() async {
//   var  doc =
//   await FirebaseFirestore.instance.collection('Meetings').doc('DocChange').get();
//   bool docChange = doc['hasChanged'];
//
//   return docChange ? getMeetings() : null;
// }