import 'dart:async';

import 'package:quizyz/model/Quiz.dart';
import 'package:quizyz/model/User.dart';
import 'package:quizyz/service/config/api_service.dart';
import 'package:quizyz/service/config/base_response.dart';
import 'package:quizyz/service/quizzes_service.dart';

class QuizzesBloc {
  QuizzesService _service;

  StreamController<BaseResponse<User>> _userController;
  Stream<BaseResponse<User>> get userStream => _userController.stream;
  Sink<BaseResponse<User>> get userSink => _userController.sink;

  StreamController<BaseResponse<List<Quiz>>> _quizzesController;
  Stream<BaseResponse<List<Quiz>>> get quizzesStream =>
      _quizzesController.stream;
  Sink<BaseResponse<List<Quiz>>> get quizzesSink => _quizzesController.sink;

  QuizzesBloc() {
    _service = QuizzesService(APIService());
    _userController = StreamController.broadcast();
    _quizzesController = StreamController.broadcast();
  }

  getUser() async {
    try {
      userSink.add(BaseResponse.loading());
      var response = await _service.getUser();
      userSink.add(BaseResponse.completed(data: response));
    } catch (e) {
      userSink.add(BaseResponse.error(e.response.data["error"]));
    }
  }

  getQuizzes() async {
    try {
      quizzesSink.add(BaseResponse.loading());
      //TODO fazer captura da API
    } catch (e) {
      try {
        quizzesSink.add(BaseResponse.loading());
        var response = await _service.getQuizzesDB();
        quizzesSink.add(BaseResponse.completed(data: response));
      } catch (a) {
        quizzesSink.add(BaseResponse.error(a.toString()));
      }
      quizzesSink.add(BaseResponse.error(e.toString()));
    }
  }

  deleteDB() {
    _service.deleteDB();
  }

  dispose() {
    _userController.close();
    _quizzesController.close();
  }
}
