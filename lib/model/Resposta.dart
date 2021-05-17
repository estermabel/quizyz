class Resposta {
  int id;
  String titulo;
  bool isCerta;

  Resposta({this.id, this.titulo, this.isCerta});

  Resposta.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    titulo = json['titulo'];
    isCerta = json['isCerta'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['titulo'] = this.titulo;
    data['isCerta'] = this.isCerta;
    return data;
  }
}
