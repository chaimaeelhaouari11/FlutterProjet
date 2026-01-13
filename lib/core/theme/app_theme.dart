import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  // Global Key for SnackBar (fixes red screen context issues)
  static final GlobalKey<ScaffoldMessengerState> messengerKey = GlobalKey<ScaffoldMessengerState>();

  // Professional PFE Palette
  static const Color primary = Color(0xFF0F172A); // Slate 900 - Sophisticated Navy
  static const Color accent = Color(0xFF4F46E5); // Indigo 600 - Dynamic Corporate
  static const Color secondary = Color(0xFF475569); // Slate 600 - Neutral
  static const Color background = Color(0xFFF1F5F9); // Slate 100 - Clean Base
  static const Color white = Color(0xFFFFFFFF);
  
  static const Color success = Color(0xFF059669); // Emerald 600
  static const Color warning = Color(0xFFD97706); // Amber 600
  static const Color error = Color(0xFFDC2626); // Red 600
  static const Color info = Color(0xFF2563EB); // Blue 600

  // Compatibility aliases
  static const Color primaryDark = Color(0xFF020617);
  static const Color primaryMedium = accent;
  static const Color primaryLight = Color(0xFFDBEAFE); // Blue 100
  static const Color primaryVeryLight = Color(0xFFF8FAFC);
  static const Color grey = Color(0xFF94A3B8);

  static final LinearGradient primaryGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [primary, const Color(0xFF1E293B)],
  );

  static final LinearGradient accentGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [accent, accent.withOpacity(0.8)],
  );

  // Light Theme Configuration
  static ThemeData get lightTheme {
    final base = ThemeData.light();
    return base.copyWith(
      useMaterial3: true,
      brightness: Brightness.light,
      primaryColor: primary,
      scaffoldBackgroundColor: background,
      colorScheme: ColorScheme.fromSeed(
        seedColor: accent,
        primary: primary,
        secondary: accent,
        surface: white,
        background: background,
        error: error,
      ),
      appBarTheme: AppBarTheme(
        elevation: 0,
        centerTitle: true,
        backgroundColor: background,
        foregroundColor: primary,
        titleTextStyle: GoogleFonts.plusJakartaSans(
          fontSize: 20,
          fontWeight: FontWeight.w700,
          color: primary,
        ),
        iconTheme: const IconThemeData(color: primary, size: 24),
      ),
      cardTheme: CardThemeData(
        elevation: 0,
        color: white,
        surfaceTintColor: Colors.transparent,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
          side: const BorderSide(color: Color(0xFFE2E8F0), width: 1),
        ),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: primary,
          foregroundColor: white,
          elevation: 0,
          shadowColor: Colors.transparent,
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          textStyle: GoogleFonts.plusJakartaSans(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            letterSpacing: 0.5,
          ),
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: white,
        contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: const BorderSide(color: Color(0xFFCBD5E1)),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: const BorderSide(color: Color(0xFFE2E8F0)),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: const BorderSide(color: accent, width: 2),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: const BorderSide(color: error),
        ),
        hintStyle: GoogleFonts.inter(color: grey, fontSize: 14),
        prefixIconColor: secondary,
        suffixIconColor: secondary,
      ),
      textTheme: GoogleFonts.plusJakartaSansTextTheme(base.textTheme).copyWith(
        displayLarge: GoogleFonts.plusJakartaSans(fontWeight: FontWeight.w800, color: primary),
        displayMedium: GoogleFonts.plusJakartaSans(fontWeight: FontWeight.w800, color: primary),
        displaySmall: GoogleFonts.plusJakartaSans(fontWeight: FontWeight.w700, color: primary),
        headlineMedium: GoogleFonts.plusJakartaSans(fontWeight: FontWeight.w700, color: primary),
        titleLarge: GoogleFonts.plusJakartaSans(fontWeight: FontWeight.w700, color: primary),
        bodyLarge: GoogleFonts.inter(color: primary, fontSize: 16),
        bodyMedium: GoogleFonts.inter(color: secondary, fontSize: 14),
      ),
    );
  }

  // Dark Theme Configuration
  static ThemeData get darkTheme {
    final base = ThemeData.dark();
    return base.copyWith(
      useMaterial3: true,
      brightness: Brightness.dark,
      primaryColor: accent,
      scaffoldBackgroundColor: const Color(0xFF020617), // Deepest Navy
      colorScheme: ColorScheme.fromSeed(
        seedColor: accent,
        brightness: Brightness.dark,
        primary: accent,
        secondary: accent,
        surface: const Color(0xFF0F172A),
        background: const Color(0xFF020617),
      ),
      appBarTheme: AppBarTheme(
        elevation: 0,
        centerTitle: true,
        backgroundColor: const Color(0xFF020617),
        foregroundColor: white,
        titleTextStyle: GoogleFonts.plusJakartaSans(
          fontSize: 20,
          fontWeight: FontWeight.w700,
          color: white,
        ),
      ),
      cardTheme: CardThemeData(
        elevation: 0,
        color: const Color(0xFF0F172A),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
          side: const BorderSide(color: Color(0xFF1E293B), width: 1),
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: const Color(0xFF0F172A),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: const BorderSide(color: Color(0xFF1E293B)),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: const BorderSide(color: Color(0xFF1E293B)),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: const BorderSide(color: accent, width: 2),
        ),
      ),
      textTheme: GoogleFonts.plusJakartaSansTextTheme(base.textTheme).copyWith(
        titleLarge: GoogleFonts.plusJakartaSans(fontWeight: FontWeight.w700, color: white),
        bodyLarge: GoogleFonts.inter(color: white.withOpacity(0.9), fontSize: 16),
        bodyMedium: GoogleFonts.inter(color: grey, fontSize: 14),
      ),
    );
  }
}
