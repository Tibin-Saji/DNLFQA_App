bool darkTheme = true;

String getWeekday(int n){
  const weeks = ['Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday', 'Saturday', 'Sunday', ''];
  return weeks[n - 1];
}

class SharedPrefName  {
  static const String VideoDate = 'DailyMannaIdDate';
  static const String MeetDate = 'MeetingsDate';
  static const String VideoId = 'DailyMannaId';
}