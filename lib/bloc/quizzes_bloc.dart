import 'dart:async';

import 'package:flutter/material.dart';
import 'package:quizyz/model/Quiz.dart';
import 'package:quizyz/model/User.dart';
import 'package:quizyz/service/config/api_service.dart';
import 'package:quizyz/service/config/base_response.dart';
import 'package:quizyz/service/login_service.dart';
import 'package:quizyz/service/quizzes_service.dart';
import 'package:quizyz/utils/config/custom_shared_preferences.dart';

class QuizzesBloc {
  QuizzesService _service;
  LoginService _loginService;
  List<Widget> meusQuizzesList = [];

  StreamController<BaseResponse<User>> _userController;
  Stream<BaseResponse<User>> get userStream => _userController.stream;
  Sink<BaseResponse<User>> get userSink => _userController.sink;

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

  getUser() async {
    try {
      userSink.add(BaseResponse.loading());
      User response = await _service.getUser();
      userSink.add(BaseResponse.completed(data: response));
    } catch (e) {
      try {
        userSink.add(BaseResponse.error(e.response.data["error"]));
      } catch (e) {
        userSink.add(BaseResponse.error("Sem conexão com a internet!"));
      }
    }
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
