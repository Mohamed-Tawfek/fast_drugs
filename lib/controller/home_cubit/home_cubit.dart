import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

import '../../view/screens/donation_screen.dart';
import '../../view/screens/location_screen.dart';
import '../../view/screens/search_screen.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit() : super(HomeInitial());
  static HomeCubit get(context) => BlocProvider.of(context);
  List<Widget> screens =   [
    SearchScreen(),
    const LocationScreen(),
    const DonationScreen()
  ];
  int currentIndex = 0;
  void bottomNavOnTap(int index) {
    currentIndex=index;
    emit(ChangeBottomNavState());
  }
}
