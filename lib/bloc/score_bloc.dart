import 'dart:async';

import 'package:flutter/material.dart';
import 'package:quizyz/db/score_db.dart';
import 'package:quizyz/model/ScoreQuiz.dart';
import 'package:quizyz/service/config/base_response.dart';

class ScoreBloc {
  ScoreDb _scoreDb;
  List<Widget> scoreQuizzesList = [];
  StreamController<BaseResponse<List<ScoreQuiz>>> _scoreController;
  Stream<BaseResponse<List<ScoreQuiz>>> get scoreStream =>
      _scoreController.stream;
  Sink<BaseResponse<List<ScoreQuiz>>> get scoreSink => _scoreController.sink;

  StreamController<BaseResponse> _insertQuizController;
  Stream<BaseResponse> get insertQuizStream => _insertQuizController.stream;
  Sink<BaseResponse> get insertQuizSink => _insertQuizController.sink;

  ScoreBloc() {
    _scoreController = StreamController.broadcast();
    _insertQuizController = StreamController.broadcast();
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

  Future insertQuiz({ScoreQuiz quiz}) async {
    try {
      insertQuizSink.add(BaseResponse.loading());
      await _scoreDb.addQuizToDB(quiz: quiz);
      insertQuizSink.add(BaseResponse.completed());
    } catch (e) {
      insertQuizSink.add(BaseResponse.error(e.toString()));
    }
  }

  dispose() {
    _scoreController.close();
    _insertQuizController.close();
  }
}
