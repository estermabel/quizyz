import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:quizyz/model/Jogador.dart';
import 'package:quizyz/model/Quiz.dart';
import 'package:quizyz/service/config/api_service.dart';
import 'package:quizyz/service/config/base_response.dart';
import 'package:quizyz/service/game_service.dart';

class RankingBloc {
  GameService _service;

  StreamController<BaseResponse<List<Jogador>>> _rankingController;
  Stream<BaseResponse<List<Jogador>>> get jogadoresStream =>
      _rankingController.stream;
  Sink<BaseResponse<List<Jogador>>> get jogadoresSink =>
      _rankingController.sink;

  RankingBloc() {
    _service = GameService(APIService());
    _rankingController = StreamController.broadcast();
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

  dispose() {
    _rankingController.close();
  }
}
