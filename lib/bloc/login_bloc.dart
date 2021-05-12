import 'dart:async';

import 'package:flutter/material.dart';
import 'package:quizyz/service/config/base_response.dart';
import 'package:quizyz/utils/config/custom_shared_preferences.dart';

class LoginBloc {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  TextEditingController emailController = TextEditingController();
  TextEditingController senhaController = TextEditingController();
  StreamController<BaseResponse> _doLoginController = StreamController();

  Stream get loginStream => _doLoginController.stream;
  Sink get loginSink => _doLoginController.sink;

  doLogin() async {
    try {
      loginSink.add(BaseResponse.loading());
      //var response = await _service.doLogin();
      await CustomSharedPreferences.saveUsuario(true);
      loginSink.add(BaseResponse.completed());
    } catch (e) {
      loginSink.add(BaseResponse.error(e.toString()));
    }
  }

  dispose() {
    _doLoginController.close();
  }
}
