import 'package:fast_drugs/helpers/cash_helper.dart';
import 'package:fast_drugs/helpers/dio_helper.dart';
import 'package:fast_drugs/shared/constants/api_constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'app.dart';
import 'controller/bloc_observer.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();

await DioHelper.init();
await CashHelper.init();
//CashHelper.remove(key: 'userID');
  Bloc.observer = MyBlocObserver();

  runApp(const MyApp());
}

