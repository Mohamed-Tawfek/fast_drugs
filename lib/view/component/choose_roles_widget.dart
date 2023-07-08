import 'package:fast_drugs/controller/register_cubit/register_cubit.dart';
import 'package:fast_drugs/shared/components/extensions.dart';
import 'package:fast_drugs/shared/constants/app_strings.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../controller/mode_cubit/mode_cubit.dart';
import '../../shared/constants/dark_theme_colors.dart';
import '../../shared/constants/light_theme_colors.dart';

class ChooseRoleWidget extends StatelessWidget {
  const ChooseRoleWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: SizedBox(
        width: context.deviceWidth,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              AppStrings.accountType,
              style: TextStyle(
                  color: ModeCubit.isDark ? DarkColors.text : LightColors.text,
                  fontSize: 15.sp),
            ),
            SizedBox(
              width: context.deviceWidth * 0.02,
            ),
            DropdownButton(
                value: RegisterCubit.get(context).chosenRole,

                underline: const SizedBox(),
                focusColor: Colors.transparent,
                dropdownColor: ModeCubit.isDark?DarkColors.scaffoldBackground:LightColors.scaffoldBackground,
                //iconEnabledColor: Colors.amber,

                items: RegisterCubit.get(context)
                    .roles
                    .map((_value) => DropdownMenuItem<String>(
                        value: _value, // this
                        child: Text(
                          _value,
                          style: TextStyle(
                            color: ModeCubit.isDark?DarkColors.textField:LightColors.textField
                          ),
                        )))
                    .toList(),
                onChanged: (role) {
                  if (role != null) {


                    RegisterCubit.get(context).changeRole(role: role);
                  }
                }),
          ],
        ),
      ),
    );
  }
}
