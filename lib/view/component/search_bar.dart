import 'package:fast_drugs/app.dart';
import 'package:fast_drugs/shared/components/extensions.dart';
import 'package:fast_drugs/shared/constants/dark_theme_colors.dart';
import 'package:fast_drugs/shared/constants/light_theme_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../controller/mode_cubit/mode_cubit.dart';
import '../../controller/search_cubit/search_cubit.dart';
import '../../shared/components/components.dart';

final expansionController = ExpansionTileController();

class BuildSearchBar extends StatefulWidget {
  BuildSearchBar({super.key, required this.searchController});
  final TextEditingController searchController;

  @override
  State<BuildSearchBar> createState() => _BuildSearchBarState();
}

class _BuildSearchBarState extends State<BuildSearchBar> {
  @override
  Widget build(BuildContext context) {
    return Container(

      child: Stack(
        children: [
          ExpansionTile(

            trailing: Text(''),
            controller: expansionController,
            title: Text(''),
            children: SearchCubit.get(context)
                .historySearch
                .map((searchWord) => InkWell(
                      onTap: () {
                        _historyItemOnTap(context, searchWord);
                      },
                      child: HistoryItem(searchWord: searchWord),
                    ))
                .toList(),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              SizedBox(
                width: context.deviceWidth * 0.8,
                child: DefaultFormField(

                  controller: widget.searchController,
                  suffix: widget.searchController.text.isNotEmpty
                      ? Icons.close
                      : null,
                  suffixOnPressed: () {
                    setState(() {
                      widget.searchController.clear();
                    });
                  },
                  onChange: (word) {
                    setState(() {});

                    SearchCubit.get(context).search(name: word);
                  },
                  onSubmit: (String word) {

                  },
                ),
              ),
              IconButton(
                icon: const Icon(Icons.history),
                color: ModeCubit.isDark? DarkColors.textField:LightColors.textField,
                onPressed: () {
                  _historyIconOnTap();
                },
              ),
            ],
          )
        ],
      ),
    );
  }

  void _historyItemOnTap(BuildContext context, searchWord) {
    expansionController.collapse();
    SearchCubit.get(context).search(name: searchWord, cashWordInHistory: false);
    widget.searchController.text = searchWord;
  }

  void _historyIconOnTap() {
    if (expansionController.isExpanded) {
      expansionController.collapse();
    } else {
      expansionController.expand();
    }
  }
}

class HistoryItem extends StatelessWidget {
  const HistoryItem({super.key, required this.searchWord});
  final String searchWord;
  @override
  Widget build(BuildContext context) {
    return Container(
      color:ModeCubit.isDark? DarkColors.ExpansionTileChildrenBackground:LightColors.ExpansionTileChildrenBackground,
      child: Align(
        alignment: Alignment.topRight,
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: context.deviceWidth * 0.04,
            vertical: context.deviceHeight * 0.007,
          ),
          child: Text(
            searchWord,
            style: TextStyle(fontSize: 20.sp,color: ModeCubit.isDark?DarkColors.ExpansionTileChildren:LightColors.ExpansionTileChildren,),
          ),
        ),
      ),
    );
  }
}
