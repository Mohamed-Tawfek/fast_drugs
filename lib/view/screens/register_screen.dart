import 'package:fast_drugs/controller/register_cubit/register_cubit.dart';
import 'package:fast_drugs/helpers/cash_helper.dart';
import 'package:fast_drugs/shared/components/dialogs.dart';
import 'package:fast_drugs/shared/components/extensions.dart';
import 'package:fast_drugs/view/screens/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:regexpattern/regexpattern.dart';

import '../../shared/components/components.dart';
import '../../shared/components/custom_snackBar.dart';
import '../../shared/constants/app_strings.dart';

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
    double deviceHeight = MediaQuery.of(context).size.height;
    double deviceWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: EdgeInsets.symmetric(
            horizontal: deviceWidth * 0.04, vertical: deviceHeight * 0.03),
        child: Form(
          key: formKey,
          child: SingleChildScrollView(
            child: Column(
              children: [
                Image.asset(
                  'assets/images/drug4.png',
                  width: deviceWidth * 0.3,
                  height: deviceHeight * 0.1,

                ),
                _buildDivider(deviceHeight),
                const Text(
                  AppStrings.reachYourGoal,
                  style: TextStyle(
                      fontSize: 23.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.grey),
                ),
                _buildDivider(deviceHeight),
                const Text(
                  AppStrings.joinUs,
                  style: TextStyle(
                      fontSize: 15.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.grey),
                ),
                SizedBox(
                  height: deviceHeight * 0.04,
                ),
                _buildFirstNameField(),
                _buildDivider(deviceHeight),
                _buildSecondNameField(),
                _buildDivider(deviceHeight),
                _buildEmailField(),
                _buildDivider(deviceHeight),
                _buildPasswordField(controller: passwordController),
                _buildDivider(deviceHeight),
                _buildPasswordField(
                    controller: confirmPasswordController, isConfirm: true),
                _buildDivider(deviceHeight),
                BlocProvider(
                  create: (context) => RegisterCubit(),
                  child: BlocConsumer<RegisterCubit, RegisterState>(
                    listener: (listenerContext, state) {
                 if(state is CreateAccountInProgress){
                   showProgressDialog(listenerContext);
                 }
                 else if(state is CreateAccountSuccess){
                   Navigator.of(context, rootNavigator: true).pop();
                   showCustomSnackBar(context,'Successfully registered');

                 context.pushAndRemoveUntil(const HomeScreen());
                 }
                 else if(state is CreateAccountError){
                 // Navigator.pop(listenerContext);
                 //  Navigator.of(context, rootNavigator: true).pop();
context.pop();
                   showErrorDialog(context: listenerContext, message: state.errorMessage);
                 }
                    },
                    builder: (context, state) {
                      return DefaultButton(
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
                      );
                    },
                  ),
                ),
              ],
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

  DefaultFormField _buildSecondNameField() {
    return DefaultFormField(
      controller: lastNameController,
      label: AppStrings.lastName,
      //prefix: Icons.medication,
      type: TextInputType.name,
      validate: (String? value) {
        if (value!.isEmpty) {
          return 'Name must not be empty';
        }

        return null;
      },
    );
  }

  DefaultFormField _buildFirstNameField() {
    return DefaultFormField(
      controller: firstNameController,
      label: AppStrings.firstName,
      //prefix: Icons.person,
      type: TextInputType.name,
      validate: (String? value) {
        if (value!.isEmpty) {
          return 'Name must not be empty';
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
          return 'Email must not be empty!';
        } else if (!value.isEmail()) {
          return 'Email is incorrect!';
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
          if (isConfirm) {
            if (confirmPasswordController.text != passwordController.text) {
              return 'Password does not match!';
            } else if (controller.text.isEmpty) {
              return 'Password is too short!';
            }
          } else {
            if (value!.isEmpty) {
              return 'Password is too short!';
            }
          }

          return null;
        },
      );
    });
  }
}
