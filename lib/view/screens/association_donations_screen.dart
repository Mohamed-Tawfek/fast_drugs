import 'package:fast_drugs/controller/notification_cubit/notification_cubit.dart';
import 'package:fast_drugs/shared/components/extensions.dart';
import 'package:fast_drugs/shared/constants/light_theme_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

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
                        'لا توجد تبرعات',
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
                        separatorBuilder: (_, i) => Container(
                              height: 1,
                              width: double.infinity,
                              padding: EdgeInsetsDirectional.symmetric(
                                  horizontal: context.deviceWidth * 0.04),
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

  SizedBox _buildDivider(BuildContext context) => SizedBox(
        height: context.deviceHeight * 0.01,
      );
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
            style: TextStyle(fontSize: 20.sp, fontWeight: FontWeight.bold),
          ),
          SizedBox(
            width: context.deviceWidth * 0.01,
          ),
          Text(
            value,
            style: TextStyle(fontSize: 16.sp),
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
          field: 'اسم الدواء',
        ),
        _buildDivider(context),
        BuildInfo(
          value: '${model.quantity}',
          field: 'الكمية',
        ),
        _buildDivider(context),
        BuildInfo(
          value: model.expirationDate,
          field: 'تاريخ انتهاء الصلاحية',
        ),
        _buildDivider(context),
        BuildInfo(
          value: model.name,
          field: 'اسم المتبرع',
        ),
        _buildDivider(context),
        BuildInfo(
          value: model.phone,
          field: 'رقم الهاتف',
        ),
        _buildDivider(context),
        BuildInfo(
          value: model.address,
          field: 'العنوان',
        ),
        _buildDivider(context),
        BuildInfo(
          value: model.email,
          field: 'البريد الالكترونى',
        ),
      ],
    );
  }

  SizedBox _buildDivider(BuildContext context) => SizedBox(
        height: context.deviceHeight * 0.01,
      );
}
