import 'package:quizyz/model/User.dart';
import 'package:quizyz/service/config/api_service.dart';

class SignUpService {
  final APIService _service;

  SignUpService(this._service);

  Future doSignUp({Map<String, dynamic> body}) async {
    final response = await _service.doRequest(
        RequestConfig('usuarios/criar', HttpMethod.post, body: body));
    var _results = User.fromJson(response);
    return _results;
  }
}
