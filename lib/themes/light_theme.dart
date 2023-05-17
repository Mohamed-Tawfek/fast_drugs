import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

ThemeData getLightTheme() {
  return ThemeData(
      // appBarTheme: AppBarTheme(
      //     systemOverlayStyle: SystemUiOverlayStyle(
      //       statusBarColor: Color(0xff4cb050),
      //     ),
      //     color: Color(0xff4cb050))
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
  selectedItemColor: Color(0xff4cb050)
    )

        );
}
