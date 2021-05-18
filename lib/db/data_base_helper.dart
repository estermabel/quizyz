import 'dart:io';
import 'package:path/path.dart';
import 'package:quizyz/model/Quiz.dart';
import 'package:quizyz/model/User.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';

class DatabaseHelper {
  static final _databaseName = "QuizDB.db";
  static final _databaseVersion = 1;
  static final table = 'user';
  static final columnId = '_id';
  static final columnNome = 'nome';
  static final columnEmail = 'email';
  // torna esta classe singleton
  DatabaseHelper._privateConstructor();
  static final DatabaseHelper instance = DatabaseHelper._privateConstructor();
  // tem somente uma referência ao banco de dados
  static Database _database;

  Future<Database> get database async {
    if (_database != null) return _database;
    // instancia o db na primeira vez que for acessado
    _database = await _initDatabase();
    return _database;
  }

  // abre o banco de dados e o cria se ele não existir
  _initDatabase() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, _databaseName);
    return await openDatabase(
      path,
      version: _databaseVersion,
      onCreate: _onCreate,
    );
  }

  // Código SQL para criar o banco de dados e a tabela
  Future _onCreate(Database db, int version) async {
    await db.execute('''
          CREATE TABLE $table (
            $columnId INTEGER PRIMARY KEY,
            $columnNome TEXT NOT NULL,
            $columnEmail TEXT NOT NULL
          )
          ''');
  }

  Future<int> insert(Map<String, dynamic> body) async {
    Database db = await instance.database;
    return await db.insert(table, body);
  }

  Future getUser({int id}) async {
    Database db = await instance.database;
    var response = await db.query(
      'user',
    );
    User user = User.fromJson(response.first);
    return user;
  }

  Future<int> queryRowCount() async {
    Database db = await instance.database;
    return Sqflite.firstIntValue(
        await db.rawQuery('SELECT COUNT(*) FROM $table'));
  }

  Future<int> update(Map<String, dynamic> row) async {
    Database db = await instance.database;
    int id = row[columnId];
    return await db.update(table, row, where: '$columnId = ?', whereArgs: [id]);
  }

  Future<int> delete(int id) async {
    Database db = await instance.database;
    return await db.delete(table, where: '$columnId = ?', whereArgs: [id]);
  }

  Future<dynamic> deleteDB() async {
    Database db = await instance.database;
    await db.delete(table);
  }
}
