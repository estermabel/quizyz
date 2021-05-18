import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:quizyz/utils/config/custom_shared_preferences.dart';

class PlayBloc {
  GlobalKey<FormState> formKey;
  TextEditingController codeController;
  TextEditingController nomeJogadorController;
  StreamController<bool> _isLoggedController;
  Stream<bool> get isLoggedStream => _isLoggedController.stream;
  Sink<bool> get isLoggedSink => _isLoggedController.sink;

  PlayBloc() {
    formKey = GlobalKey<FormState>();
    _isLoggedController = StreamController.broadcast();
    codeController = TextEditingController();
    nomeJogadorController = TextEditingController();
  }

  Future getUsuarioLogin() async {
    await CustomSharedPreferences.readUsuario().then((response) async {
      isLoggedSink.add(response);
    });
  }

  Future getUsuarioNome() async {
    String nome;
    await CustomSharedPreferences.readNomeUsuario().then((response) async {
      nome = response;
    });
    return nome;
  }

  dispose() {
    _isLoggedController.close();
  }
}
