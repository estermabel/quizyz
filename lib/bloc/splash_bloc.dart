import 'dart:async';

import 'package:flutter/material.dart';
import 'package:quizyz/utils/config/custom_shared_preferences.dart';

class SplashBloc {
  final StreamController<bool> _splashController = StreamController();
  Stream<bool> get splashStream => _splashController.stream;
  Sink<bool> get splashSink => _splashController.sink;

  Future getUsuarioLogin() async {
    await CustomSharedPreferences.readUsuario().then((response) async {
      splashSink.add(response);
    });
  }

  dispose() {
    _splashController.close();
  }
}
