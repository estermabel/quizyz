import 'package:bubble_bottom_bar/bubble_bottom_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:quizyz/utils/style/colors.dart';

BubbleBottomBarItem bottomNavBarItem({
  BuildContext context,
  IconData icon,
  String tag,
  Color color,
  bool isSvg,
  String svgPath,
}) {
  return BubbleBottomBarItem(
    backgroundColor: color,
    icon: isSvg
        ? SvgPicture.asset(svgPath)
        : IconTheme(
            data: Theme.of(context).iconTheme.copyWith(color: whiteColor),
            child: Icon(icon),
          ),
    activeIcon: isSvg
        ? SvgPicture.asset(svgPath)
        : IconTheme(
            data: Theme.of(context).iconTheme.copyWith(color: whiteColor),
            child: Icon(icon),
          ),
    title: Text(
      tag,
      style: Theme.of(context).textTheme.button,
    ),
  );
}
