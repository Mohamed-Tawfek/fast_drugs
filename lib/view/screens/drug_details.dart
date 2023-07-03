import 'package:fast_drugs/shared/components/extensions.dart';
import 'package:fast_drugs/shared/constants/app_strings.dart';
import 'package:flutter/material.dart';

import '../../models/drug_model.dart';

class DrugDetails extends StatelessWidget {
  const DrugDetails({super.key, required this.drug});
  final DrugModel drug;
  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        body: Container(
          decoration: const BoxDecoration(
              image: DecorationImage(
                  image:
                      AssetImage("assets/images/background_drug_details.jpg"),
                  fit: BoxFit.cover)),
          child: Container(
            padding: EdgeInsetsDirectional.only(
                top: context.deviceHeight * 0.06,
                start: context.deviceWidth * 0.04),
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  DrugsBlock(
                    text: AppStrings.drugName,
                    content: drug.name,
                  ),
                  DrugsBlock(
                    text: AppStrings.effectiveMaterial,
                    content: drug.effectiveMaterial,
                  ),
                  DrugsBlock(
                    text: AppStrings.indications,
                    content: drug.indications,
                  ),
                  DrugsBlock(
                    text: drug.companyName,
                    content: drug.companyName,
                  ),
                  DrugsBlock(
                    text: AppStrings.howToUse,
                    content: drug.howToUse,
                  ),
                  DrugsBlock(
                    text: AppStrings.pregnantAndLactating,
                    content: drug.pregnantAndLactating,
                  ),
                  DrugsBlock(
                    text: AppStrings.dose,
                    content: drug.dose,
                  ),
                  DrugsBlock(
                    text: AppStrings.alternatives,
                    content: drug.alternatives,
                  ),
                  DrugsBlock(
                    text: AppStrings.scheduled,
                    content: '0',
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class DrugsBlock extends StatelessWidget {
  String text;
  String content;
  DrugsBlock({super.key, required this.text, required this.content});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          text,
          style: TextStyle(
              color: Colors.grey[600],
              fontSize: 23.0,
              fontWeight: FontWeight.bold),
        ),
        Padding(
          padding:
              EdgeInsetsDirectional.only(start: context.deviceWidth * 0.03),
          child: Text(
            content,
            style: TextStyle(
              color: Colors.grey[600],
              fontSize: 20.0,
            ),
          ),
        ),
        SizedBox(
          height: context.deviceHeight * 0.04,
        )
      ],
    );
  }
}
