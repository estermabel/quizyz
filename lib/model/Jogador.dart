class Jogador {
  int id;
  String nome;
  int pontuacao;

  Jogador({this.id, this.nome, this.pontuacao});

  Jogador.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    nome = json['nome'];
    pontuacao = json['pontuacao'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['nome'] = this.nome;
    data['pontuacao'] = this.pontuacao;
    return data;
  }
}
