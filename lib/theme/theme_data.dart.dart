import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class HeatSyncTheme {
  final lightTheme = ThemeData(
    useMaterial3: true,
    primarySwatch: Colors.red,
    colorScheme: ColorScheme.fromSeed(
      brightness: Brightness.light,
      seedColor: Colors.blueGrey,
      background: Colors.grey.shade200,
    ),
    textTheme: TextTheme(
      displayLarge: const TextStyle(
        fontSize: 72,
        fontWeight: FontWeight.bold,
      ),
      // ···
      titleLarge: GoogleFonts.spaceGrotesk(
        fontSize: 30,
        fontStyle: FontStyle.normal,
      ),
      bodyMedium: GoogleFonts.openSans(
        fontSize: 20,
      ),
      displaySmall: GoogleFonts.pacifico(),
    ),
  );

  final darkTheme = ThemeData(
    useMaterial3: true,
    colorScheme: ColorScheme.dark(
      brightness: Brightness.dark,
      primary: Colors.grey,
      background: Colors.grey.shade800,
    ),
    textTheme: TextTheme(
      displayLarge: const TextStyle(
        fontSize: 72,
        fontWeight: FontWeight.bold,
      ),
      // ···
      titleLarge: GoogleFonts.spaceGrotesk(
        fontSize: 30,
        fontStyle: FontStyle.normal,
      ),
      bodyMedium: GoogleFonts.openSans(
        fontSize: 20,
      ),
      displaySmall: GoogleFonts.pacifico(),
    ),
  );
}
