import 'package:flutter/material.dart';
import 'package:quizyz/utils/style/colors.dart';

// ignore: must_be_immutable
class AnswerComponent extends StatelessWidget {
  bool rightAnswer = false;
  final String answer;

  AnswerComponent({this.answer});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        color: backgroundContainerColor,
        gradient: rightAnswer == true
            ? LinearGradient(
                begin: Alignment.centerRight,
                end: Alignment.centerLeft,
                colors: [purpleColor, accentColor],
              )
            : LinearGradient(
                begin: Alignment.centerRight,
                end: Alignment.centerLeft,
                colors: [backgroundContainerColor, backgroundContainerColor]),
      ),
      child: Center(
        child: Text(
          answer,
          style: Theme.of(context)
              .textTheme
              .bodyText1
              .copyWith(color: whiteColor, fontSize: 16),
        ),
      ),
    );
  }

  void setRightAnswer(bool answer) => this.rightAnswer = answer;
}
