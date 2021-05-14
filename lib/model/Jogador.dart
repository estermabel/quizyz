class Jogador {
  int id;
  String nome;
  int pontos;

  Jogador({this.id, this.nome, this.pontos});

  Jogador.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    nome = json['nome'];
    pontos = json['pontos'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['nome'] = this.nome;
    data['pontos'] = this.pontos;
    return data;
  }
}
