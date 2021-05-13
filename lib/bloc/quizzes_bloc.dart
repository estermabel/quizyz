import 'dart:async';

import 'package:quizyz/model/User.dart';
import 'package:quizyz/service/config/api_service.dart';
import 'package:quizyz/service/config/base_response.dart';
import 'package:quizyz/service/quizzes_service.dart';

class QuizzesBloc {
  QuizzesService _service;

  StreamController<BaseResponse<User>> _userController;
  Stream<BaseResponse<User>> get userStream => _userController.stream;
  Sink<BaseResponse<User>> get userSink => _userController.sink;

  QuizzesBloc() {
    _service = QuizzesService(APIService());
    _userController = StreamController.broadcast();
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

  dispose() {
    _userController.close();
  }
}
