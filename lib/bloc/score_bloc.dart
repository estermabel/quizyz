import 'dart:async';

import 'package:flutter/material.dart';
import 'package:quizyz/db/score_db.dart';
import 'package:quizyz/model/Quiz.dart';
import 'package:quizyz/model/ScoreQuiz.dart';
import 'package:quizyz/service/config/base_response.dart';

class ScoreBloc {
  ScoreDb _scoreDb;
  List<Widget> scoreQuizzesList = [];
  StreamController<BaseResponse<List<ScoreQuiz>>> _scoreController;
  Stream<BaseResponse<List<ScoreQuiz>>> get scoreStream =>
      _scoreController.stream;
  Sink<BaseResponse<List<ScoreQuiz>>> get scoreSink => _scoreController.sink;

  ScoreBloc() {
    _scoreController = StreamController.broadcast();
    _scoreDb = ScoreDb();
  }

  getScore() async {
    try {
      scoreSink.add(BaseResponse.loading());
      List<ScoreQuiz> response = await _scoreDb.getScoreQuizzes();
      scoreSink.add(BaseResponse.completed(data: response));
    } catch (e) {
      scoreSink.add(BaseResponse.error(e.toString()));
    }
  }

  dispose() {
    _scoreController.close();
  }
}
