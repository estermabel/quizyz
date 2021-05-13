import 'package:flutter/material.dart';
import 'package:quizyz/pages/splash_page.dart';
import 'package:quizyz/utils/style/themes/base_theme.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Quizys',
      debugShowCheckedModeBanner: false,
      theme: baseTheme,
      home: SplashPage(),
    );
  }
}
