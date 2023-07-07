import 'package:fast_drugs/controller/register_cubit/register_cubit.dart';
import 'package:fast_drugs/shared/components/dialogs.dart';
import 'package:fast_drugs/shared/components/extensions.dart';
import 'package:fast_drugs/view/screens/association_donations_screen.dart';
import 'package:fast_drugs/view/screens/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:regexpattern/regexpattern.dart';

import '../../shared/components/components.dart';
import '../../shared/components/custom_snackBar.dart';
import '../../shared/constants/app_strings.dart';
import '../component/choose_roles_widget.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  var firstNameController = TextEditingController();

  var lastNameController = TextEditingController();

  var emailController = TextEditingController();

  var passwordController = TextEditingController();

  var confirmPasswordController = TextEditingController();

  bool isPassword = true;

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(),
        body: Padding(
          padding: EdgeInsets.symmetric(
              horizontal: context.deviceWidth * 0.04,
              vertical: context.deviceHeight * 0.03),
          child: Form(
            key: formKey,
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: BlocProvider(
                create: (context) => RegisterCubit(),
                child: BlocConsumer<RegisterCubit, RegisterState>(
                  listener: (listenerContext, state) {
                    if (state is CreateAccountInProgress) {
                      showProgressDialog(listenerContext);
                    } else if (state is CreateAccountSuccess) {
                      Navigator.of(context, rootNavigator: true).pop();
                      showCustomSnackBar(
                          context, AppStrings.successfullyRegistered);

                      if (RegisterCubit.get(listenerContext).user!.role == 'USER') {
                        context.pushAndRemoveUntil(HomeScreen());
                      } else {
                        context
                            .pushAndRemoveUntil(AssociationDonationsScreen());
                      }
                    } else if (state is CreateAccountError) {
                      context.pop();
                      showErrorDialog(
                          context: listenerContext,
                          message: state.errorMessage);
                    }
                  },
                  builder: (context, state) {
                    return Column(
                      children: [
                        Image.asset(
                          'assets/images/drug4.png',
                          width: context.deviceWidth * 0.3,
                          height: context.deviceHeight * 0.1,
                        ),
                        _buildDivider(context.deviceHeight),
                        const Text(
                          AppStrings.reachYourGoal,
                          style: TextStyle(
                              fontSize: 23.0,
                              fontWeight: FontWeight.bold,
                              color: Colors.grey),
                        ),
                        _buildDivider(context.deviceHeight),
                        const Text(
                          AppStrings.joinUs,
                          style: TextStyle(
                              fontSize: 15.0,
                              fontWeight: FontWeight.bold,
                              color: Colors.grey),
                        ),
                        ChooseRoleWidget(),
                        _buildDivider(context.deviceHeight),
                        _buildFirstNameField(context),
                        _buildDivider(context.deviceHeight),
                        _buildSecondNameField(context),
                        if (RegisterCubit.get(context).chosenRole ==
                            AppStrings.user)
                          _buildDivider(context.deviceHeight),
                        _buildEmailField(),
                        _buildDivider(context.deviceHeight),
                        _buildPasswordField(controller: passwordController),
                        _buildDivider(context.deviceHeight),
                        _buildPasswordField(
                            controller: confirmPasswordController,
                            isConfirm: true),
                        _buildDivider(context.deviceHeight),
                        DefaultButton(
                          text: AppStrings.create,
                          function: () {
                            if (formKey.currentState!.validate()) {
                              RegisterCubit.get(context).createAccount(
                                  firstName: firstNameController.text,
                                  lastName: lastNameController.text,
                                  email: emailController.text,
                                  password: passwordController.text,
                                  confirmPassword:
                                      confirmPasswordController.text);
                            }
                          },
                        ),
                      ],
                    );
                  },
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  SizedBox _buildDivider(double deviceHeight) {
    return SizedBox(
      height: deviceHeight * 0.02,
    );
  }

  Widget _buildSecondNameField(cubitContext) {
    if (RegisterCubit.get(cubitContext).chosenRole == AppStrings.user) {
      return DefaultFormField(
        controller: lastNameController,
        label: AppStrings.lastName,
        //prefix: Icons.medication,
        type: TextInputType.name,
        validate: (String? value) {
          if (value!.isEmpty) {
            return AppStrings.emptySecondName;
          }

          return null;
        },
      );
    }
    return SizedBox();
  }

  DefaultFormField _buildFirstNameField(cubitContext) {
    return DefaultFormField(
      controller: firstNameController,
      label: RegisterCubit.get(cubitContext).chosenRole == AppStrings.user
          ? AppStrings.firstName
          : AppStrings.associationName,
      //prefix: Icons.person,
      type: TextInputType.name,
      validate: (String? value) {
        if (value!.isEmpty) {
          return AppStrings.emptyFirstName;
        }

        return null;
      },
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

  StatefulBuilder _buildPasswordField(
      {required TextEditingController controller, bool isConfirm = false}) {
    return StatefulBuilder(builder: (_, StateSetter setState) {
      return DefaultFormField(
        controller: controller,
        label: isConfirm ? AppStrings.confirmPassword : AppStrings.password,
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
          if (isConfirm) {
            if (confirmPasswordController.text != passwordController.text) {
              return AppStrings.errorPassword;
            } else if (controller.text.isEmpty) {
              return AppStrings.shortPassword;
            }
          } else {
            if (value!.isEmpty) {
              return AppStrings.shortPassword;
            }
          }

          return null;
        },
      );
    });
  }
}
