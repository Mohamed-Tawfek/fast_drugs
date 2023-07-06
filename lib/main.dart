import 'package:fast_drugs/helpers/cash_helper.dart';
import 'package:fast_drugs/helpers/dio_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'app.dart';
import 'controller/bloc_observer.dart';
import 'controller/mode_cubit/mode_cubit.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await DioHelper.init();
  await CashHelper.init();

 ModeCubit.isDark=CashHelper.getData(key: 'isDark')??false;
  Bloc.observer = MyBlocObserver();

print(CashHelper.getData(key: 'userID'));
  runApp(const MyApp());
}
