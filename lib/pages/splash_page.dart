import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:quizyz/pages/controller_page.dart';
import 'package:quizyz/utils/style/animations/fade_animation.dart';
import 'package:quizyz/utils/style/colors.dart';

class SplashPage extends StatefulWidget {
  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    super.initState();
    //_loadData();
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
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(top: 128, bottom: 64),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Column(
                children: [
                  FadeAnimation(0.4, _image()),
                  FadeAnimation(1.4, _textTitle()),
                ],
              ),
              FadeAnimation(2.1, _textSubTitle()),
            ],
          ),
        ),
      ),
    );
  }

  Widget _image() {
    return Image.asset("images/splash_image.png");
  }

  Widget _textTitle() {
    return Padding(
      padding: const EdgeInsets.only(top: 64),
      child: Text(
        "Quizyz",
        style: Theme.of(context).textTheme.headline2.copyWith(
              color: accentColor,
              fontWeight: FontWeight.bold,
            ),
      ),
    );
  }

  Widget _textSubTitle() {
    return Padding(
      padding: const EdgeInsets.only(left: 64, right: 64),
      child: Text(
        "Ester Mabel, Alécio Barreto, Ary Sault, Yllo Luís, Michel de Jesus",
        style: Theme.of(context).textTheme.subtitle1,
        textAlign: TextAlign.center,
      ),
    );
  }
}
