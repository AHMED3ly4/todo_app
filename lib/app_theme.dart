import 'package:flutter/material.dart';

class AppTheme{
  static Color mintGreen=const Color(0xFFDFECDB);
  static Color white=Colors.white;
  static Color blue =const Color(0xFF5D9CEC);
  static Color green =const Color(0xFF61E757);
  static Color grey =const Color(0xFF363636);


  static ThemeData appLightTheme=ThemeData(
    scaffoldBackgroundColor: mintGreen,
    primaryColor: white,
    appBarTheme: AppBarTheme(
      backgroundColor: blue,
      foregroundColor: white,
      elevation: 0
    ),
    textTheme: TextTheme(
      headlineLarge: const TextStyle(
        fontSize: 18,
        color: Colors.black,
        fontWeight: FontWeight.w700
      ),
      bodySmall: TextStyle(
          fontSize: 12,
          color: grey,
          fontWeight: FontWeight.w400
      ),
      bodyMedium: const TextStyle(
          fontSize: 20,
          color: Colors.black,
          fontWeight: FontWeight.w400
      ),
    ),
    bottomSheetTheme: BottomSheetThemeData(
      backgroundColor: white,
      showDragHandle: true,
      dragHandleColor: blue
    ),
    floatingActionButtonTheme: FloatingActionButtonThemeData(
      backgroundColor: blue,
      foregroundColor: white
    ),
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      selectedItemColor: blue
    ),
  );
}