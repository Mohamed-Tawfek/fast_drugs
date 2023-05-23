import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

ThemeData getLightTheme() {
  return ThemeData(
fontFamily: 'Poppins',
primarySwatch: Colors.green,

      appBarTheme: const AppBarTheme(
        iconTheme: IconThemeData(
          color: Colors.green
        ),
          systemOverlayStyle: SystemUiOverlayStyle(
              statusBarColor: Colors.white,
              statusBarIconBrightness: Brightness.dark),
          color: Colors.white,
          elevation: 0.0),
      scaffoldBackgroundColor: Colors.white,
      bottomNavigationBarTheme: const BottomNavigationBarThemeData(
          selectedItemColor: Color(0xff4cb050)));
}
