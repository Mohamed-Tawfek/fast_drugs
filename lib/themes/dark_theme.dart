import 'package:fast_drugs/shared/constants/light_theme_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../shared/constants/dark_theme_colors.dart';

ThemeData getDarkTheme() {
  return ThemeData(
      fontFamily: 'Poppins',
      primarySwatch: LightColors.primary,
      appBarTheme: const AppBarTheme(
          iconTheme: IconThemeData(color: DarkColors.appBarIcon),
          systemOverlayStyle: SystemUiOverlayStyle(
              statusBarColor:DarkColors.statusBar ,
              statusBarIconBrightness: Brightness.light),
          color:DarkColors.appBar ,
          elevation: 0.0),

      inputDecorationTheme:InputDecorationTheme(

          enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: DarkColors.textField,

          ))
      ),

      scaffoldBackgroundColor: DarkColors.scaffoldBackground,
      bottomNavigationBarTheme: const BottomNavigationBarThemeData(
          selectedItemColor: DarkColors.btnNavSelectedItem)
      );
}
