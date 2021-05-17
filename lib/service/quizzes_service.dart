import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:quizyz/db/data_base_helper.dart';
import 'package:quizyz/model/Quiz.dart';
import 'package:quizyz/model/User.dart';
import 'package:quizyz/service/config/api_service.dart';
import 'package:quizyz/utils/config/custom_shared_preferences.dart';

import '../model/Quiz.dart';
import '../model/Quiz.dart';

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

  Future getQuizzes({int userId}) async {
    final response = await _service.doRequest(
      RequestConfig(
        '/usuarios/exibir_todos_os_quizes_pelo_id_criador/$userId',
        HttpMethod.get,
      ),
    );
    List<Quiz> _quizzes =
        (response as List).map((e) => Quiz.fromJson(e)).toList();
    return _quizzes;
  }

  Future getQuizById({int cod}) async {
    final response = await _service.doRequest(
      RequestConfig(
        'mostrar/$cod',
        HttpMethod.get,
      ),
    );
    var _results = Quiz.fromJson(response);
    return _results;
  }

  Future createQuiz({@required Quiz quiz}) async {
    var _results;
    await CustomSharedPreferences.readId().then((id) async {
      final response = await _service.doRequest(
        RequestConfig(
          'usuarios/criar_quiz/$id',
          HttpMethod.post,
          body: quizBody(quiz: quiz),
        ),
      );
      _results = Quiz.fromJson(response);
    });

    return _results;
  }

  Future deleteQuiz({@required Quiz quiz}) async {
    int id = quiz.id;
    final response = await _service.doRequest(
      RequestConfig(
        'quizzes/delete/$id',
        HttpMethod.delete,
      ),
    );
    return jsonDecode(response.toString());
  }

  /// LOCAL DB

  void insertQuizDB({@required Quiz quiz}) async {
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

  void updateQuizDB({@required Quiz quiz}) async {
    var body = {
      DatabaseHelper.columnId: quiz.id,
      DatabaseHelper.columnTitulo: quiz.titulo,
      DatabaseHelper.columnQPerguntas: quiz.perguntas.length
    };
    final rowsAffected = await dbHelper.update(body);
    debugPrint("updated $rowsAffected row(s).");
  }

  void deleteQuizDB({@required int id}) async {
    await dbHelper.delete(id);
    debugPrint('deleted quiz $id.');
  }

  void deleteDB() async {
    await dbHelper.deleteDB();
    debugPrint('DB deleted.');
  }

  /// CREATE BODY
  Map<String, dynamic> quizBody({@required Quiz quiz}) {
    var body = {
      "titulo": quiz.titulo,
      "perguntas": jsonEncode(quiz.perguntas),
    };
    return body;
  }
}
