import 'package:fast_drugs/controller/donation_cubit/donation_cubit.dart';
import 'package:fast_drugs/models/association_model.dart';
import 'package:fast_drugs/shared/components/dialogs.dart';
import 'package:fast_drugs/shared/components/extensions.dart';
import 'package:fast_drugs/shared/constants/app_strings.dart';
import 'package:fast_drugs/shared/constants/light_theme_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../shared/components/components.dart';
import '../component/switch_mode.dart';

class DonationScreen extends StatefulWidget {
  DonationScreen({Key? key}) : super(key: key);

  @override
  State<DonationScreen> createState() => _DonationScreenState();
}

class _DonationScreenState extends State<DonationScreen> {

  final TextEditingController _drugNameController = TextEditingController();

  final TextEditingController _expirationDateController =
      TextEditingController();

  final TextEditingController _quantity = TextEditingController();

  final TextEditingController _phone = TextEditingController();

  final TextEditingController _address = TextEditingController();
final GlobalKey<FormState> _formKey=GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        body: SafeArea(
          child: Padding(
            padding: EdgeInsetsDirectional.symmetric(
              horizontal: context.deviceWidth * 0.06,
            ),
            child: Form(
              key:_formKey ,
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: BlocProvider(
                  create: (context) => DonationCubit()..getAssociations(),
                  child: BlocConsumer<DonationCubit, DonationState>(
                    listener: (context, state) {
                      if (state is GetAssociationsLoading) {
                        showProgressDialog(context);
                      }
                      if (state is GetAssociationsSuccess) {
                        //Navigator.pop(context);
                      }
                      if (state is GetAssociationsError) {
                        Navigator.pop(context);
                        showErrorDialog(
                            context: context, message: AppStrings.error);
                      }
                    },
                    builder: (context, state) {
                      return Column(
                        children: [
                          _divider(context),
                          _divider(context),
                          Row(
                            children: [
                              Image.asset(
                                'assets/images/donation.jpg',
                                height: 50,
                                width: 50,
                              ),
                              SizedBox(
                                width: context.deviceWidth * 0.05,
                              ),
                              Text(
                                AppStrings.donationForm,
                                style: TextStyle(
                                    fontSize: 25.sp,
                                    fontWeight: FontWeight.bold,
                                    color: LightColors.primary),
                              ),
                            ],
                          ),
                          _divider(context),
                          if (state is GetAssociationsSuccess)
                            DropdownButtonFormField(
                                decoration: InputDecoration(
                                  enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(20.0)),
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(20.0)),
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
                                hint: Text(AppStrings.ChoseAssociation),
                                items: DonationCubit.get(context)
                                    .associations
                                    .map((association) => DropdownMenuItem(
                                          value: association,
                                          child: Text(
                                              '${association.firstName} ${association.lastName}'),
                                        ))
                                    .toList(),
                                onChanged: (association) {
                                  DonationCubit.get(context).choseAssociation =
                                      association;
                                 print('-'*20);
                                 print(DonationCubit.get(context).choseAssociation!.id);
                                 print('-'*20);
                                }),
                          _divider(context),

                          DefaultFormField(
                            controller: _drugNameController,
                            label: AppStrings.drugName,
                          ),
                          _divider(context),
                          DefaultFormField(
                            controller: _expirationDateController,
                            label: AppStrings.expirationDate,
                          ),
                          _divider(context),
                          DefaultFormField(
                            controller: _quantity,
                            label: AppStrings.quantity,
                            type: TextInputType.number,
                          ),
                          _divider(context),
                          DefaultFormField(
                            controller: _phone,
                            label: AppStrings.phone,
                          ),
                          _divider(context),
                          DefaultFormField(
                            controller: _address,
                            label: AppStrings.address,
                          ),
                          _divider(context),
                          DefaultButton(function: () {
                            if
                            (_formKey.currentState!.validate()){
                                DonationCubit.get(context).donate(
                                    drugName: _drugNameController.text,
                                    expirationDate: _expirationDateController.text,
                                    quantity: _quantity.text,
                                    phone: _phone.text,
                                    address: _address.text,
                                    context: context
                                );
                            }
                             print('*'*10);
                                print(DonationCubit.get(context).choseAssociation!.id);
                            print('*'*10);
                          }, text: AppStrings.donate),
                        ],
                      );
                    },
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  SizedBox _divider(BuildContext context) => SizedBox(
        height: context.deviceHeight * 0.025,
      );
}
