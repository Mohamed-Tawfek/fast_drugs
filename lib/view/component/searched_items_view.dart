import 'package:fast_drugs/shared/components/extensions.dart';
import 'package:fast_drugs/view/component/searched_item_view.dart';
import 'package:flutter/material.dart';

import '../../controller/search_cubit/search_cubit.dart';
import '../../models/drug_model.dart';
import '../../shared/constants/app_strings.dart';
import '../../shared/constants/light_theme_colors.dart';

class BuildSearchedItemsView extends StatelessWidget {
  const BuildSearchedItemsView(
      {super.key, required this.state, required this.searchedList});

  final SearchState state;
  final List<DrugModel> searchedList;

  @override
  Widget build(BuildContext context) {
    if (state is GetSearchDataLoadingState) {
      return const Center(
        child: CircularProgressIndicator(
          color: LightColors.primary,
        ),
      );
    }
    if (state is GetSearchDataSuccessState && searchedList.isNotEmpty) {
      return Container(
        color: LightColors.primary[200],
        margin: EdgeInsetsDirectional.only(top: context.deviceHeight * 0.12),
        child: ListView.separated(
          physics: const BouncingScrollPhysics(),
          itemBuilder: (context, index) => BuildSearchedItem(
            drug: SearchCubit.get(context).searchedData[index],
          ),
          separatorBuilder: (BuildContext context, int index) => Container(
            height: 1,
            width: double.infinity,
            padding: EdgeInsetsDirectional.symmetric(
                horizontal: context.deviceWidth * 0.1),
          ),
          itemCount: SearchCubit.get(context).searchedData.length,
        ),
      );
    }
    if (state is GetSearchDataErrorState && searchedList.isEmpty) {
      return const Center(
          child: Text(
        AppStrings.notFound,
        style: TextStyle(color: Colors.black, fontSize: 30.0),
      ));
    }

    return const Center(
        child: Text(
      AppStrings.trySearch,
      style: TextStyle(color: Colors.black, fontSize: 30.0),
    ));
  }
}
