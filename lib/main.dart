import 'package:flutter/material.dart';
import 'package:quizyz/db/data_base_helper.dart';
import 'package:quizyz/pages/home/game/ranking_page.dart';
import 'package:quizyz/pages/splash_page.dart';
import 'package:quizyz/utils/style/themes/base_theme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await DatabaseHelper.instance.database;
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Quizyz',
      debugShowCheckedModeBanner: false,
      theme: baseTheme,
      home: SplashPage(),
    );
  }
}
