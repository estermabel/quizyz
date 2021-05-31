import 'dart:async';

import 'package:quizyz/bloc/score_bloc.dart';
import 'package:quizyz/model/Jogador.dart';
import 'package:quizyz/model/Quiz.dart';
import 'package:quizyz/model/ScoreQuiz.dart';
import 'package:quizyz/service/config/api_service.dart';
import 'package:quizyz/service/config/base_response.dart';
import 'package:quizyz/service/game_service.dart';

class GameFlowBloc {
  GameService _service;
  ScoreBloc _scoreBloc;
  ScoreQuiz scoreQuiz;
  StreamController<BaseResponse<String>> _gameController;
  Stream<BaseResponse<String>> get gameStream => _gameController.stream;
  Sink<BaseResponse<String>> get gameSink => _gameController.sink;

  GameFlowBloc() {
    _service = GameService(APIService());
    _scoreBloc = ScoreBloc();
    _gameController = StreamController();
  }

  Future<void> addJogador({Jogador jogador, Quiz quiz}) async {
    scoreQuiz = _createScoreQuiz(quiz: quiz, jogador: jogador);
    try {
      gameSink.add(BaseResponse.loading());
      var response =
          await _service.createJogador(jogador: jogador, quizId: quiz.id);
      if (response == "Jogador Adicionado ao Quiz com Sucesso!") {
        await _scoreBloc.insertQuiz(quiz: scoreQuiz);
      }
      gameSink.add(BaseResponse.completed(data: response));
    } catch (e) {
      if (e.source == "Jogador Adicionado ao Quiz com Sucesso!") {
        gameSink.add(BaseResponse.completed());
      } else {
        gameSink.add(BaseResponse.error(e.source));
      }
    }
  }

  ScoreQuiz _createScoreQuiz({Quiz quiz, Jogador jogador}) {
    return ScoreQuiz(
      codigo: quiz.id,
      criador: quiz.criador.nome,
      titulo: quiz.titulo,
      totalPerguntas: quiz.perguntas.length,
      pontos: jogador.pontuacao,
    );
  }

  void dispose() {
    _gameController.close();
  }
}
