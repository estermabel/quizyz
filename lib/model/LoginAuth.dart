class LoginAuth {
  int id;
  String email;
  String nome;

  LoginAuth({this.id, this.email, this.nome});

  LoginAuth.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    email = json['email'];
    nome = json['nome'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['email'] = this.email;
    data['nome'] = this.nome;
    return data;
  }
}
