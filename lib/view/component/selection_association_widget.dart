import 'package:flutter/material.dart';

import '../../controller/donation_cubit/donation_cubit.dart';
import '../../controller/mode_cubit/mode_cubit.dart';
import '../../shared/constants/app_strings.dart';
import '../../shared/constants/dark_theme_colors.dart';
import '../../shared/constants/light_theme_colors.dart';

class SelectionAssociation extends StatelessWidget {
  const SelectionAssociation({super.key});

  @override
  Widget build(BuildContext context) {
    return      DropdownButtonFormField(

        decoration: InputDecoration(
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20.0),
              borderSide: BorderSide(
                  color: ModeCubit.isDark
                      ? DarkColors.textField
                      : LightColors.textField)),
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20.0),
              borderSide: BorderSide(
                  color: ModeCubit.isDark
                      ? DarkColors.textField
                      : LightColors.textField)),
        ),
        borderRadius: BorderRadius.circular(20.0),
        value:
        DonationCubit.get(context).choseAssociation,
        validator: (val) {
          if (val == null) {
            return AppStrings.associationError;
          }
          return null;
        },
        dropdownColor: ModeCubit.isDark
            ? DarkColors.scaffoldBackground
            : LightColors.scaffoldBackground,
        hint: Text(
          AppStrings.ChoseAssociation,
          style: TextStyle(
              color: ModeCubit.isDark
                  ? DarkColors.textField
                  : LightColors.textField),
        ),
        items: DonationCubit.get(context)
            .associations
            .map((association) => DropdownMenuItem(
          value: association,
          child: Text(
            '${association.firstName} ${association.lastName}',
            style: TextStyle(
                color: ModeCubit.isDark
                    ? DarkColors.textField
                    : LightColors.textField),
          ),
        ))
            .toList(),
        onChanged: (association) {
          DonationCubit.get(context).choseAssociation =
              association;
        });

  }
}
