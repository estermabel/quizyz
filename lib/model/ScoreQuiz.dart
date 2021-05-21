class ScoreQuiz {
  int id;
  int codigo;
  String criador;
  String titulo;
  int pontos;
  int totalPerguntas;

  ScoreQuiz({
    this.id,
    this.codigo,
    this.criador,
    this.titulo,
    this.pontos,
    this.totalPerguntas,
  });

  ScoreQuiz.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    codigo = json['codigo'];
    criador = json['criador'];
    titulo = json['titulo'];
    pontos = json['pontos'];
    totalPerguntas = json['totalPerguntas'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['codigo'] = this.codigo;
    data['criador'] = this.criador;
    data['titulo'] = this.titulo;
    data['pontos'] = this.pontos;
    data['totalPerguntas'] = this.totalPerguntas;
    return data;
  }
}
