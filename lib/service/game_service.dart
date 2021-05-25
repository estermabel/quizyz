import 'package:quizyz/model/Jogador.dart';
import 'package:quizyz/service/config/api_service.dart';

class GameService {
  final APIService _service;

  GameService(this._service);

  Future createJogador({Jogador jogador, int quizId}) async {
    final response = await _service.doRequest(
      RequestConfig(
        'quizzes/adicionar_jogador/$quizId',
        HttpMethod.post,
        body: {
          "nome": jogador.nome,
          "pontuacao": jogador.pontuacao,
        },
      ),
    );

    return response;
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
