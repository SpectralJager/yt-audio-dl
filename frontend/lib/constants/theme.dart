import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

var theme = ThemeData.from(
  useMaterial3: true,
  colorScheme: const ColorScheme(
    brightness: Brightness.dark,
    // Primary
    primary: Color(0xffDAB9FF),
    onPrimary: Color(0xff470084),
    primaryContainer: Color(0xff6316AD),
    onPrimaryContainer: Color(0xffEEDBFF),
    // Secondary
    secondary: Color(0xffCFC1DA),
    onSecondary: Color(0xff362D40),
    secondaryContainer: Color(0xff4D4357),
    onSecondaryContainer: Color(0xffECDDF7),
    // Tertiary
    tertiary: Color(0xffF2B7C0),
    onTertiary: Color(0xff4B252C),
    tertiaryContainer: Color(0xff653B42),
    onTertiaryContainer: Color(0xffFFD9DE),
    // Error
    error: Color(0xffFFB4AB),
    onError: Color(0xff690005),
    errorContainer: Color(0xff93000A),
    onErrorContainer: Color(0xffFFDAD6),
    // Background
    background: Color(0xff1D1B1E),
    onBackground: Color(0xffE7E1E5),
    surface: Color(0xff1D1B1E),
    onSurface: Color(0xffE7E1E5),
  ),
  textTheme: TextTheme(
    displayLarge: GoogleFonts.oswald(
      // height: 64,
      fontSize: 57,
      fontWeight: FontWeight.w400,
    ),
    displayMedium: GoogleFonts.oswald(
      // height: 52,
      fontSize: 45,
      fontWeight: FontWeight.w400,
    ),
    displaySmall: GoogleFonts.oswald(
      // height: 44,
      fontSize: 36,
      fontWeight: FontWeight.w400,
    ),
    headlineLarge: GoogleFonts.oswald(
      // height: 40,
      fontSize: 32,
      fontWeight: FontWeight.w400,
    ),
    headlineMedium: GoogleFonts.oswald(
      // height: 36,
      fontSize: 28,
      fontWeight: FontWeight.w400,
    ),
    headlineSmall: GoogleFonts.oswald(
      // height: 32,
      fontSize: 24,
      fontWeight: FontWeight.w400,
    ),
    titleLarge: GoogleFonts.openSans(
      // height: 28,
      fontSize: 22,
      fontWeight: FontWeight.w400,
    ),
    titleMedium: GoogleFonts.openSans(
      // height: 24,
      fontSize: 16,
      fontWeight: FontWeight.w500,
    ),
    titleSmall: GoogleFonts.openSans(
      // height: 20,
      fontSize: 14,
      fontWeight: FontWeight.w500,
    ),
    labelLarge: GoogleFonts.openSans(
      // height: 20,
      fontSize: 14,
      fontWeight: FontWeight.w500,
    ),
    labelMedium: GoogleFonts.openSans(
      // height: 16,
      fontSize: 12,
      fontWeight: FontWeight.w500,
    ),
    labelSmall: GoogleFonts.openSans(
      // height: 16,
      fontSize: 11,
      fontWeight: FontWeight.w500,
    ),
    bodyLarge: GoogleFonts.openSans(
      // height: 24,
      fontSize: 16,
      fontWeight: FontWeight.w400,
    ),
    bodyMedium: GoogleFonts.openSans(
      // height: 20,
      fontSize: 14,
      fontWeight: FontWeight.w400,
    ),
    bodySmall: GoogleFonts.openSans(
      // height: 16,
      fontSize: 12,
      fontWeight: FontWeight.w400,
    ),
  ),
);
