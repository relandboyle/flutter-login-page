import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

ThemeData lightTheme = ThemeData(
  useMaterial3: true,
  colorScheme: const ColorScheme.light(
    brightness: Brightness.dark,
    primary: Color.fromRGBO(111, 155, 188, 1),
    onPrimary: Color.fromRGBO(58, 83, 102, 1),
    primaryContainer: Color.fromRGBO(108, 130, 148, 1),
    onPrimaryContainer: Color.fromRGBO(34, 48, 59, 1),
    inversePrimary: Color.fromRGBO(53, 76, 93, 1),
    secondary: Color.fromRGBO(214, 204, 154, 1),
    onSecondary: Color.fromRGBO(104, 99, 75, 1),
    secondaryContainer: Color.fromRGBO(138, 131, 99, 1),
    onSecondaryContainer: Color.fromRGBO(70, 66, 50, 1),
    tertiary: Color.fromRGBO(102, 14, 9, 1),
    onTertiary: Color.fromRGBO(133, 18, 12, 1),
    tertiaryContainer: Color.fromRGBO(54, 7, 5, 1),
    onTertiaryContainer: Color.fromRGBO(79, 11, 7, 1),
    background: Color.fromRGBO(201, 201, 201, 1),
  ),
  textTheme: textTheme,
);

ThemeData darkTheme = ThemeData(
  useMaterial3: true,
  colorScheme: const ColorScheme.dark(
    brightness: Brightness.dark,
    primary: Color.fromRGBO(27, 71, 111, 1),
    onPrimary: Color.fromRGBO(116, 177, 233, 1),
    primaryContainer: Color.fromRGBO(12, 34, 54, 1),
    onPrimaryContainer: Color.fromARGB(255, 21, 60, 97),
    inversePrimary: Color.fromRGBO(35, 82, 126, 0.1),
    secondary: Color.fromRGBO(96, 92, 83, 1),
    onSecondary: Color.fromRGBO(165, 157, 142, 1),
    secondaryContainer: Color.fromRGBO(54, 52, 47, 1),
    onSecondaryContainer: Color.fromRGBO(150, 143, 129, 1),
    tertiary: Color.fromRGBO(102, 14, 9, 1),
    onTertiary: Color.fromRGBO(133, 18, 12, 1),
    tertiaryContainer: Color.fromRGBO(54, 7, 5, 1),
    onTertiaryContainer: Color.fromRGBO(79, 11, 7, 1),
    background: Color.fromRGBO(39, 53, 66, 1),
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
    fontSize: 14,
  ),
  displaySmall: GoogleFonts.pacifico(),
);
