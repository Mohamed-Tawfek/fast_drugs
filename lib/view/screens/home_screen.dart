 import 'package:fast_drugs/controller/home_cubit/home_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../shared/constants/app_strings.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => HomeCubit(),
      child: BlocBuilder<HomeCubit, HomeState>(
        builder: (context, state) {
          HomeCubit cubit = HomeCubit.get(context);
          return Scaffold(
            body: IndexedStack(
              index: cubit.currentIndex,
              children: cubit.screens,

            ),
            bottomNavigationBar: BottomNavigationBar(
              type:BottomNavigationBarType.fixed,
            currentIndex: cubit.currentIndex,
            onTap: (int index) {
              cubit.bottomNavOnTap(index);
            },
            items: _buildBottomNavItems(),
          ),
          );
          // return Scaffold(
          //   body: cubit.screens[cubit.currentIndex],

         // );
        },
      ),
    );
  }

  List<BottomNavigationBarItem> _buildBottomNavItems() {
    return const [
      BottomNavigationBarItem(
          icon: Icon(Icons.search), label: AppStrings.search),
      BottomNavigationBarItem(
          icon: Icon(Icons.location_on_sharp), label: AppStrings.location),
      BottomNavigationBarItem(
        icon: Icon(Icons.volunteer_activism),
        label: AppStrings.donation,
      ),
      BottomNavigationBarItem(
        icon: Icon(Icons.settings),
        label: AppStrings.settings,
      ),
    ];
  }
}
