class User {
  int id;
  String nome;
  String email;
  String senha;
  //List<dynamic> meusQuizzes;
  //List<int> quizzesJogados;

  User({
    this.id,
    this.nome,
    this.email,
    this.senha,
    //this.meusQuizzes,
    //this.quizzesJogados,
  });

  User.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    nome = json['nome'];
    email = json['email'];
    senha = json['senha'];
    // if (json['meusQuizzes'] != null) {
    //   meusQuizzes = new List<Null>();
    //   json['meusQuizzes'].forEach((v) {
    //     meusQuizzes.add(new dynamic.fromJson(v));
    //   });
    // }
    //quizzesJogados = json['quizzesJogados'].cast<int>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['nome'] = this.nome;
    data['email'] = this.email;
    data['senha'] = this.senha;
    // if (this.meusQuizzes != null) {
    //   data['meusQuizzes'] = this.meusQuizzes.map((v) => v.toJson()).toList();
    // }
    //data['quizzesJogados'] = this.quizzesJogados;
    return data;
  }
}
