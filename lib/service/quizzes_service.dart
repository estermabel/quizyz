import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:quizyz/db/config/data_base_helper.dart';
import 'package:quizyz/model/Quiz.dart';
import 'package:quizyz/model/User.dart';
import 'package:quizyz/service/config/api_service.dart';
import 'package:quizyz/utils/config/custom_shared_preferences.dart';

import '../model/Quiz.dart';
import '../model/Quiz.dart';

class QuizzesService {
  final APIService _service;

  QuizzesService(this._service);

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
        'quizzes/mostrar/$cod',
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
          body: quiz.toJson(),
        ),
      );
      _results = Quiz.fromJson(response);
    });

    return _results;
  }

  Future deleteQuiz({@required int id}) async {
    final response = await _service.doRequest(
      RequestConfig(
        'quizzes/delete/$id',
        HttpMethod.delete,
      ),
    );
    return jsonDecode(response.toString());
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
