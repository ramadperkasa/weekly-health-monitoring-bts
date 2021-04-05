import 'dart:async';
import 'dart:io' as io;
import 'package:m_whm/sqlite/question.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';
import 'question.dart';

class DBHelper {
  static Database _db;
  static const String ID = 'id';
  static const String NAME = 'name';
  static const String TABLE = 'QuestionSql';
  static const String DB_NAME = 'question1.db';

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
    await db
        .execute("CREATE TABLE $TABLE ($ID INTEGER PRIMARY KEY, $NAME TEXT)");
  }

  Future<QuestionSql> save(QuestionSql question) async {
    var dbClient = await db;
    question.id = await dbClient.insert(TABLE, question.toMap());
    return question;
  }

  Future<List<QuestionSql>> getQuestionSqls() async {
    var dbClient = await db;
    List<Map> maps = await dbClient.query(TABLE, columns: [ID, NAME]);
    List<QuestionSql> questions = [];
    if (maps.length > 0) {
      for (int i = 0; i < maps.length; i++) {
        questions.add(QuestionSql.fromMap(maps[i]));
      }
    }
    return questions;
  }

  Future<int> delete(int id) async {
    var dbClient = await db;
    return await dbClient.delete(TABLE, where: '$ID = ?', whereArgs: [id]);
  }

  Future<int> update(QuestionSql question) async {
    var dbClient = await db;
    return await dbClient.update(TABLE, question.toMap(),
        where: '$ID = ?', whereArgs: [question.id]);
  }

  Future close() async {
    var dbClient = await db;
    dbClient.close();
  }
}
