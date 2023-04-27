import 'package:alpha/model/detailPill.dart';
import 'package:alpha/model/pill.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'dart:async';

class DatabaseHelper {

  static final _databaseName = "alpha.db";
  static final _databaseVersion = 1;
  static final user_pill = 'user_pill';
  static final detailPill = 'detailPill';
  static final id=1;

  // make this a singleton class
  DatabaseHelper._privateConstructor();
  static final DatabaseHelper instance = DatabaseHelper._privateConstructor();
  // only have a single app-wide reference to the database
  static Database? _database;
  Future<Database> get database async {
    if (_database != null) return _database!; //싱글톤 패턴을 통해 DB가 실행되었으면, 아래 작업 실행 ㅌ
    // lazily instantiate the db the first time it is accessed
    _database = await _initDatabase();
    return _database!;
  }

  // this opens the database (and creates it if it doesn't exist)
  _initDatabase() async {
    String documentsDirectory = await getDatabasesPath();
    String path = join(documentsDirectory, _databaseName);
    return await openDatabase(
        path,
        version: _databaseVersion,
        onCreate: (db,  version) => _onCreate(db, 1)
    );
  }
  Future<void> deleteDatabase() async{
    String documentsDirectory = await getDatabasesPath();
    String path = join(documentsDirectory, _databaseName);
    databaseFactory.deleteDatabase(path);
  }

  // SQL code to create the database table
  Future _onCreate(Database db, int version) async {
    await db.execute(
        '''CREATE TABLE IF NOT EXISTS $user_pill(
          ind INTEGER PRIMARY KEY autoincrement,
          id intger NOT NULL,
          pillClass text,
          form text,
          company text,
          name text,
          image text,
          bookMarking text
      );
      Create TABLE If not exists $detailPill(
          ind INTEGER PRIMARY KEY AUTOINCREMENT,
          itemName text,
          entpName text,
          itemSeq text,
          efcyQesitm text,
          useMethodQesitm text,
          atpnWarnQesitm text,
          atpnQesitm text,
          intrcQesitm text,
          seQesitm text,
          depositMethodQesitm text,
          FOREIGN KEY ("entpName") REFERENCES user_pill(name)
      );
      '''
          );
    print("DB생성 했음...");
  }

  // Helper methods
  // Inserts a row in the database where each key in the Map is a column name
  // and the value is the column value. The return value is the id of the
  // inserted row.

  //https://iosroid.tistory.com/44

  Future dropTable() async {
    final Database db = await database;

    try {
      var result = await db.execute(
          '''
          Drop table if exists $user_pill;
          Drop table if exists $detailPill;
          ''');
      return result;
    }
    catch (err){
      return err;
    }
  }
  Future insert(Pill pill, DetailPillModel detailpill) async {
    // Get a reference to the database.
    final Database db = await database;

    try {
      var temp = await db.rawInsert(
        '''
        INSERT INTO $user_pill(id, pillClass, form, company, name, image, bookMarking)
        VALUES(?, ?, ?, ?, ?, ?, ?);
        INSERT INTO detailPill(itemName, entpName, itemSeq, efcyQesitm, useMethodQesitm,
                       atpnWarnQesitm, atpnQesitm, seQesitm, depositMethodQesitm)
        VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?);
        ''',
        [
          pill.id, pill.pillClass, pill.form, pill.company, pill.name, pill.image?.data, "true",
          detailpill.itemName, detailpill.entpName, detailpill.itemSeq, detailpill.efcyQesitm, detailpill.useMethodQesitm,
          detailpill.atpnWarnQesitm, detailpill.atpnQesitm, detailpill.seQesitm, detailpill.depositMethodQesitm
        ]
      );
      return temp;
    } catch (err) {
      print(err);
      return err;
    }
  }
  //   try {
  //     await db.insert(
  //       table,
  //       {
  //         "text" : "help text",
  //         "comment" : "help comment"
  //       },
  //       conflictAlgorithm: ConflictAlgorithm.replace,
  //     );
  //     print('Db Inserted');
  //   }
  //   catch(e){
  //     print('DbException'+e.toString());
  //   }
  // }

  // All of the rows are returned as a list of maps, where each map is
  // a key-value list of columns.
  Future<List<Map<String, dynamic>>> queryAllRows() async {
    Database db = await instance.database;
    return await db.query(user_pill);
  }


  Future showPillTables() async {
    Database db = await instance.database;
    var userPillList = await db.rawQuery(
      '''SELECT * FROM $user_pill'''
    );
    return userPillList;
  }


  Future<List<Map<String, dynamic>>> GetSomething() async {
    Database db = await instance.database;
    final List<Map<String, dynamic>> maps = (await db.query(
      '$user_pill',
      where: 'id = ?',
      whereArgs: [2],
    ));
    return maps;

  }
}
//
// Future<dynamic> getDog(int id) async {
//   final db = await database;
//
//   final List<Map<String, dynamic>> maps = (await db.query(
//     'Dog',
//     where: 'id = ?',
//     whereArgs: [id],
//   ));
//
//   return maps.isNotEmpty ? maps : null;
// }
