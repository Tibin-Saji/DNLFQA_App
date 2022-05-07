import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';

// database table and column names
final String tableWords = 'words';
final String columnId = '_id';
final String columnWord = 'word';
final String columnFrequency = 'frequency';

final String tableBirthday = 'birthdays';
final String columnName = 'name';
final String columnDate = 'date';

//TODO: Change class Word to Birthdays, Weddings, so on
//TODO: Create a delete function for table and for element

// data model class
class Word {

  late int id = 0;
  late String word;
  late int frequency;

  Word();

  // convenience constructor to create a Word object
  Word.fromMap(Map<String, dynamic> map) {
    //id = map[columnId];
    word = map[columnWord];
    frequency = map[columnFrequency];
  }

  // convenience method to create a Map from this Word object
  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{
      columnWord: word,
      columnFrequency: frequency
    };

      //map[columnId] = id;

    return map;
  }
}

class Birthday{
  late String name;
  late DateTime date;

  Birthday();

  Birthday.fromMap(Map<String, dynamic> map) {
    //id = map[columnId];
    name = map[columnName];
    date = DateTime.parse(map[columnDate]);
  }

  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{
      columnName: name,
      columnDate: date.toString()
    };

    //map[columnId] = id;

    return map;
  }
}

// singleton class to manage the database
class DatabaseHelper {

  // This is the actual database filename that is saved in the docs directory.
  static var _databaseName = "MyDatabase.db";
  // Increment this version when you need to change the schema.
  static var _databaseVersion = 1;

  // Make this a singleton class.
  DatabaseHelper._privateConstructor();
  // DatabaseHelper(){
  //   _databaseName = "MyDatabase.db";
  //   _databaseVersion = 1;
  // }
  static final DatabaseHelper instance = DatabaseHelper._privateConstructor();

  // Only allow a single open connection to the database.
  static Database? _database;
  Future<Database?> get database async {
    if (_database != null) return _database;
    _database = await _initDatabase();
    return _database;
  }

  // open the database
  _initDatabase() async {
    // The path_provider plugin gets the right directory for Android or iOS.
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, _databaseName);
    // Open the database. Can also add an onUpdate callback parameter.
    return await openDatabase(
        path,
        version: _databaseVersion,
        onCreate: _onCreate);
  }

  // SQL string to create the database
  Future _onCreate(Database db, int version) async {
    await db.execute('''
              CREATE TABLE $tableBirthday (
                $columnId INTEGER PRIMARY KEY AUTO_INCREMENT,
                $columnName TEXT NOT NULL,
                $columnDate TEXT NOT NULL
              )
              ''');
  }

  Future DeleteTable(String tableName) async {
    await _database?.execute('''
              DROP TABLE $tableName;
              ''');
  }

  Future DeleteLine(Database db, String tableName, String name) async {
    await _database?.execute('''
              DELETE FROM $tableName WHERE $columnName = $name;
              ''');
  }

  Future DeleteDB() async {
    await _database?.execute('''
              DROP DATABASE $_databaseName;
              ''');
  }

  // Database helper methods:

  Future<int?> insert(Birthday bday) async {
    Database? db = await database;
    int? id = await db?.insert(tableWords, bday.toMap());
    print('The id from insert is $id');
    return id;
  }

  Future queryBirthday(DateTime date) async {
    Database? db = await database;
    List<Map<String, Object?>>? maps = await db?.query(
        tableBirthday,
        columns: [columnId, columnName, columnDate],
        where: '$columnDate = ?',
        whereArgs: [date.toString()]);
    if (maps != null) {
      if (maps.isNotEmpty) {
        //TODO: Return array of map
        return Birthday.fromMap(maps.first);
      }
    }
    return null;
  }

// TODO: queryAllWords()
// TODO: delete(int id)
// TODO: update(Word word)
}