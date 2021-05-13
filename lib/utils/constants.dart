import 'package:dio/dio.dart';

class Constants {
  static String kBaseUrl = "https://quizyz.herokuapp.com/";

  static String kApiKey = "";

  static Options kOptions = Options(
    headers: {},
  );

  static Map<String, dynamic> kqueryParameters = {};
}
