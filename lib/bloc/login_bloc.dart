import 'dart:async';

import 'package:flutter/material.dart';
import 'package:quizyz/service/config/api_service.dart';
import 'package:quizyz/service/config/base_response.dart';
import 'package:quizyz/service/login_service.dart';
import 'package:quizyz/utils/config/custom_shared_preferences.dart';

class LoginBloc {
  LoginService _service;

  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  TextEditingController emailController = TextEditingController();
  TextEditingController senhaController = TextEditingController();
  StreamController<BaseResponse> _doLoginController = StreamController();

  Stream get loginStream => _doLoginController.stream;
  Sink get loginSink => _doLoginController.sink;

  LoginBloc() {
    _service = LoginService(APIService());
  }

  doLogin() async {
    try {
      loginSink.add(BaseResponse.loading());
      var response = await _service.doLogin(
          body: {"email": emailController.text, "senha": senhaController.text});
      loginSink.add(BaseResponse.completed(data: response));
      await CustomSharedPreferences.saveUsuario(true);
    } catch (e) {
      loginSink.add(BaseResponse.error(e.toString()));
    }
  }

  dispose() {
    _doLoginController.close();
  }
}
