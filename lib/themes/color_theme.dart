import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

ThemeData lightTheme = ThemeData(
    colorScheme: const ColorScheme.light(
      background: Color(0xFFFEF7F3),
      primary: Color(0xFFFEF7F3),
      secondary: Color(0xFFFEF7F3),
      brightness: Brightness.light,
    ),
    brightness: Brightness.light,
    dividerColor: const Color(0xFF36454F),
    scrollbarTheme: ScrollbarThemeData(
      thumbColor: MaterialStateProperty.all(
        const Color(0xFF708090),
      ),
      // Change the color of the scrollbar thumb
      trackColor: MaterialStateProperty.all(const Color(0xFF37BBE6)),
      trackBorderColor: MaterialStateProperty.all(const Color(0xFF37BBE6)),
      radius: const Radius.circular(8),
      thickness: MaterialStateProperty.all(7.0),
      thumbVisibility: MaterialStateProperty.all(false),
    ),
    appBarTheme: const AppBarTheme(
      systemOverlayStyle: SystemUiOverlayStyle(
        statusBarColor: Color(0xFFFEF7F3),
        statusBarBrightness: Brightness.dark,
        statusBarIconBrightness: Brightness.dark,
      ),
    ),
    textTheme: const TextTheme(
      displayLarge: TextStyle(
          fontFamily: 'Alata',
          fontSize: 28,
          fontWeight: FontWeight.w500,
          fontStyle: FontStyle.normal,
          decoration: TextDecoration.none,
          color: Color(0xFF000000)),
      displayMedium: TextStyle(
          fontFamily: 'Alata',
          fontSize: 24,
          fontWeight: FontWeight.w500,
          fontStyle: FontStyle.normal,
          decoration: TextDecoration.none,
          color: Color(0xFF000000)),
      displaySmall: TextStyle(
          fontFamily: 'Alata',
          fontSize: 22,
          fontWeight: FontWeight.w500,
          fontStyle: FontStyle.normal,
          decoration: TextDecoration.none,
          color: Color(0xFF000000)),
      titleLarge: TextStyle(
        fontFamily: 'Alata',
        fontSize: 20,
        fontWeight: FontWeight.w500,
        fontStyle: FontStyle.normal,
        color: Color(0xFF000000),
        decoration: TextDecoration.none,
      ),
      titleMedium: TextStyle(
        fontFamily: 'Alata',
        fontSize: 18,
        fontWeight: FontWeight.w500,
        fontStyle: FontStyle.normal,
        decoration: TextDecoration.none,
        color: Color(0xFF000000),
      ),
      titleSmall: TextStyle(
          fontFamily: 'Alata',
          fontSize: 16,
          fontWeight: FontWeight.w500,
          fontStyle: FontStyle.normal,
          decoration: TextDecoration.none,
          color: Color(0xFF000000)),
      labelMedium: TextStyle(
          fontFamily: 'Alata',
          fontSize: 14,
          fontWeight: FontWeight.w400,
          fontStyle: FontStyle.normal,
          decoration: TextDecoration.none,
          color: Color(0xFF111111)),
      labelSmall: TextStyle(
          fontFamily: 'Alata',
          fontSize: 12,
          fontWeight: FontWeight.w400,
          fontStyle: FontStyle.normal,
          decoration: TextDecoration.none,
          color: Color(0xFF111111)),
    ),
    snackBarTheme: const SnackBarThemeData(
        contentTextStyle: TextStyle(
            fontFamily: 'Alata',
            fontWeight: FontWeight.w500,
            decoration: TextDecoration.none,
            fontStyle: FontStyle.normal)),
    useMaterial3: true,
    shadowColor: const Color(0XFFFFFFFF).withOpacity(0.28));

ThemeData darkTheme = ThemeData(
  colorScheme: const ColorScheme.dark(
      background: Color(0xFF000000),
      primary: Color(0xFF000000),
      secondary: Color(0xFF000000),
      brightness: Brightness.dark),
  dividerColor: const Color(0xFFE5E4E2),
  scrollbarTheme: ScrollbarThemeData(
    thumbColor: MaterialStateProperty.all(
      const Color(0xFF708090),
    ), // Change the color of the scrollbar thumb
    trackColor: MaterialStateProperty.all(const Color(0xFFf9cacb)),
  ),
  appBarTheme: const AppBarTheme(
    backgroundColor: Color(0xFF111111),
    elevation: 5,
    scrolledUnderElevation: 5.0,
    shadowColor: Color(0xFFE5E4E2),
    systemOverlayStyle: SystemUiOverlayStyle(
      statusBarColor: Color(0xFF000000),
      statusBarBrightness: Brightness.dark,
      statusBarIconBrightness: Brightness.dark,
    ),
  ),
  textTheme: const TextTheme(
    displayLarge: TextStyle(
        fontFamily: 'Alata',
        fontSize: 28,
        fontWeight: FontWeight.w500,
        fontStyle: FontStyle.normal,
        decoration: TextDecoration.none,
        color: Color(0xFFFDEADE)),
    displayMedium: TextStyle(
        fontFamily: 'Alata',
        fontSize: 24,
        fontWeight: FontWeight.w500,
        fontStyle: FontStyle.normal,
        decoration: TextDecoration.none,
        color: Color(0xFFFDEADE)),
    displaySmall: TextStyle(
        fontFamily: 'Alata',
        fontSize: 22,
        fontWeight: FontWeight.w500,
        fontStyle: FontStyle.normal,
        decoration: TextDecoration.none,
        color: Color(0xFFFDEADE)),
    titleLarge: TextStyle(
      fontFamily: 'Alata',
      fontSize: 20,
      fontWeight: FontWeight.w500,
      fontStyle: FontStyle.normal,
      color: Color(0xFFFDEADE),
      decoration: TextDecoration.none,
    ),
    titleMedium: TextStyle(
      fontFamily: 'Alata',
      fontSize: 18,
      fontWeight: FontWeight.w500,
      fontStyle: FontStyle.normal,
      decoration: TextDecoration.none,
      color: Color(0xFFFDEADE),
    ),
    titleSmall: TextStyle(
        fontFamily: 'Alata',
        fontSize: 16,
        fontWeight: FontWeight.w500,
        fontStyle: FontStyle.normal,
        decoration: TextDecoration.none,
        color: Color(0xFFFDEADE)),
    labelMedium: TextStyle(
      fontFamily: 'Alata',
      fontSize: 14,
      fontWeight: FontWeight.w400,
      fontStyle: FontStyle.normal,
      decoration: TextDecoration.none,
      color: Color(0xFFFDEADE),
    ),
    labelSmall: TextStyle(
        fontFamily: 'Alata',
        fontSize: 12,
        fontWeight: FontWeight.w400,
        fontStyle: FontStyle.normal,
        decoration: TextDecoration.none,
        color: Color(0xFFFDEADE)),
  ),
  snackBarTheme: const SnackBarThemeData(
      contentTextStyle: TextStyle(
          fontFamily: 'Alata',
          fontWeight: FontWeight.w500,
          fontStyle: FontStyle.normal)),
  useMaterial3: true,
);
