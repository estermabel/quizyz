import 'package:flutter/material.dart';
import 'package:quizyz/db/config/data_base_helper.dart';
import 'package:quizyz/model/LoginAuth.dart';
import 'package:quizyz/service/config/api_service.dart';

class LoginService {
  final APIService _service;
  final dbHelper = DatabaseHelper.instance;

  LoginService(this._service);

  Future<dynamic> doLogin({Map<String, dynamic> body}) async {
    final response = await _service.doRequest(
        RequestConfig('usuarios/login', HttpMethod.post, body: body));
    var _results = LoginAuth.fromJson(response);
    return _results;
  }

  void deleteDB() async {
    await dbHelper.deleteDB();
    debugPrint('DB deleted.');
  }
}
