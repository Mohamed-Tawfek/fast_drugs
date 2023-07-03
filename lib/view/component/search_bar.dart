import 'package:fast_drugs/shared/components/extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../controller/search_cubit/search_cubit.dart';
import '../../shared/components/components.dart';

class BuildSearchBar extends StatelessWidget {
    BuildSearchBar({super.key,required this.searchController});
  final ExpansionTileController expansionController = ExpansionTileController();
     final TextEditingController searchController;
  @override
  Widget build(BuildContext context) {
    return  ExpansionTile(
      controller: expansionController,
      trailing: const Icon(Icons.history),
      title: DefaultFormField(
        controller: searchController,
        onChange: (String word) {
          SearchCubit.get(context).search(name: word);
        },
      ),
      children: SearchCubit.get(context)
          .historySearch
          .map((searchWord) => InkWell(
        onTap: () {
          expansionController.collapse();
          SearchCubit.get(context).search(
              name: searchWord,
              cashWordInHistory: false);
          searchController.text = searchWord;
        },
        child: Container(
          color: Colors.grey[100],
          child: Align(
            alignment: Alignment.topRight,
            child: Padding(
              padding: EdgeInsets.symmetric(
                horizontal:
                context.deviceWidth * 0.04,
                vertical:
                context.deviceHeight * 0.007,
              ),
              child: Text(
                searchWord,
                style: TextStyle(fontSize: 20.sp),
              ),
            ),
          ),
        ),
      ))
          .toList(),
    );
  }
}
