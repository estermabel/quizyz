import 'package:flutter/material.dart';
import 'package:quizyz/utils/style/colors.dart';
import 'package:quizyz/utils/style/themes/base_theme.dart';
import 'package:quizyz/utils/style/text_size.dart';

class QuizyzAppButton extends StatelessWidget {
  final Function onTap;

  const QuizyzAppButton({Key key, @required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onTap(),
      child: Container(
        height: 60,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          gradient: LinearGradient(
            begin: Alignment.centerRight,
            end: Alignment.centerLeft,
            colors: [accentColor, purpleColor],
          ),
        ),
        child: Center(
          child: Text(
            "Cadastro",
            style: baseTheme.textTheme.headline1
                .copyWith(color: whiteColor, fontSize: TextSize.large),
          ),
        ),
      ),
    );
  }
}
