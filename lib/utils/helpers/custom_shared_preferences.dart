import 'package:shared_preferences/shared_preferences.dart';

const kUsuarioLogin = "isLoged";

class CustomSharedPreferences {
  //Salva se o usuário está ou não logado
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
}
