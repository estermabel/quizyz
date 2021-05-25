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

  Future<void> addJogador({Jogador jogador, int quizId}) async {
    try {
      gameSink.add(BaseResponse.loading());
      var response = await _service.createJogador(
        jogador: jogador,
        quizId: quizId,
      );
      gameSink.add(BaseResponse.completed(data: response));
    } catch (e) {
      if (e.source == "Jogador Adicionado ao Quiz com Sucesso!") {
        gameSink.add(BaseResponse.completed());
      } else {
        gameSink.add(BaseResponse.error(e.source));
      }
    }
  }

  void dispose() {
    _gameController.close();
  }
}
