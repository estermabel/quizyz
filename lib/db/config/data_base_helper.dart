import 'dart:io';
import 'package:flutter/material.dart';
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
  static final columnCriador = 'criador';
  static final columnTitulo = 'titulo';
  static final columnPontos = 'pontos';
  static final columnTotalPerguntas = 'totalPerguntas';
  DatabaseHelper._privateConstructor();
  static final DatabaseHelper instance = DatabaseHelper._privateConstructor();
  static Database _database;

  Future<Database> get database async {
    if (_database != null) return _database;
    _database = await _initDatabase();
    return _database;
  }

  _initDatabase() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, _databaseName);
    return await openDatabase(
      path,
      version: _databaseVersion,
      onCreate: _onCreate,
    );
  }

  Future _onCreate(Database db, int version) async {
    await db.execute('''
          CREATE TABLE $table (
            $columnId INTEGER PRIMARY KEY AUTOINCREMENT,
            $columnCod INTEGER NOT NULL,
            $columnCriador TEXT NOT NULL,
            $columnTitulo TEXT NOT NULL,
            $columnPontos INTEGER NOT NULL,
            $columnTotalPerguntas INTEGER NOT NULL
          )
          ''');
  }

  Future insert(ScoreQuiz quiz) async {
    final db = await database;
    quiz.id = await db.insert(
      table,
      quiz.toJson(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
    print(quiz.id);
  }

  Future<List<ScoreQuiz>> getQuizzes() async {
    final db = await database;
    var response = await db.query(table);

    List<ScoreQuiz> quizzes = response
        .map(
          (e) => ScoreQuiz.fromJson(e),
        )
        .toList();

    return quizzes;
  }

  Future<int> update(Map<String, dynamic> row) async {
    final db = await database;
    int id = row[columnId];
    return await db.update(table, row, where: '$columnId = ?', whereArgs: [id]);
  }

  Future<int> delete(int id) async {
    final db = await database;
    return await db.delete(table, where: '$columnId = ?', whereArgs: [id]);
  }

  Future<dynamic> deleteDB() async {
    final db = await database;
    await db.delete(table);
  }
}
