import 'Jogador.dart';
import 'Pergunta.dart';
import 'User.dart';

class Quiz {
  int id;
  User criador;
  List<Pergunta> perguntas;
  List<Jogador> jogadores;
  String createdAt;
  String updatedAt;
  String titulo;

  Quiz(
      {this.id,
      this.criador,
      this.perguntas,
      this.jogadores,
      this.createdAt,
      this.updatedAt,
      this.titulo});

  Quiz.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    criador =
        json['criador'] != null ? new User.fromJson(json['criador']) : null;
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
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    titulo = json['titulo'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    if (this.criador != null) {
      data['criador'] = this.criador.toJson();
    }
    if (this.perguntas != null) {
      data['perguntas'] = this.perguntas.map((v) => v.toJson()).toList();
    }
    if (this.jogadores != null) {
      data['jogadores'] = this.jogadores.map((v) => v.toJson()).toList();
    }
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    data['titulo'] = this.titulo;
    return data;
  }

  Map<String, dynamic> toJsonPost() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.perguntas != null) {
      data['perguntas'] = this.perguntas.map((v) => v.toJsonPost()).toList();
    }
    data['titulo'] = this.titulo;
    return data;
  }
}
