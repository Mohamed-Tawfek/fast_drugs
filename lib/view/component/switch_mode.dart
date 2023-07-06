import 'package:fast_drugs/app.dart';
import 'package:fast_drugs/controller/mode_cubit/mode_cubit.dart';
import 'package:fast_drugs/helpers/cash_helper.dart';
import 'package:flutter/material.dart';
import 'package:restart_app/restart_app.dart';

class SwitchMode extends StatefulWidget {
  const SwitchMode({
    super.key,
  });

  @override
  State<SwitchMode> createState() => _SwitchModeState();
}

class _SwitchModeState extends State<SwitchMode> {
  @override
  Widget build(BuildContext context) {
    return Switch(
      value: ModeCubit.isDark,
      onChanged: (bool value) {

          ModeCubit.get(context).changeMode();



      },
    );
  }
}
