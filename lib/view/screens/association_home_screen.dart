import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:fast_drugs/view/screens/settings_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../controller/home_cubit/home_cubit.dart';
import '../../shared/constants/light_theme_colors.dart';
import 'association_donations_screen.dart';

class  AssociationHomeScreen extends StatefulWidget {
    AssociationHomeScreen({super.key});
    List<Widget> screens = [

      AssociationDonationsScreen(),
      SettingsScreen(forUser: false),
    ];
  @override
  State<AssociationHomeScreen> createState() => _AssociationHomeScreenState();
}

class _AssociationHomeScreenState extends State<AssociationHomeScreen> {


  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: BlocProvider(
        create: (context) => HomeCubit(),
        child: BlocBuilder<HomeCubit, HomeState>(
          builder: (context, state) {
            HomeCubit cubit = HomeCubit.get(context);
            return Scaffold(
              body: IndexedStack(
                index: cubit.currentIndex,
                children:  widget.screens,
              ),
              bottomNavigationBar: CurvedNavigationBar(
                color: LightColors.primary,
                backgroundColor: Theme.of(context).scaffoldBackgroundColor,
                animationDuration: Duration(milliseconds: 400),
                index: cubit.currentIndex,
                onTap: (int index) {
                  cubit.bottomNavOnTap(index);
                },
                items: [
                  Icon(
                    Icons.notifications,
                    color: Theme.of(context).scaffoldBackgroundColor,
                  ),

                  Icon(Icons.settings,
                      color: Theme.of(context).scaffoldBackgroundColor)
                ],
              ),
            );
          },
        ),
      ),
    );

  }
}
