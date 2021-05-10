// import 'dart:async';

// import 'package:flutter/material.dart';
// import 'package:love_calculator/model/Results.dart';
// import 'package:love_calculator/service/calculator_service.dart';
// import 'package:love_calculator/service/config/api_service.dart';
// import 'package:love_calculator/service/config/base_response.dart';

// class HomeBloc {
//   CalculatorService _calculatorService;

//   TextEditingController fname;
//   TextEditingController sname;
//   StreamController<BaseResponse<Results>> _calculatorController;

//   Stream<BaseResponse<Results>> get calculatorStream =>
//       _calculatorController.stream;
//   Sink<BaseResponse<Results>> get calculatorSink => _calculatorController.sink;
//   Results results;

//   HomeBloc() {
//     _calculatorService = CalculatorService(APIService());
//     _calculatorController = StreamController.broadcast();
//     fname = TextEditingController();
//     sname = TextEditingController();
//     results = Results();
//   }

//   getResults({@required String fname, @required String sname}) async {
//     try {
//       results = await _calculatorService.getResults(fname: fname, sname: sname);
//       calculatorSink.add(BaseResponse.completed(data: results));
//     } catch (e) {
//       debugPrint("get error = $e");
//     }
//   }

//   dispose() {
//     _calculatorController.close();
//   }
// }
