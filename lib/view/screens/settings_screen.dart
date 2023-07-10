import 'package:fast_drugs/controller/profile_cubit/profile_cubit.dart';
import 'package:fast_drugs/shared/components/components.dart';
import 'package:fast_drugs/shared/components/custom_snackBar.dart';
import 'package:fast_drugs/shared/components/extensions.dart';
import 'package:fast_drugs/shared/constants/app_strings.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../controller/mode_cubit/mode_cubit.dart';
import '../../shared/components/dialogs.dart';
import '../../shared/constants/dark_theme_colors.dart';
import '../../shared/constants/light_theme_colors.dart';
import '../component/edit_widget.dart';
import '../component/switch_mode.dart';

class SettingsScreen extends StatelessWidget {
  SettingsScreen({super.key,this.forUser=true});
bool forUser;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Directionality(
          textDirection: TextDirection.rtl,
          child: BlocProvider(
            create: (context) => ProfileCubit()..getUserData(),
            child: BlocConsumer<ProfileCubit, ProfileState>(
              listener: (context, state) {
                _handleStates(state, context);
              },
              builder: (context, state) {
                ProfileCubit cubit = ProfileCubit.get(context);
                return cubit.currentUser == null
                    ? Center(
                        child: const CircularProgressIndicator(),
                      )
                    : Padding(
                        padding:
                            EdgeInsets.only(top: context.deviceHeight * 0.06),
                        child: SingleChildScrollView(
                          physics: const BouncingScrollPhysics(),
                          child: Column(
                            children: [
                              DetailItem(
                                title: forUser?AppStrings.firstName:AppStrings.associationName,
                                value: cubit.currentUser!.firstName,
                                cubitContext: context,
                              ),
                              _divider(context),
                              if(forUser)
                              DetailItem(
                                title: AppStrings.lastName,
                                value: cubit.currentUser!.lastName,
                                cubitContext: context,
                              ),
                              _divider(context),
                              DetailItem(
                                title: AppStrings.email,
                                value: cubit.currentUser!.email,
                                cubitContext: context,
                              ),
                              _divider(context),
                              ListTile(
                                trailing: SwitchMode(),
                                leading: Text(AppStrings.darkMode),
                                textColor: ModeCubit.isDark
                                    ? DarkColors.listTileChildren
                                    : LightColors.listTileChildren,
                              ),
                              _divider(context),
                              _divider(context),
                              _divider(context),
                              Padding(
                                padding: EdgeInsetsDirectional.symmetric(
                                  horizontal: context.deviceWidth * 0.05,
                                ),
                                child: Column(
                                  children: [
                                    DefaultButton(
                                        function: () {
                                          showDialog(
                                              context: context,
                                              builder: (context1) {
                                                return EditWidget(
                                                  editedElement:
                                                      AppStrings.password,
                                                  cubitContext: context,
                                                );
                                              });
                                        },
                                        text: AppStrings.changePassword),
                                    _divider(context),
                                    _divider(context),

                                    DefaultButton(
                                        color: ModeCubit.isDark
                                            ? DarkColors.dangerousBtn
                                            : LightColors.dangerousBtn,
                                        function: () {
                                          showConfirmDialog(
                                              context: context,
                                              onPressedOK: () {
                                                cubit.logout(context);
                                              },
                                              message:
                                                  AppStrings.confirmLogout);
                                        },
                                        text: AppStrings.logout),
                                    _divider(context),

                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
              },
            ),
          ),
        ),
      ),
    );
  }

  void _handleStates(ProfileState state, BuildContext context) {
    if (state is GetUserDataLoadingState) {
      showProgressDialog(context);
    }
    if (state is GetUserDataErrorState) {

      showCustomSnackBar(context, AppStrings.error,);
    }

    if (state is ChangeFirstNameLoadingState) {
      showProgressDialog(context);
    }
    if (state is ChangeFirstNameErrorState) {
      showErrorDialog(context: context, message: AppStrings.error);
    }
    if (state is ChangeLastNameLoadingState) {
      showProgressDialog(context);
    }
    if (state is ChangeLastNameErrorState) {
      showErrorDialog(context: context, message: AppStrings.error);
    }
    if (state is ChangeEmailLoadingState) {
      showProgressDialog(context);
    }
    if (state is ChangePasswordLoadingState) {
      showProgressDialog(context);
    }

    if (state is ChangePasswordSuccessState) {
      showSuccessDialog(
          context: context, message: AppStrings.successfullyChangePassword);
    }
    if (state is ChangePasswordErrorState) {
      showErrorDialog(context: context, message: AppStrings.error);
    }
    if (state is LogoutErrorState) {
      showErrorDialog(context: context, message: AppStrings.error);
    }
    if (state is LogoutLoadingState) {
      showProgressDialog(context);
    }
    if (state is RemoveAccountErrorState) {
      showErrorDialog(context: context, message: AppStrings.error);
    }
    if (state is RemoveAccountLoadingState) {
      showProgressDialog(context);
    }
  }

  SizedBox _divider(BuildContext context) => SizedBox(
        height: context.deviceHeight * 0.02,
      );
}

class DetailItem extends StatelessWidget {
  DetailItem(
      {super.key,
      required this.value,
      required this.title,
      required this.cubitContext});

  final String title;
  final String value;
  final BuildContext cubitContext;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      trailing: IconButton(
        icon: Icon(
          Icons.edit,
          color: ModeCubit.isDark
              ? DarkColors.listTileChildren
              : LightColors.listTileChildren,
        ),
        onPressed: () {
          showDialog(
              context: context,
              builder: (context1) {
                return EditWidget(
                  editedElement: title,
                  cubitContext: cubitContext,
                );
              });
        },
      ),
      title: Text(
        title,
        style: TextStyle(
          color: ModeCubit.isDark
              ? DarkColors.listTileChildren
              : LightColors.listTileChildren,
        ),
      ),
      subtitle: Center(
          child: Text(value,
              style: TextStyle(
                color: ModeCubit.isDark
                    ? DarkColors.listTileChildren
                    : LightColors.listTileChildren,
              ))),
    );
  }
}
