import 'dart:async';

import 'package:flutter/material.dart';
import 'package:quizyz/model/Quiz.dart';
import 'package:quizyz/service/config/api_service.dart';
import 'package:quizyz/service/config/base_response.dart';
import 'package:quizyz/service/quizzes_service.dart';

class CreateQuizBloc {
  TextEditingController tituloController;
  StreamController<BaseResponse<Quiz>> _createQuizController;
  Stream<BaseResponse<Quiz>> get createQuizStream =>
      _createQuizController.stream;

  Sink<BaseResponse<Quiz>> get createQuizSink => _createQuizController.sink;

  QuizzesService _service;

  CreateQuizBloc() {
    tituloController = TextEditingController();
    _createQuizController = StreamController();
    _service = QuizzesService(APIService());
  }

  Future<void> createQuiz({Quiz quiz}) async {
    try {
      createQuizSink.add(BaseResponse.loading());
      var response = await _service.createQuiz(quiz: quiz);
      createQuizSink.add(BaseResponse.completed(data: response));
    } catch (e) {
      createQuizSink.add(
        BaseResponse.error(
          e.toString(),
        ),
      );
    }
  }

  void dispose() {
    _createQuizController.close();
  }
}
