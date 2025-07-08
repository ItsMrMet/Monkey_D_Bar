import 'package:flutter/material.dart';

// Pirate theme: colores oscuros, rojizos, dorados
final ThemeData pirateTheme = ThemeData(
  brightness: Brightness.dark,
  primaryColor: const Color(0xFF5A2A27),
  scaffoldBackgroundColor: const Color(0xFF2E1F1A),
  colorScheme: ColorScheme.dark(
    primary: const Color(0xFF8B3E2F),
    secondary: const Color(0xFFC4916E),
  ),
  appBarTheme: const AppBarTheme(
    backgroundColor: Color(0xFF5A2A27),
    foregroundColor: Colors.white,
  ),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      backgroundColor: const Color(0xFFC4916E),
      foregroundColor: Colors.black,
    ),
  ),
);

// Marine theme: colores claros, azulados, plateados
final ThemeData marineTheme = ThemeData(
  brightness: Brightness.light,
  primaryColor: const Color(0xFF135B8A),
  scaffoldBackgroundColor: const Color(0xFFE6EFF4),
  colorScheme: ColorScheme.light(
    primary: const Color(0xFF135B8A),
    secondary: const Color(0xFF7EB7D4),
  ),
  appBarTheme: const AppBarTheme(
    backgroundColor: Color(0xFF135B8A),
    foregroundColor: Colors.white,
  ),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      backgroundColor: const Color(0xFF7EB7D4),
      foregroundColor: Colors.black,
    ),
  ),
);

final ThemeData neutralTheme = ThemeData(
  brightness: Brightness.light,
  scaffoldBackgroundColor: const Color(0xFFF3F3F3),
  colorScheme: ColorScheme.light(
    primary: Color(0xFF5C6BC0), // Azul moderno
    secondary: Color(0xFF90CAF9), // Azul claro vibrante
  ),
  appBarTheme: const AppBarTheme(
    backgroundColor: Color(0xFF5C6BC0),
    foregroundColor: Colors.white,
    elevation: 0,
  ),
  textTheme: const TextTheme(
    titleLarge: TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
    bodyMedium: TextStyle(fontSize: 16),
  ),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      backgroundColor: const Color(0xFF5C6BC0),
      foregroundColor: Colors.white,
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
      textStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
    ),
  ),
  inputDecorationTheme: InputDecorationTheme(
    border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
    filled: true,
    fillColor: Colors.white,
    contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
    labelStyle: const TextStyle(color: Colors.black54),
  ),
);
