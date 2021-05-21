import 'package:flutter/material.dart';
import 'package:quizyz/utils/style/colors.dart';
import 'package:quizyz/utils/style/text_size.dart';

class PurpleButton extends StatelessWidget {
  final String titulo;
  final Function onTap;
  const PurpleButton({
    Key key,
    this.titulo,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 60,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          border: Border.all(color: purpleColor),
        ),
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              titulo,
              style: Theme.of(context).textTheme.headline1.copyWith(
                    color: purpleColor,
                    fontSize: TextSize.large,
                  ),
            ),
          ),
        ),
      ),
    );
  }
}
