import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

ThemeData lightTheme = ThemeData(
  useMaterial3: true,
  colorScheme: ColorScheme.light(
    brightness: Brightness.light,
    primary: Colors.grey.shade400,
    secondary: Colors.grey.shade600,
    background: Colors.grey.shade300,
  ),
  textTheme: textTheme,
);

ThemeData darkTheme = ThemeData(
  useMaterial3: true,
  colorScheme: ColorScheme.dark(
    brightness: Brightness.dark,
    primary: Colors.grey.shade800,
    secondary: Colors.grey.shade600,
    background: Colors.grey.shade900,
  ),
  textTheme: textTheme,
);

TextTheme textTheme = TextTheme(
  displayLarge: const TextStyle(
    fontSize: 72,
    fontWeight: FontWeight.bold,
  ),
  titleLarge: GoogleFonts.cabin(
    fontSize: 30,
    fontStyle: FontStyle.normal,
  ),
  bodyMedium: GoogleFonts.openSans(
    fontSize: 20,
  ),
  displaySmall: GoogleFonts.pacifico(),
);
