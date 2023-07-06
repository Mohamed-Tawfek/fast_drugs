import 'package:fast_drugs/controller/search_cubit/search_cubit.dart';
import 'package:fast_drugs/shared/components/extensions.dart';
import 'package:fast_drugs/view/component/search_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../component/searched_items_view.dart';

class SearchScreen extends StatelessWidget {
  SearchScreen({Key? key}) : super(key: key);
  final TextEditingController _searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: BlocProvider(
          create: (context) => SearchCubit(),
          child: BlocBuilder<SearchCubit, SearchState>(
            builder: (context, state) {
              return Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: context.deviceWidth * 0.03,
                    vertical: context.deviceHeight * 0.02),
                child: SizedBox(
                  height: context.deviceHeight,
                  child: Stack(
                    children: [
                      BuildSearchedItemsView(
                        searchedList: SearchCubit.get(context).searchedData,
                        state: state,
                      ),
                      BuildSearchBar(searchController: _searchController),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
