import 'dart:async';

import 'package:flutter/material.dart';
import 'package:quizyz/model/Quiz.dart';
import 'package:quizyz/service/config/api_service.dart';
import 'package:quizyz/service/config/base_response.dart';
import 'package:quizyz/service/login_service.dart';
import 'package:quizyz/service/quizzes_service.dart';
import 'package:quizyz/utils/config/custom_shared_preferences.dart';

class QuizzesBloc {
  QuizzesService _service;
  LoginService _loginService;
  List<Widget> meusQuizzesList = [];

  StreamController<String> _userController;
  Stream<String> get userStream => _userController.stream;
  Sink<String> get userSink => _userController.sink;

  StreamController<BaseResponse<List<Quiz>>> _quizzesController;
  Stream<BaseResponse<List<Quiz>>> get quizzesStream =>
      _quizzesController.stream;
  Sink<BaseResponse<List<Quiz>>> get quizzesSink => _quizzesController.sink;

  QuizzesBloc() {
    _service = QuizzesService(APIService());
    _loginService = LoginService(APIService());
    _userController = StreamController.broadcast();
    _quizzesController = StreamController.broadcast();
  }

  Future getUser() async {
    await CustomSharedPreferences.readNomeUsuario().then((response) async {
      userSink.add(response);
    });
  }

  getQuizzes() async {
    int id = await CustomSharedPreferences.readId();
    quizzesSink.add(BaseResponse.loading());
    try {
      var response = await _service.getQuizzes(userId: id);
      quizzesSink.add(BaseResponse.completed(data: response));
    } catch (e) {
      quizzesSink.add(BaseResponse.error(e.toString()));
    }
  }

  deleteDB() {
    _loginService.deleteDB();
  }

  dispose() {
    _userController.close();
    _quizzesController.close();
  }
}
