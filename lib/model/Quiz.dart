import 'Jogador.dart';
import 'Pergunta.dart';
import 'User.dart';

class Quiz {
  String titulo;
  User criador;
  int id;
  List<Pergunta> perguntas;
  List<Jogador> jogadores;

  Quiz({
    this.titulo,
    this.criador,
    this.id,
    this.perguntas,
    this.jogadores,
  });

  Quiz.fromJson(Map<String, dynamic> json) {
    titulo = json['titulo'];
    criador =
        json['criador'] != null ? new User.fromJson(json['criador']) : null;
    id = json['id'];
    if (json['perguntas'] != null) {
      perguntas = [];
      json['perguntas'].forEach((v) {
        perguntas.add(new Pergunta.fromJson(v));
      });
    }
    if (json['jogadores'] != null) {
      jogadores = [];
      json['jogadores'].forEach((v) {
        jogadores.add(new Jogador.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['titulo'] = this.titulo;
    if (this.criador != null) {
      data['criador'] = this.criador.toJson();
    }
    data['id'] = this.id;
    if (this.perguntas != null) {
      data['perguntas'] = this.perguntas.map((v) => v.toJson()).toList();
    }
    if (this.jogadores != null) {
      data['jogadores'] = this.jogadores.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
