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

  Map<String, dynamic> toJson() => {
        'id': this.id,
        'codigo': this.codigo,
        'criador': this.criador,
        'titulo': this.titulo,
        'pontos': this.pontos,
        'totalPerguntas': this.totalPerguntas,
      };
}
