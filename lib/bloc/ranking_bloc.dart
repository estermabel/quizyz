import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:quizyz/model/Jogador.dart';
import 'package:quizyz/model/Quiz.dart';
import 'package:quizyz/service/config/base_response.dart';

class RankingBloc {
  StreamController<BaseResponse<List<Jogador>>> _rankingController;
  Stream<BaseResponse<List<Jogador>>> get jogadorStream =>
      _rankingController.stream;
  Sink<BaseResponse<List<Jogador>>> get jogadorSink => _rankingController.sink;
}
