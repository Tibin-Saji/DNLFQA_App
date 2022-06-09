import 'package:dnlfqa_app/firestore_functions.dart';
import 'package:dnlfqa_app/meeting_class.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class MeetingsDatabase {
  static final MeetingsDatabase instance = MeetingsDatabase._init();

  static Database? _database;
  static var dbPath;

  MeetingsDatabase._init();

  Future<Database> get database async {
    if (_database != null) return _database!;

    _database = await _initDB('notes.db');
    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    dbPath = await getDatabasesPath();
    dbPath = join(dbPath, filePath);

    return await openDatabase(dbPath, version: 1, onCreate: _createDB);
  }

  Future _createDB(Database db, int version) async {
    const idType = 'INTEGER PRIMARY KEY AUTOINCREMENT';
    const textType = 'TEXT';
    const integerType = 'INTEGER';
    const notNull = 'NOT NULL';

    await db.execute('''
      CREATE TABLE $tableMeet ( 
        _id $idType,
        ${MeetingField.name} $textType $notNull UNIQUE, 
        ${MeetingField.time} $textType $notNull,
        ${MeetingField.link} $textType $notNull,
        ${MeetingField.mId} $textType $notNull,
        ${MeetingField.pass} $textType $notNull,
        ${MeetingField.note} $textType,
        ${MeetingField.weekday} $textType,
        ${MeetingField.startDate} $textType,
        ${MeetingField.endDate} $textType
        )
    ''');
    //TODO: Take the bottom part out off this function
  }

  Future<void> Insert(Meeting meet) async {
    final db = await instance.database;
    final id = await db.insert(tableMeet, meet.toJson());
    // Do whatever you want with the id here.
  }

  Future<List<Meeting>> readMeetings(bool isWeekly) async {
    final db = await instance.database;

    final where = isWeekly ? 'weekday IS NOT NULL' : 'weekday IS NULL';

    final orderBy = '${MeetingField.weekday} ASC';

    final result = await db.query(tableMeet, orderBy: orderBy, where: where);

    return result.map((json) => Meeting.fromJson(json)).toList();
  }

  // Might have to edit this function as I have no idea what this does
  Future<int> update(Meeting meet) async {
    final db = await instance.database;

    return db.update(
      tableMeet,
      meet.toJson(),
      where: '${MeetingField.mId} = ?',
      whereArgs: [meet.mId],
    );
  }

  Future<void> deleteDb() async {
    await deleteDatabase(dbPath);
  }

  Future<void> deleteEntry(String name) async {
    final db = await instance.database;
    await db.delete(tableMeet,
        where: '${MeetingField.name} = ?', whereArgs: [name]);
  }

  Future<void> deleteAllEntry() async {
    final db = await instance.database;
    db.execute("delete from $tableMeet");
  }

  Future close() async {
    final db = await instance.database;
    db.close();
  }
}
