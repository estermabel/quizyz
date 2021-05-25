import 'dart:convert';

import 'package:quizyz/model/Jogador.dart';
import 'package:quizyz/model/User.dart';
import 'package:quizyz/service/config/api_service.dart';
import 'package:quizyz/utils/config/custom_shared_preferences.dart';

class GameService {
  final APIService _service;

  GameService(this._service);

  Future createJogador({Jogador jogador}) async {
    var _results;
    await CustomSharedPreferences.readId().then(
      (id) async {
        final response = await _service.doRequest(
          RequestConfig(
            'quizzes/adicionar_jogador/$id',
            HttpMethod.post,
            body: {
              "nome": jogador.nome,
              "pontuacao": jogador.pontuacao,
            },
          ),
        );
        _results = json.decode(response);
      },
    );
    return _results;
  }

  Future getJogadoresFromQuiz({int cod}) async {
    final response = await _service.doRequest(
      RequestConfig(
        'quizzes/mostrar_jogadores/$cod',
        HttpMethod.get,
      ),
    );
    List<Jogador> _jogadores =
        (response as List).map((e) => Jogador.fromJson(e)).toList();
    return _jogadores;
  }
}
