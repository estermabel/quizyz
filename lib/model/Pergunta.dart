import 'Resposta.dart';

class Pergunta {
  int id;
  String titulo;
  List<Resposta> respostas;

  Pergunta({this.id, this.titulo, this.respostas});

  Pergunta.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    titulo = json['titulo'];
    if (json['respostas'] != null) {
      respostas = [];
      json['respostas'].forEach((v) {
        respostas.add(new Resposta.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['titulo'] = this.titulo;
    if (this.respostas != null) {
      data['respostas'] = this.respostas.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
