import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

final kThemeData = ThemeData(
  visualDensity: VisualDensity.adaptivePlatformDensity,
  colorScheme: ColorScheme.fromSeed(
    seedColor: Colors.deepOrange,
    brightness: Brightness.dark,
  ),
  textTheme: GoogleFonts.poppinsTextTheme().copyWith(
    titleLarge: GoogleFonts.ubuntuCondensedTextTheme()
        .titleLarge!
        .copyWith(fontWeight: FontWeight.bold),
  ),
);
