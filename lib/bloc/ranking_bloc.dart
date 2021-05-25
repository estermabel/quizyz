import 'dart:async';
import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:quizyz/model/Jogador.dart';
import 'package:quizyz/model/Quiz.dart';
import 'package:quizyz/service/config/api_service.dart';
import 'package:quizyz/service/config/base_response.dart';
import 'package:quizyz/service/game_service.dart';
import 'package:quizyz/service/quizzes_service.dart';

class RankingBloc {
  GameService _service;
  QuizzesService _quizzesService;
  List<Jogador> jogadoresList = [];

  StreamController<BaseResponse<List<Jogador>>> _rankingController;
  Stream<BaseResponse<List<Jogador>>> get jogadoresStream =>
      _rankingController.stream;
  Sink<BaseResponse<List<Jogador>>> get jogadoresSink =>
      _rankingController.sink;
  StreamController<BaseResponse<String>> _quizController;
  Stream<BaseResponse<String>> get quizStream => _quizController.stream;
  Sink<BaseResponse<String>> get quizSink => _quizController.sink;

  RankingBloc() {
    _service = GameService(APIService());
    _quizzesService = QuizzesService(APIService());
    _rankingController = StreamController.broadcast();
    _quizController = StreamController.broadcast();
  }

  Future getJogadoresQuiz({int cod}) async {
    try {
      jogadoresSink.add(BaseResponse.loading());
      List<Jogador> response = await _service.getJogadoresFromQuiz(cod: cod);
      jogadoresSink.add(BaseResponse.completed(data: response));
    } catch (e) {
      jogadoresSink.add(BaseResponse.error(e.toString()));
    }
  }

  Future deleteQuiz({int cod}) async {
    try {
      quizSink.add(BaseResponse.loading());
      var response = await _quizzesService.deleteQuiz(id: cod);
      quizSink.add(BaseResponse.completed(data: response));
    } catch (e) {
      quizSink.add(BaseResponse.error(e.toString()));
    }
  }

  dispose() {
    _rankingController.close();
    _quizController.close();
  }
}
