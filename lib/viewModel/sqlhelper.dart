import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'dart:async';

class DatabaseHelper {

  static final _databaseName = "alpha.db";
  static final _databaseVersion = 1;
  static final table = 'user_pill';
  static final id=1;

  // make this a singleton class
  DatabaseHelper._privateConstructor();
  static final DatabaseHelper instance = DatabaseHelper._privateConstructor();
  // only have a single app-wide reference to the database
  static Database? _database;
  Future<Database> get database async {
    print(1);
    if (_database != null) return _database!; //싱글톤 패턴을 통해 DB가 실행되었으면, 아래 작업 실행 ㅌ
    // lazily instantiate the db the first time it is accessed
    print(2);
    _database = await _initDatabase();
    print(3);
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

  // SQL code to create the database table
  Future _onCreate(Database db, int version) async {
    print("DB생성 했음...");
    await db.execute('''      
      CREATE TABLE IF NOT EXISTS $table(
          ind INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
          id INT NOT NULL,
          pillClass text,
          shape text,
          company text,
          name text,
          image text,
          bookMarking text
      )
          ''');
  }

  // Helper methods
  // Inserts a row in the database where each key in the Map is a column name
  // and the value is the column value. The return value is the id of the
  // inserted row.

  Future insert() async {
    // Get a reference to the database.
    final Database db = await database;
    try {
      await db.insert(
        table,
        {
          "text" : "help text",
          "comment" : "help comment"
        },
        conflictAlgorithm: ConflictAlgorithm.replace,
      );

      print('Db Inserted');
    }
    catch(e){
      print('DbException'+e.toString());
    }
  }

  // All of the rows are returned as a list of maps, where each map is
  // a key-value list of columns.
  Future<List<Map<String, dynamic>>> queryAllRows() async {
    Database db = await instance.database;
    return await db.query(table);
  }


  Future<List<Map<String, dynamic>>> GetSomething() async {
    Database db = await instance.database;
    final List<Map<String, dynamic>> maps = (await db.query(
      '$table',
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