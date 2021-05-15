import 'Resposta.dart';

class Pergunta {
  String titulo;
  List<Resposta> resposta;

  Pergunta({this.titulo, this.resposta});

  Pergunta.fromJson(Map<String, dynamic> json) {
    titulo = json['titulo'];
    if (json['resposta'] != null) {
      resposta = [];
      json['resposta'].forEach((v) {
        resposta.add(new Resposta.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['titulo'] = this.titulo;
    if (this.resposta != null) {
      data['resposta'] = this.resposta.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
