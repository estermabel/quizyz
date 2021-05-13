class LoginAuth {
  int id;
  String email;
  String nomeCompleto;

  LoginAuth({this.id, this.email, this.nomeCompleto});

  LoginAuth.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    email = json['email'];
    nomeCompleto = json['nomeCompleto'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['email'] = this.email;
    data['nomeCompleto'] = this.nomeCompleto;
    return data;
  }
}
