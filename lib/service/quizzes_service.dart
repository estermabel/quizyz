import 'package:quizyz/model/User.dart';
import 'package:quizyz/service/config/api_service.dart';
import 'package:quizyz/utils/config/custom_shared_preferences.dart';

class QuizzesService {
  final APIService _service;

  QuizzesService(this._service);

  Future getUser() async {
    var _results;
    await CustomSharedPreferences.readId().then((id) async {
      final response = await _service
          .doRequest(RequestConfig('usuarios/mostrar/$id', HttpMethod.get));
      _results = User.fromJson(response);
    });
    return _results;
  }
}
