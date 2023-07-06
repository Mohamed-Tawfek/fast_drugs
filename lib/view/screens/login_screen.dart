import 'package:fast_drugs/controller/login_cubit/login_cubit.dart';
import 'package:fast_drugs/controller/mode_cubit/mode_cubit.dart';
import 'package:fast_drugs/shared/components/extensions.dart';
import 'package:fast_drugs/shared/constants/app_strings.dart';
import 'package:fast_drugs/shared/constants/light_theme_colors.dart';
import 'package:fast_drugs/view/screens/register_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:regexpattern/regexpattern.dart';

import '../../shared/components/components.dart';
import '../../shared/components/custom_snackBar.dart';
import '../../shared/components/dialogs.dart';
import '../../shared/constants/dark_theme_colors.dart';
import 'home_screen.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({Key? key}) : super(key: key);

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  bool isPassword = true;
  @override
  Widget build(BuildContext context) {
    double deviceHeight = MediaQuery.of(context).size.height;
    double deviceWidth = MediaQuery.of(context).size.width;
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(),
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: deviceWidth * 0.05),
          child: Center(
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Form(
                key: formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      AppStrings.login,
                      style: TextStyle(
                          fontSize: 30.sp,
                          fontWeight: FontWeight.bold,
                          color:ModeCubit.isDark? DarkColors.primary:LightColors.primary


                      ),
                    ),
                    SizedBox(
                      height: deviceHeight * 0.05,
                    ),
                    _buildEmailField(),
                    SizedBox(
                      height: deviceHeight * 0.02,
                    ),
                    _buildPasswordField(),
                    SizedBox(
                      height: deviceHeight * 0.03,
                    ),
                    BlocProvider(
                      create: (context) => LoginCubit(),
                      child: BlocConsumer<LoginCubit, LoginState>(
                        listener: (context, state) {
                          if (state is LoginUserInProgress) {
                            showProgressDialog(context);
                          } else if (state is LoginUserSuccess) {
                            Navigator.of(context, rootNavigator: true).pop();
                            showCustomSnackBar(
                                context, AppStrings.successfullyRegistered);

                            context.pushAndRemoveUntil( HomeScreen());
                          } else if (state is LoginUserError) {
                            context.pop();
                            showErrorDialog(
                                context: context, message: state.error);
                          }
                        },
                        builder: (context, state) {
                          return DefaultButton(
                            text: AppStrings.login,
                            function: () {
                              if (formKey.currentState!.validate()) {
                                LoginCubit.get(context).userLogin(
                                    email: emailController.text,
                                    password: passwordController.text);
                              }
                            },
                          );
                        },
                      ),
                    ),
                    SizedBox(
                      height: deviceHeight * 0.02,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          AppStrings.noAccount,
                          style: TextStyle(fontSize: 15.sp,
                          color: ModeCubit.isDark? DarkColors.text:LightColors.text
                          ),
                        ),
                        TextButton(
                          onPressed: () {
                            context.push(const RegisterScreen());
                          },
                          child: Text(
                            AppStrings.registerNow,
                            style:
                                TextStyle(color: ModeCubit.isDark? DarkColors.primary:LightColors.primary, fontSize: 15.sp),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  DefaultFormField _buildEmailField() {
    return DefaultFormField(
      controller: emailController,
      label: AppStrings.email,
      prefix: Icons.email,
      type: TextInputType.emailAddress,
      validate: (String? value) {
        if (value!.isEmpty) {
          return AppStrings.emptyEmail;
        } else if (!value.isEmail()) {
          return AppStrings.errorEmail;
        } else {
          return null;
        }
      },
    );
  }

  StatefulBuilder _buildPasswordField() {
    return StatefulBuilder(builder: (_, StateSetter setState) {
      return DefaultFormField(
        controller: passwordController,
        label: AppStrings.password,
        prefix: Icons.lock,
        suffix: isPassword ? Icons.visibility_off : Icons.remove_red_eye,
        isPassword: isPassword,
        type: isPassword ? TextInputType.visiblePassword : null,
        suffixOnPressed: () {
          setState(() {
            isPassword = !isPassword;
          });
        },
        validate: (String? value) {
          if (value!.isEmpty) {
            return AppStrings.shortPassword;
          }

          return null;
        },
      );
    });
  }
}
