import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

const Color kRichBlack = Color(0xFF000814);
const Color kWhite = Color(0xFFfafafa);
const Color kRed = Color(0xFFcd141e);

final TextStyle title =
    GoogleFonts.marvel(fontSize: 33, fontWeight: FontWeight.w800);

final TextStyle subtitle = GoogleFonts.roboto(
    fontSize: 18, fontWeight: FontWeight.w400, letterSpacing: 0.15);

final TextStyle bodyText = GoogleFonts.roboto(
    fontSize: 13, fontWeight: FontWeight.w400, letterSpacing: 0.25);

final kTextTheme = TextTheme(
  titleMedium: title,
  titleSmall: subtitle,
  bodySmall: bodyText,
);

const kColorScheme = ColorScheme(
  brightness: Brightness.dark,
  primary: kRed,
  onPrimary: kRed,
  secondary: kWhite,
  onSecondary: kWhite,
  error: kRed,
  onError: kRed,
  background: kRichBlack,
  onBackground: kWhite,
  surface: kRichBlack,
  onSurface: kWhite,
);
