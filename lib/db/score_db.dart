import 'package:flutter/material.dart';
import 'package:quizyz/db/config/data_base_helper.dart';
import 'package:quizyz/model/ScoreQuiz.dart';

class ScoreDb {
  final db = DatabaseHelper.instance;

  Future<List<ScoreQuiz>> getScoreQuizzes() async {
    final List<Map<String, dynamic>> response = await db.getAllRows();
    List<ScoreQuiz> _quizzes =
        (response).map((e) => ScoreQuiz.fromJson(e)).toList();
    return _quizzes;
  }

  Future addQuizToDB({ScoreQuiz quiz}) async {
    int response = await db.insert(quiz.toJson());
    debugPrint('Quiz $response inserido.');
  }
}
