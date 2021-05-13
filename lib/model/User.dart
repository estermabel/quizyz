class User {
  int id;
  String nome;
  String email;
  String senha;
  //List<dynamic> meusQuizzes;

  User({
    this.id,
    this.nome,
    this.email,
    this.senha,
    //this.meusQuizzes,
  });

  User.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    nome = json['nome'];
    email = json['email'];
    senha = json['senha'];
    // if (json['meusQuizzes'] != null) {
    //   meusQuizzes = new List<Null>();
    //   json['meusQuizzes'].forEach((v) {
    //     meusQuizzes.add(new dynmic.fromJson(v));
    //   });
    // }
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
    return data;
  }
}
