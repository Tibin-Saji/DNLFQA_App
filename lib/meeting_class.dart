import 'package:flutter/services.dart';

const String tableMeet = 'MeetingsDetail';

class Meeting {
  late String name;
  late String time;
  late String link;
  late String mId;
  late String pass;

  String? note;
  String? weekday;
  String? startDate;
  String? endDate;

  Meeting({
    required this.name,
    required this.time,
    required this.link,
    required this.mId,
    required this.pass,
    this.note = '',
    this.weekday = '',
    this.startDate = '',
    this.endDate = ''
  });

  Map<String, Object?> toJson() => {
    MeetingField.name : name,
    MeetingField.time : time,
    MeetingField.link : link,
    MeetingField.mId : mId,
    MeetingField.pass : pass,
    MeetingField.note : note,
    MeetingField.weekday : weekday,
    MeetingField.startDate : startDate,
    MeetingField.endDate : endDate
  };

  static Meeting fromJson(Map<String, Object?> json) => Meeting(
    name: json[MeetingField.name] as String,
    time: json[MeetingField.time] as String,
    link: json[MeetingField.link] as String,
    mId: json[MeetingField.mId] as String,
    pass: json[MeetingField.pass] as String,
    note: json[MeetingField.note] as String?,
    weekday: json[MeetingField.weekday] as String?,
    startDate: json[MeetingField.startDate] as String?,
    endDate: json[MeetingField.endDate] as String?,
  );


  static Meeting fromJsonFirebase(Map<String, Object?> json) => Meeting(
    name: json['Name'] as String,
    time: json['Time'] as String,
    link: json['Link'] as String,
    mId: json['Id'] as String,
    pass: json['Password'] as String,
    note: json['Note'] as String?,
    weekday: json['Day'] as String?,
    startDate: json['StartDate'] as String?,
    endDate: json['EndDate'] as String?,
  );

  static String meetingtoString(Meeting meet) =>
    '''
    ${meet.name},
    ${meet.time},
    ${meet.link},
    ${meet.mId},
    ${meet.pass},
    ${meet.note ?? ''},
    ${meet.weekday ?? ''},
    ${meet.startDate ?? ''},
    ${meet.endDate ?? ''}
    ''';

  static Meeting stringToMeeting(String str) {
    var meetList = str.split(',');
    return Meeting(
      name: meetList[0].trim(),
      time: meetList[1].trim(),
      link: meetList[2].trim(),
      mId: meetList[3].trim(),
      pass: meetList[4].trim(),
      note: meetList[5].trim() == '' ? null : meetList[5].trim(),
      weekday: meetList[6].trim() == '' ? null : meetList[6].trim(),
      startDate: meetList[7].trim() == '' ? null : meetList[7].trim(),
      endDate: meetList[8].trim() == '' ? null : meetList[8].trim(),
    );
  }
}

class MeetingField{
  static String name = 'name';
  static String time = 'time';
  static String link = 'link';
  static String mId = 'mId';
  static String pass = 'pass';
  static String note = 'note';
  static String weekday = 'weekday';
  static String startDate = 'startDate';
  static String endDate = 'endDate';
}