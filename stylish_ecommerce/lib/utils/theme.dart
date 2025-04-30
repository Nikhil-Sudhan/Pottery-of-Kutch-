import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  // Colors
  static const Color primaryColor = Colors.black;
  static const Color secondaryColor = Color(0xFF212121); // Dark Grey
  static const Color accentColor = Color(0xFFD4AF37); // Muted Gold
  static const Color textColor = Color(0xFFE0E0E0); // Light Grey
  static const Color darkTextColor = Color(0xFF9E9E9E); // Darker Grey for contrast

  // Text Styles
  static TextStyle get headingStyle => GoogleFonts.playfairDisplay(
        fontSize: 32,
        fontWeight: FontWeight.bold,
        color: textColor,
      );

  static TextStyle get subheadingStyle => GoogleFonts.playfairDisplay(
        fontSize: 24,
        fontWeight: FontWeight.w600,
        color: textColor,
      );

  static TextStyle get bodyStyle => GoogleFonts.lora(
        fontSize: 16,
        color: textColor,
      );

  static TextStyle get buttonTextStyle => GoogleFonts.lora(
        fontSize: 16,
        fontWeight: FontWeight.w600,
        color: primaryColor,
      );

  static TextStyle get productNameStyle => GoogleFonts.playfairDisplay(
        fontSize: 18,
        fontWeight: FontWeight.w600,
        color: textColor,
      );

  static TextStyle get priceStyle => GoogleFonts.lora(
        fontSize: 16,
        fontWeight: FontWeight.bold,
        color: accentColor,
      );

  // Button Style
  static ButtonStyle get primaryButtonStyle => ButtonStyle(
        backgroundColor: WidgetStateProperty.all(accentColor),
        padding: WidgetStateProperty.all(
          const EdgeInsets.symmetric(vertical: 15, horizontal: 30),
        ),
        shape: WidgetStateProperty.all(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
      );

  static ButtonStyle get secondaryButtonStyle => ButtonStyle(
        backgroundColor: WidgetStateProperty.all(Colors.transparent),
        padding: WidgetStateProperty.all(
          const EdgeInsets.symmetric(vertical: 12, horizontal: 24),
        ),
        shape: WidgetStateProperty.all(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
            side: const BorderSide(color: accentColor),
          ),
        ),
      );

  // Theme Data
  static ThemeData get darkTheme => ThemeData(
        brightness: Brightness.dark,
        scaffoldBackgroundColor: primaryColor,
        colorScheme: const ColorScheme.dark(
          primary: accentColor,
          secondary: secondaryColor,
          surface: secondaryColor,
        ),
        appBarTheme: AppBarTheme(
          backgroundColor: secondaryColor,
          elevation: 0,
          titleTextStyle: GoogleFonts.playfairDisplay(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: textColor,
          ),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: primaryButtonStyle,
        ),
        outlinedButtonTheme: OutlinedButtonThemeData(
          style: secondaryButtonStyle,
        ),
        textTheme: TextTheme(
          titleLarge: headingStyle,
          titleMedium: subheadingStyle,
          bodyLarge: bodyStyle,
          bodyMedium: bodyStyle,
        ),
      );
}
