import 'package:fast_drugs/shared/components/extensions.dart';
import 'package:fast_drugs/shared/constants/app_strings.dart';
import 'package:fast_drugs/shared/constants/light_theme_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../shared/components/components.dart';

class DonationScreen extends StatelessWidget {
    DonationScreen({Key? key}) : super(key: key);
final TextEditingController _userNameController=TextEditingController();
final TextEditingController _drugNameController=TextEditingController();
final TextEditingController _expirationDateController=TextEditingController();
final TextEditingController _quantity=TextEditingController();
final TextEditingController _phone=TextEditingController();
final TextEditingController _address=TextEditingController();
  @override
  Widget build(BuildContext context) {
    return   Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(),
        body: Padding(
          padding:  EdgeInsetsDirectional.symmetric(horizontal: context.deviceWidth*0.06),
          child: SingleChildScrollView(
            physics:const BouncingScrollPhysics(),
            child: Column(
              children: [
                Row(
                  children: [
                    Image.asset('assets/images/donation.jpg',
                      height: 50,
                      width: 50,
                    ),
                    SizedBox(width: context.deviceWidth*0.05,),

                    Text(AppStrings.donationForm,
                      style: TextStyle(
                          fontSize: 25.sp,
                          fontWeight: FontWeight.bold,
                          color:  LightColors.primary
                      ),
                    ),



                  ],
                ),
                _divider(context),
                DefaultFormField(
                  controller: _userNameController,
                  label:AppStrings.yourFullName,
                ),
                _divider(context),
                DefaultFormField(
                  controller: _drugNameController,
                  label:AppStrings.drugName,
                ),
                _divider(context),
                DefaultFormField(
                  controller: _expirationDateController,
                  label:AppStrings.expirationDate,
                ),
                _divider(context),

                DefaultFormField(
                  controller: _quantity,
                  label:AppStrings.quantity,
                ),
                _divider(context),

                DefaultFormField(
                  controller: _phone,
                  label:AppStrings.phone,
                ),
                _divider(context),

                DefaultFormField(
                  controller: _address,
                  label:AppStrings.address,
                ),
                _divider(context),

                DefaultButton(function: (){


                }, text: 'تبرع'),
                SizedBox(height: context.deviceHeight*0.3,)
              ],
            ),
          ),
        ),
      ),
    );
  }

  SizedBox _divider(BuildContext context) => SizedBox(height: context.deviceHeight*0.025,);
}