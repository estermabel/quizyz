import 'dart:async';

import 'package:flutter/material.dart';
import 'package:quizyz/model/Quiz.dart';
import 'package:quizyz/service/config/base_response.dart';

class ScoreBloc {
  List<Widget> scoreQuizzesList = [];
  StreamController<BaseResponse<List<Quiz>>> _scoreController;
  Stream<BaseResponse<List<Quiz>>> get scoreStream => _scoreController.stream;
  Sink<BaseResponse<List<Quiz>>> get scoreSink => _scoreController.sink;

  ScoreBloc() {
    _scoreController = StreamController.broadcast();
  }

  getScore() async {
    scoreSink.add(BaseResponse.completed());
  }

  dispose() {
    _scoreController.close();
  }
}
