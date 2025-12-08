import 'package:flutter/material.dart';

class AppTheme {
  // =========================================================
  // PALETA DE COLORES
  // =========================================================

  static const Color primary = Colors.red;
  static const Color action = Colors.green;
  static const Color actionAccent = Colors.greenAccent;

  // Colores runtime
  static final Color selectedBgLight = Colors.green[100]!;
  static final Color selectedTextDark = Colors.green[900]!;
  static final Color overlayDark = Colors.black38;

  static const Color white = Colors.white;
  static const Color black = Colors.black87;

  // =========================================================
  // TEMA GLOBAL
  // =========================================================

  static final ThemeData lightTheme = ThemeData(
    useMaterial3: true,
    
    // 1. Esquema de Colores
    colorScheme: ColorScheme.fromSeed(
      seedColor: primary,
      primary: primary,
      secondary: action,
      background: Colors.white,
    ),

    // 2. Barra Superior (AppBar)
    appBarTheme: const AppBarTheme(
      backgroundColor: primary,
      elevation: 0,
      centerTitle: true,
      iconTheme: IconThemeData(color: white),
      titleTextStyle: TextStyle(
        color: white, 
        fontSize: 22, 
        fontWeight: FontWeight.bold
      ),
    ),

    // 3. Tema de los Diálogos
    dialogTheme: const DialogThemeData( 
      backgroundColor: Colors.white,
      surfaceTintColor: Colors.transparent,
      titleTextStyle: TextStyle(
        color: Colors.black,
        fontSize: 20, 
        fontWeight: FontWeight.bold
      ),
      contentTextStyle: TextStyle(
        color: Colors.black87,
        fontSize: 16
      ),
    ),

    // 4. Botón Flotante
    floatingActionButtonTheme: const FloatingActionButtonThemeData(
      backgroundColor: action,
      foregroundColor: white,
      elevation: 5,
    ),

    // 5. Botones Elevados
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: primary,
        foregroundColor: white,
        elevation: 3,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        textStyle: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
      ),
    ),

    // 6. Textos
    textTheme: const TextTheme(
      headlineLarge: TextStyle(color: primary, fontWeight: FontWeight.bold),
      bodyMedium: TextStyle(color: black),
    ),
  );
}