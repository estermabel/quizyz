import 'package:flutter/material.dart';
import 'package:quizyz/utils/style/colors.dart';
import 'package:quizyz/utils/style/themes/base_theme.dart';

class QuizyzAppBar extends StatefulWidget {
  final String title;
  final Widget leading;

  const QuizyzAppBar({Key key, @required this.title, this.leading})
      : super(key: key);

  @override
  _QuizyzAppBarState createState() => _QuizyzAppBarState();
}

class _QuizyzAppBarState extends State<QuizyzAppBar> {
  @override
  Widget build(BuildContext context) {
    return AppBar(
      centerTitle: true,
      title: Text(
        widget.title,
        style: baseTheme.textTheme.headline1.copyWith(color: accentColor),
      ),
      leading: widget.leading != null ? widget.leading : Container(),
    );
  }
}
