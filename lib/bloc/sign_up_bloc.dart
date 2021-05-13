import 'dart:async';

import 'package:flutter/material.dart';
import 'package:quizyz/model/User.dart';
import 'package:quizyz/service/config/api_service.dart';
import 'package:quizyz/service/config/base_response.dart';
import 'package:quizyz/service/sign_up_service.dart';

class SignUpBloc {
  SignUpService _service;

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  //Controllers de edição de texto
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController senhaController = TextEditingController();
  TextEditingController confirmSenhaController = TextEditingController();

  StreamController<BaseResponse<User>> _signUpController = StreamController();
  Stream<BaseResponse<User>> get signUpStream => _signUpController.stream;
  Sink<BaseResponse<User>> get signUpSink => _signUpController.sink;

  SignUpBloc() {
    _service = SignUpService(APIService());
  }

  doSignUp() async {
    try {
      signUpSink.add(BaseResponse.loading());
      var response = await _service.doSignUp(body: {
        "nome": nameController.text,
        "email": emailController.text,
        "senha": senhaController.text
      });
      signUpSink.add(BaseResponse.completed(data: response));
    } catch (e) {
      signUpSink.add(BaseResponse.error(e.toString()));
    }
  }

  dispose() {
    _signUpController.close();
  }
}
