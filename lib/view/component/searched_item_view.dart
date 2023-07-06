import 'package:fast_drugs/shared/components/extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../app.dart';
import '../../models/drug_model.dart';
import '../screens/drug_details.dart';

class BuildSearchedItem extends StatelessWidget {
  const BuildSearchedItem({super.key, required this.drug});

  final DrugModel drug;

  @override
  Widget build(BuildContext context) {
    String temp = drug.name.replaceAll('\n', '');
    String name = temp.replaceAll("/", '');
    return InkWell(
      onTap: () {
        context.push(DrugDetails(drug: drug));
      },
      child: Container(
        //color: appIsDark?DarkColors.text:LightColors.text,
        padding: EdgeInsets.symmetric(
            vertical: context.deviceHeight * 0.01,
            horizontal: context.deviceWidth * 0.02),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.max,
          children: [
            SizedBox(
              width: double.infinity,
              child: Text(
                name,
                maxLines: 2,
                style: TextStyle(
                    color: Colors.grey[600],
                    fontSize: 20.0.sp,
                    fontWeight: FontWeight.bold),
              ),
            ),
            //   SizedBox(height: context.deviceHeight * 0.005,),
            SizedBox(
              width: double.infinity,
              child: Text(
                drug.indications,
                maxLines: 3,
                style: TextStyle(
                  overflow: TextOverflow.ellipsis,
                  color: Colors.grey[600],
                  fontSize: 18.0.sp,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
