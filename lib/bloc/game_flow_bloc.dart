import 'dart:developer' as developer;
import 'dart:async';

import 'package:quizyz/model/Jogador.dart';
import 'package:quizyz/service/config/api_service.dart';
import 'package:quizyz/service/config/base_response.dart';
import 'package:quizyz/service/game_service.dart';

class GameFlowBloc {
  GameService _service;
  StreamController<BaseResponse<String>> _gameController;
  Stream<BaseResponse<String>> get gameStream => _gameController.stream;
  Sink<BaseResponse<String>> get gameSink => _gameController.sink;

  GameFlowBloc() {
    _service = GameService(APIService());
    _gameController = StreamController();
  }

  Future<void> addJogador({Jogador jogador}) async {
    try {
      gameSink.add(BaseResponse.loading());
      var response = await _service.createJogador(jogador: jogador);
      gameSink.add(BaseResponse.completed(data: response));
    } catch (e, stackTrace) {
      developer.log(stackTrace.toString(), name: "Quizyz");
      gameSink.add(BaseResponse.error(e.toString()));
    }
  }

  void dispose() {
    _gameController.close();
  }
}
