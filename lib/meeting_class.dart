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