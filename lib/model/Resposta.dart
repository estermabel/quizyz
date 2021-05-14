class Resposta {
  String titulo;
  bool resposta;

  Resposta({this.titulo, this.resposta});

  Resposta.fromJson(Map<String, dynamic> json) {
    titulo = json['titulo'];
    resposta = json['resposta'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['titulo'] = this.titulo;
    data['resposta'] = this.resposta;
    return data;
  }
}
