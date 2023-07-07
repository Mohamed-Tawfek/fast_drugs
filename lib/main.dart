import 'package:fast_drugs/helpers/cash_helper.dart';
import 'package:fast_drugs/helpers/dio_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'app.dart';
import 'controller/bloc_observer.dart';
import 'controller/donation_cubit/donation_cubit.dart';
import 'controller/mode_cubit/mode_cubit.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await DioHelper.init();
  await CashHelper.init();

  ModeCubit.isDark = CashHelper.getData(key: 'isDark') ?? false;
 //CashHelper.sharedPreferences!.clear();
  Bloc.observer = MyBlocObserver();

  print('0'*50);
  print('id: ${CashHelper.getData(key: 'userID')}');
  print('0'*50);

  print('token: ${CashHelper.getData(key: 'token')}');
  print('0'*50);
  //
  // DioHelper.getData(
  //     endPoint: 'associations/donations',
  //     token:
  //         'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJfaWQiOiI2NGE3M2M3NDliNjRlZDM5MWE3ZWUzNjEiLCJpYXQiOjE2ODg2ODE5MzZ9.WAihq1weBI9gnmGC7SXhhxmgESbMyoaS7X81fuD8EjM').then((value)
  // {
  //      print(value.data);
  // });
 runApp(const MyApp());
}
