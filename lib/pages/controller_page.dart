import 'package:bubble_bottom_bar/bubble_bottom_bar.dart';
import 'package:flutter/material.dart';
import 'package:quizyz/components/bottom_nav_bar_item.dart';
import 'package:quizyz/pages/home/play/play_page.dart';
import 'package:quizyz/pages/home/quizzes/quizzes_page.dart';
import 'package:quizyz/pages/home/score/score_page.dart';
import 'package:quizyz/utils/style/colors.dart';

class ControllerPage extends StatefulWidget {
  @override
  _ControllerPageState createState() => _ControllerPageState();
}

class _ControllerPageState extends State<ControllerPage> {
  int _indiceAtual = 0;
  final List<Widget> _telas = [QuizzesPage(), ScorePage(), PlayPage()];

  void onTabTapped(int index) {
    setState(() {
      _indiceAtual = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _telas[_indiceAtual],
      bottomNavigationBar: BubbleBottomBar(
        hasNotch: true,
        backgroundColor: bottomNavBarBackgroundColor,
        currentIndex: _indiceAtual,
        onTap: onTabTapped,
        opacity: 0.2,
        items: [
          bottomNavBarItem(
            context: context,
            icon: Icons.home,
            tag: "Quizzes",
            color: accentColor,
            isSvg: false,
          ),
          bottomNavBarItem(
            context: context,
            icon: Icons.home,
            tag: "Score",
            color: purpleColor,
            isSvg: true,
            svgPath: "images/icons/icon_trophy.svg",
          ),
          bottomNavBarItem(
            context: context,
            icon: Icons.home,
            tag: "Jogar",
            color: blueColor,
            isSvg: true,
            svgPath: "images/icons/icon_game.svg",
          ),
        ],
      ),
    );
  }
}
