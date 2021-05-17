import 'package:flutter/material.dart';
import 'package:quizyz/db/data_base_helper.dart';
import 'package:quizyz/model/Quiz.dart';
import 'package:quizyz/model/User.dart';
import 'package:quizyz/service/config/api_service.dart';
import 'package:quizyz/utils/config/custom_shared_preferences.dart';

class QuizzesService {
  final APIService _service;
  final dbHelper = DatabaseHelper.instance;

  QuizzesService(this._service);

  /// API

  Future getUser() async {
    var _results;
    await CustomSharedPreferences.readId().then((id) async {
      final response = await _service
          .doRequest(RequestConfig('usuarios/mostrar/$id', HttpMethod.get));
      _results = User.fromJson(response);
    });
    return _results;
  }

  /// LOCAL DB

  void insertQuizDB({Quiz quiz}) async {
    var body = {
      DatabaseHelper.columnId: quiz.id,
      DatabaseHelper.columnTitulo: quiz.titulo,
      DatabaseHelper.columnQPerguntas: quiz.perguntas.length
    };
    int id = await dbHelper.insert(body);
    debugPrint("created quiz $id.");
  }

  Future<List<Quiz>> getQuizzesDB() async {
    final response = await dbHelper.queryAllRows();
    List<Quiz> quizzes = response.map((e) => Quiz.fromJson(e)).toList();
    return quizzes;
  }

  void updateQuiz({Quiz quiz}) async {
    var body = {
      DatabaseHelper.columnId: quiz.id,
      DatabaseHelper.columnTitulo: quiz.titulo,
      DatabaseHelper.columnQPerguntas: quiz.perguntas.length
    };
    final rowsAffected = await dbHelper.update(body);
    debugPrint("updated $rowsAffected row(s).");
  }

  void deleteQuizDB({int id}) async {
    await dbHelper.delete(id);
    debugPrint('deleted quiz $id.');
  }

  void deleteDB() async {
    await dbHelper.deleteDB();
    debugPrint('DB deleted.');
  }
}
