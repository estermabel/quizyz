import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:quizyz/utils/config/custom_shared_preferences.dart';
import 'package:quizyz/utils/style/colors.dart';

import '../../login_page.dart';

class QuizzesPage extends StatefulWidget {
  @override
  _QuizzesPageState createState() => _QuizzesPageState();
}

class _QuizzesPageState extends State<QuizzesPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Meus Quizzes",
          style: Theme.of(context)
              .textTheme
              .headline5
              .copyWith(color: accentColor),
        ),
        actions: [
          GestureDetector(
            onTap: () {
              CustomSharedPreferences.saveUsuario(false);
              CustomSharedPreferences.saveId(0);
              Navigator.of(context).pushAndRemoveUntil(
                CupertinoPageRoute(
                  builder: (context) => LoginPage(),
                ),
                (route) => false,
              );
            },
            child: Padding(
              padding: const EdgeInsets.only(right: 16),
              child: IconTheme(
                data: Theme.of(context).iconTheme.copyWith(
                      color: accentColor,
                    ),
                child: Icon(
                  Icons.exit_to_app_rounded,
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
