import 'package:fast_drugs/helpers/cash_helper.dart';
import 'package:fast_drugs/shared/constants/app_strings.dart';
import 'package:fast_drugs/themes/dark_theme.dart';
import 'package:fast_drugs/themes/light_theme.dart';
import 'package:fast_drugs/view/screens/home_screen.dart';
import 'package:fast_drugs/view/screens/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'controller/mode_cubit/mode_cubit.dart';


class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return

      ScreenUtilInit(
        designSize: const Size(360, 690),
        minTextAdapt: true,
        splitScreenMode: true,

        builder: (context, child) {
          return BlocProvider(
            create: (context) => ModeCubit(),
            child: BlocBuilder<ModeCubit, ModeState>(
              builder: (context, state) {
                return MaterialApp(
                    debugShowCheckedModeBanner: false,
                    title: AppStrings.appName,
                    theme: getLightTheme(),
                    darkTheme: getDarkTheme(),
                    themeMode: ModeCubit.isDark
                        ? ThemeMode.dark
                        : ThemeMode
                        .light,
                    home: Directionality(
                        textDirection: TextDirection.rtl,
                        child: _initialScreen())
                );
              },
            ),
          );
        },

      );
  }
}

Widget _initialScreen() {
  String? userID = CashHelper.getData(key: 'userID');
  if (userID != null) {
    return const HomeScreen();
  } else {
    return LoginScreen();
  }
}
