import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:fast_drugs/controller/home_cubit/home_cubit.dart';
import 'package:fast_drugs/view/screens/search_screen.dart';
import 'package:fast_drugs/view/screens/settings_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../shared/constants/light_theme_colors.dart';
import 'donation_screen.dart';
import 'location_screen.dart';

class UserHomeScreen extends StatefulWidget {
     UserHomeScreen({Key? key}) : super(key: key);
       List<Widget> screens = [
      SearchScreen(),
      LocationScreen(),
      DonationScreen(),
      SettingsScreen(),
    ];
  @override
  State<UserHomeScreen> createState() => _UserHomeScreenState();
}

class _UserHomeScreenState extends State<UserHomeScreen> {


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
                    Icons.search,
                    color: Theme.of(context).scaffoldBackgroundColor,
                  ),
                  Icon(Icons.location_on_sharp,
                      color: Theme.of(context).scaffoldBackgroundColor),
                  Icon(Icons.volunteer_activism,
                      color: Theme.of(context).scaffoldBackgroundColor),
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
