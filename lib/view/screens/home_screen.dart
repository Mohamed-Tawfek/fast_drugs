import 'package:fast_drugs/constants/app_strings.dart';
import 'package:fast_drugs/controller/home_cubit/home_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
            body: cubit.screens[cubit.currentIndex],
            bottomNavigationBar: BottomNavigationBar(
              currentIndex: cubit.currentIndex,
              onTap: (int index) {
                cubit.bottomNavOnTap(index);
              },
              items: _buildBottomNavItems(),
            ),
          );
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
        icon: Icon(Icons.business),
        label: AppStrings.donation,
      ),
    ];
  }
}
