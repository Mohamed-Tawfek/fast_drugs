import 'package:fast_drugs/helpers/cash_helper.dart';
import 'package:fast_drugs/themes/light_theme.dart';
import 'package:fast_drugs/view/screens/home_screen.dart';
import 'package:fast_drugs/view/screens/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(360, 690),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'First Method',
          // You can use the library anywhere in the app even in theme
          theme: ThemeData(
            primarySwatch: Colors.blue,
            textTheme: Typography.englishLike2018.apply(fontSizeFactor: 1.sp),
          ),
          home: child,
        );
      },
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Fast Drugs',
        theme: getLightTheme(),
        //  home: HomeScreen(),
        home: _initialScreen(),
      ),
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
