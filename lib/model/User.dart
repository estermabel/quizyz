class User {
  int id;
  String nome;
  String email;
  String senha;
  //List<int> quizzesJogados;

  User({
    this.id,
    this.nome,
    this.email,
    this.senha,
    //this.quizzesJogados,
  });

  User.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    nome = json['nome'];
    email = json['email'];
    senha = json['senha'];

    //quizzesJogados = json['quizzesJogados'].cast<int>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['nome'] = this.nome;
    data['email'] = this.email;
    data['senha'] = this.senha;

    //data['quizzesJogados'] = this.quizzesJogados;
    return data;
  }
}
