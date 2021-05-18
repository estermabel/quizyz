import 'package:flutter/cupertino.dart';
import 'package:quizyz/utils/config/custom_shared_preferences.dart';

class PlayBloc {
  GlobalKey<FormState> formKey;
  TextEditingController codeController;
  TextEditingController nomeJogadorController;

  PlayBloc() {
    formKey = GlobalKey<FormState>();
    codeController = TextEditingController();
    nomeJogadorController = TextEditingController();
  }

  Future getUsuarioLogin() async {
    bool isLogged = false;
    await CustomSharedPreferences.readUsuario().then((response) async {
      isLogged = response;
    });
    return isLogged;
  }

  Future getUsuarioNome() async {
    String nome;
    await CustomSharedPreferences.readNomeUsuario().then((response) async {
      nome = response;
    });
    return nome;
  }
}
