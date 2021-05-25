import 'dart:io';
import 'package:path/path.dart';
import 'package:quizyz/model/Quiz.dart';
import 'package:quizyz/model/ScoreQuiz.dart';
import 'package:quizyz/model/User.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';

class DatabaseHelper {
  static final _databaseName = "QuizDB.db";
  static final _databaseVersion = 1;
  static final table = 'score';
  static final columnId = '_id';
  static final columnCod = 'codigo';
  static final columnTitulo = 'titulo';
  static final columnPontos = 'pontos';
  static final columnTotalPerguntas = 'totalPerguntas';
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
            $columnCod INTEGER NOT NULL,
            $columnTitulo TEXT NOT NULL,
            $columnPontos INTEGER NOT NULL,
            $columnTotalPerguntas INTEGER NOT NULL
          )
          ''');
  }

  Future<ScoreQuiz> insert(ScoreQuiz quiz) async {
    Database db = await instance.database;
    quiz.id = await db.insert(table, quiz.toJson());
    return quiz;
  }

  Future<List<ScoreQuiz>> getQuizzes() async {
    Database db = await instance.database;
    List<Map> maps = await db.query(table, columns: [
      columnId,
      columnCod,
      columnTitulo,
      columnTotalPerguntas,
      columnPontos
    ]);
    List<ScoreQuiz> quizzes = [];
    if (maps.length > 0) {
      for (int i = 0; i < maps.length; i++) {
        quizzes.add(ScoreQuiz.fromJson(maps[i]));
      }
    }
    return quizzes;
  }

  Future<int> getRowCount() async {
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
