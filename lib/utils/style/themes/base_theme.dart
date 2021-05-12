import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../colors.dart';

ThemeData baseTheme = ThemeData(
  primaryColor: primaryColor,
  accentColor: accentColor,
  backgroundColor: backgroundColor,
  scaffoldBackgroundColor: backgroundColor,

  /// Sub themes
  textTheme: _textTheme,
  iconTheme: _iconTheme,
  inputDecorationTheme: _inputDecoration,
);

TextTheme _textTheme = TextTheme(
  headline1: GoogleFonts.poppins(
    color: primaryTextColor,
    fontWeight: FontWeight.w400,
  ),
  headline2: GoogleFonts.poppins(
    color: primaryTextColor,
    fontWeight: FontWeight.w400,
  ),
  headline3: GoogleFonts.poppins(
    color: primaryTextColor,
    fontWeight: FontWeight.w400,
  ),
  headline4: GoogleFonts.poppins(
    color: primaryTextColor,
    fontWeight: FontWeight.w400,
  ),
  headline5: GoogleFonts.poppins(
    color: primaryTextColor,
    fontWeight: FontWeight.w400,
  ),
  headline6: GoogleFonts.poppins(
    color: primaryTextColor,
    fontWeight: FontWeight.w400,
  ),
  bodyText1: GoogleFonts.poppins(
    color: primaryTextColor,
    fontWeight: FontWeight.w200,
  ),
  bodyText2: GoogleFonts.poppins(
    color: primaryTextColor,
    fontWeight: FontWeight.w200,
  ),
  subtitle1: GoogleFonts.poppins(
    color: primaryTextColor,
    fontWeight: FontWeight.w400,
  ),
  button: GoogleFonts.poppins(
    color: primaryColor,
    fontWeight: FontWeight.bold,
  ),
);

IconThemeData _iconTheme = IconThemeData(
  color: purpleColor,
  size: 20,
);

InputDecorationTheme _inputDecoration = InputDecorationTheme(
  hintStyle: GoogleFonts.raleway(
    color: primaryTextColor,
    fontWeight: FontWeight.w500,
  ),
  disabledBorder: OutlineInputBorder(
    borderSide: BorderSide(
      color: accentColor,
    ),
  ),
  border: OutlineInputBorder(
    borderSide: BorderSide(
      color: accentColor,
    ),
  ),
  enabledBorder: OutlineInputBorder(
    borderSide: BorderSide(
      color: greyColor,
    ),
  ),
  focusedBorder: OutlineInputBorder(
    borderSide: BorderSide(
      color: accentColor,
    ),
  ),
);
