import 'package:fast_drugs/themes/light_theme.dart';
import 'package:fast_drugs/view/screens/home_screen.dart';
import 'package:flutter/material.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Fast Drugs',
       theme: getLightTheme(),
      home:  HomeScreen(),
    );
  }
}
