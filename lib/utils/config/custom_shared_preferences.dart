import 'package:shared_preferences/shared_preferences.dart';

const String kUsuarioLogin = "userLogin";
const String kUsuarioId = "userId";
const String kUsuarioNome = "userName";

class CustomSharedPreferences {
  static saveUsuario(value) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setBool(kUsuarioLogin, value);
  }

  //Verifica se o usuário está logado
  static readUsuario() async {
    final prefs = await SharedPreferences.getInstance();
    var result = (prefs.getBool(kUsuarioLogin) ?? false);
    return result;
  }

  //Salva o id do user
  static saveId(value) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setInt(kUsuarioId, value);
  }

  static readId() async {
    final prefs = await SharedPreferences.getInstance();
    var result = prefs.getInt(kUsuarioId);
    return result;
  }

  //Salva o nome do usuário
  static saveNomeUsuario(value) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString(kUsuarioNome, value);
  }

  //Verifica se o usuário está logado
  static readNomeUsuario() async {
    final prefs = await SharedPreferences.getInstance();
    var result = prefs.getString(kUsuarioNome);
    return result;
  }
}
