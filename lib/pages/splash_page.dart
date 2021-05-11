import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:quizyz/pages/controller_page.dart';

class SplashPage extends StatefulWidget {
  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    super.initState();
    _loadData();
  }

  @override
  void dispose() {
    super.dispose();
  }

  _loadData() async {
    await Future.delayed(new Duration(seconds: 4));
    Navigator.of(context).pushReplacement(
      CupertinoPageRoute(
        builder: (context) => ControllerPage(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text("teste")
          // FadeAnimation(0.7, _icon()),
          // FadeAnimation(1.4, _textTitle()),
        ],
      ),
    );
  }
}
