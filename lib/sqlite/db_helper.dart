import 'dart:async';
import 'dart:io' as io;
import 'package:m_whm/sqlite/question.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';

class DBHelper {
  static Database _db;
  static const String ID = 'id';
  static const String NAME = 'name';
  static const String QUESTION = 'question';
  static const String ANSWER = 'answer';
  static const String DATE = 'date';
  static const String USER = 'user';
  static const String TABLE = 'my_table';
  static const String DB_NAME = 'MyDatabase.db';

  Future<Database> get db async {
    if (_db != null) {
      return _db;
    }
    _db = await initDb();
    return _db;
  }

  initDb() async {
    io.Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, DB_NAME);
    var db = await openDatabase(path, version: 1, onCreate: _onCreate);
    return db;
  }

  _onCreate(Database db, int version) async {
    await db.execute('''CREATE TABLE $TABLE (
         $ID INTEGER PRIMARY KEY,
         $NAME TEXT,
         $QUESTION TEXT,
         $ANSWER TEXT,
         $USER TEXT,
         $DATE TEXT
        )''');
  }

  Future<int> save(Map<String, dynamic> row) async {
    var dbClient = await db;
    return await dbClient.insert(TABLE, row);
  }

  Future<List<Map<String, dynamic>>> queryAllRows() async {
    var dbClient = await db;
    return await dbClient.query(TABLE);
  }

  Future<int> delete(int id) async {
    var dbClient = await db;
    return await dbClient.delete(TABLE, where: '$ID = ?', whereArgs: [id]);
  }

  Future<int> update(QuestionModelSql row) async {
    var dbClient = await db;
    return await dbClient
        .update(TABLE, row.toMap(), where: '$ID = ?', whereArgs: [row.id]);
  }

  Future close() async {
    var dbClient = await db;
    dbClient.close();
  }
}
