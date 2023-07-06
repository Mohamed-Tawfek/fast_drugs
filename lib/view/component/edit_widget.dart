import 'package:flutter/material.dart';

import '../../app.dart';
import '../../controller/mode_cubit/mode_cubit.dart';
import '../../controller/profile_cubit/profile_cubit.dart';
import '../../shared/components/components.dart';
import '../../shared/components/dialogs.dart';
import '../../shared/constants/app_strings.dart';
import '../../shared/constants/dark_theme_colors.dart';
import '../../shared/constants/light_theme_colors.dart';

class EditWidget extends StatelessWidget {
  EditWidget(
      {super.key, required this.editedElement, required this.cubitContext});

  final TextEditingController editingController = TextEditingController();
  final String editedElement;
  final _formKey = GlobalKey<FormState>();
  final BuildContext cubitContext;

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: AlertDialog(
        backgroundColor:
        ModeCubit.isDark ?DarkColors.scaffoldBackground:LightColors.scaffoldBackground ,

        title: Text('تغيير ${editedElement}',
            style: TextStyle(
              color: ModeCubit.isDark ?DarkColors.textField:LightColors.textField ,
            )
        ),
        content: Form(
          key: _formKey,
          child: DefaultFormField(
            controller: editingController,
            validate: (value) {
              if (value == null || value.isEmpty) {
                return AppStrings.requiredField;
              }
              return null;
            },
          ),
        ),
        actions: [
          BuildEditActions(
              formKey: _formKey,
              editedElement: editedElement,
              cubitContext: cubitContext,
              editingController: editingController),
        ],
      ),
    );
  }
}

class BuildEditActions extends StatelessWidget {
  const BuildEditActions({
    super.key,
    required GlobalKey<FormState> formKey,
    required this.editedElement,
    required this.cubitContext,
    required this.editingController,
  }) : _formKey = formKey;

  final GlobalKey<FormState> _formKey;
  final String editedElement;
  final BuildContext cubitContext;
  final TextEditingController editingController;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        MaterialButton(
          onPressed: () {
            _editBtn(context);
          },
          child: Text(
            AppStrings.change,
            style: TextStyle(color: ModeCubit.isDark ?DarkColors.buttonChild:LightColors.buttonChild),
          ),
          color: LightColors.primary,
        ),
        MaterialButton(
          color: LightColors.cancelColor,
          onPressed: () {
            Navigator.pop(context);
          },
          child: Text(
            AppStrings.cancel,
    style: TextStyle(color: ModeCubit.isDark ?DarkColors.buttonChild:LightColors.buttonChild

    ))),

      ],
    );
  }

  void _editBtn(BuildContext context) {
    if (_formKey.currentState!.validate()) {
      if (editedElement == AppStrings.firstName) {
        ProfileCubit.get(cubitContext)
            .changeFirstName(name: editingController.text)
            .then((value) {
          Navigator.pop(context);
          Navigator.pop(context);
        });
      }   if (editedElement == AppStrings.password) {
        ProfileCubit.get(cubitContext)
            .changePassword(password: editingController.text)
            .then((value) {
          Navigator.pop(context);
          Navigator.pop(context);
        })

        ;
      }
      if (editedElement == AppStrings.lastName) {
        ProfileCubit.get(cubitContext)
            .changeLastName(name: editingController.text)
            .then((value) {
          Navigator.pop(context);
          Navigator.pop(context);
        });
      }
      if (editedElement == AppStrings.email) {
        ProfileCubit.get(cubitContext)
            .changeEmail(email: editingController.text)
            .then((value) {
          Navigator.pop(context);
          Navigator.pop(context);
        });
      }
    }
  }
}
