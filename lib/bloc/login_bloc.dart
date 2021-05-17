import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:quizyz/model/LoginAuth.dart';
import 'package:quizyz/service/config/api_service.dart';
import 'package:quizyz/service/config/base_response.dart';
import 'package:quizyz/service/login_service.dart';
import 'package:quizyz/utils/config/custom_shared_preferences.dart';
import 'package:quizyz/utils/helpers/helpers.dart';

class LoginBloc {
  LoginService _service;

  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  TextEditingController emailController = TextEditingController();
  TextEditingController senhaController = TextEditingController();
  StreamController<BaseResponse<LoginAuth>> _doLoginController =
      StreamController();

  Stream<BaseResponse<LoginAuth>> get loginStream => _doLoginController.stream;
  Sink<BaseResponse<LoginAuth>> get loginSink => _doLoginController.sink;

  LoginBloc() {
    _service = LoginService(APIService());
  }

  doLogin() async {
    try {
      loginSink.add(BaseResponse.loading());
      var response = await _service.doLogin(
        body: {"email": emailController.text, "senha": senhaController.text},
      );
      loginSink.add(BaseResponse.completed(data: response));
      await CustomSharedPreferences.saveUsuario(true);
      await CustomSharedPreferences.saveId(response.id);
      await CustomSharedPreferences.saveNomeUsuario(response.nomeCompleto);
    } catch (e) {
      loginSink.add(BaseResponse.error(e.response.data["message"]));
    }
  }

  dispose() {
    _doLoginController.close();
  }
}
