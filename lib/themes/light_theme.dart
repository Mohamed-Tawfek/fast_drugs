import 'package:fast_drugs/shared/constants/light_theme_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

ThemeData getLightTheme() {
  return ThemeData(
      fontFamily: 'Poppins',
      primarySwatch: LightColors.primary,
      appBarTheme: const AppBarTheme(
          iconTheme: IconThemeData(color: LightColors.appBarIcon),
          systemOverlayStyle: SystemUiOverlayStyle(
              statusBarColor:LightColors.statusBar ,
         statusBarBrightness: Brightness.light,
              statusBarIconBrightness: Brightness.dark),
          color:LightColors.appBar ,
          elevation: 0.0),
     inputDecorationTheme:InputDecorationTheme(
        enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: LightColors.textField))
     ),
      scaffoldBackgroundColor: LightColors.scaffoldBackground,
      bottomNavigationBarTheme: const BottomNavigationBarThemeData(
          selectedItemColor: LightColors.btnNavSelectedItem));
}
