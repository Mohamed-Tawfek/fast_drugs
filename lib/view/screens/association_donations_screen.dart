import 'package:fast_drugs/controller/notification_cubit/notification_cubit.dart';
import 'package:fast_drugs/shared/components/extensions.dart';
import 'package:fast_drugs/shared/constants/app_strings.dart';
import 'package:fast_drugs/shared/constants/dark_theme_colors.dart';
import 'package:fast_drugs/shared/constants/light_theme_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../controller/mode_cubit/mode_cubit.dart';
import '../../models/notification_model.dart';

class AssociationDonationsScreen extends StatelessWidget {
  const AssociationDonationsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Directionality(
        textDirection: TextDirection.rtl,
        child: SafeArea(
          child: BlocProvider(
            create: (context) => NotificationCubit()..getAllNotifications(),
            child: Padding(
              padding: EdgeInsetsDirectional.only(
                  top: context.deviceHeight * 0.07,
                  start: context.deviceWidth * 0.07),
              child: BlocBuilder<NotificationCubit, NotificationState>(
                builder: (context, state) {
                  NotificationCubit cubit = NotificationCubit.get(context);
                  if (cubit.notifications.isEmpty &&
                      state is GetNotificationSuccess) {
                    return Center(
                      child: Text(
                        AppStrings.noDonations,
                        style: TextStyle(
                            fontSize: 23.sp, fontWeight: FontWeight.bold),
                      ),
                    );
                  } else if (cubit.notifications.isEmpty &&
                      state is! GetNotificationSuccess) {
                    return Center(
                      child: CircularProgressIndicator(
                        color: LightColors.primary,
                      ),
                    );
                  } else {
                    return ListView.separated(
                        physics: const BouncingScrollPhysics(),
                        itemBuilder: (_, i) =>
                            BuildNotification(model: cubit.notifications[i]),
                        separatorBuilder: (_, i) => Padding(

                          padding: EdgeInsetsDirectional.symmetric(

                              horizontal: context.deviceWidth * 0.06,
                          vertical:context.deviceHeight*0.02
                          ),
                          child: Container(
                                height: 1,
                                color: ModeCubit.isDark?DarkColors.primary:LightColors.primary,
                                width: context.deviceWidth,

                              ),
                        ),
                        itemCount: cubit.notifications.length);
                  }
                },
              ),
            ),
          ),
        ),
      ),
    );
  }


}

class BuildInfo extends StatelessWidget {
  const BuildInfo({super.key, required this.value, required this.field});
  final String field;
  final String value;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsetsDirectional.only(end: context.deviceWidth * 0.04),
      child: Column(
        //crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Text(
            '$field :',
            style: TextStyle(fontSize: 20.sp, fontWeight: FontWeight.bold,
            color: ModeCubit.isDark?DarkColors.text:LightColors.text,
            ),
          ),
          SizedBox(
            width: context.deviceWidth * 0.01,
          ),
          Text(
            value,
            style: TextStyle(fontSize: 16.sp,
              color: ModeCubit.isDark?DarkColors.text:LightColors.text,
            ),
          ),
        ],
      ),
    );
  }
}

class BuildNotification extends StatelessWidget {
  const BuildNotification({super.key, required this.model});
  final NotificationModel model;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        BuildInfo(
          value: model.drugName,
          field: AppStrings.drugName,
        ),
        _buildDivider(context),
        BuildInfo(
          value: '${model.quantity}',
          field: AppStrings.quantity,
        ),
        _buildDivider(context),
        BuildInfo(
          value: model.expirationDate,
          field: AppStrings.expirationDate,
        ),
        _buildDivider(context),
        BuildInfo(
          value: model.name,
          field: AppStrings.donorName,
        ),
        _buildDivider(context),
        BuildInfo(
          value: model.phone,
          field: AppStrings.phone,
        ),
        _buildDivider(context),
        BuildInfo(
          value: model.address,
          field: AppStrings.address,
        ),

      ],
    );
  }

  SizedBox _buildDivider(BuildContext context) => SizedBox(
        height: context.deviceHeight * 0.01,
      );
}
