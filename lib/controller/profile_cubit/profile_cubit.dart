import 'package:bloc/bloc.dart';
import 'package:fast_drugs/helpers/cash_helper.dart';
import 'package:fast_drugs/helpers/dio_helper.dart';
import 'package:fast_drugs/shared/constants/api_constants.dart';
import 'package:fast_drugs/view/screens/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

import '../../models/user_model.dart';

part 'profile_state.dart';

class ProfileCubit extends Cubit<ProfileState> {
  ProfileCubit() : super(ProfileInitial());
  UserModel? currentUser;
  late String userID;
  static ProfileCubit get(context) => BlocProvider.of(context);
  Future<void> getUserData() async {
    emit(GetUserDataLoadingState());
    userID = CashHelper.getData(key: 'userID');
    await DioHelper.getData(endPoint: '${ApiConstants.registerEndPoint}/$userID',)
        .then((value) {
      currentUser = UserModel.fromJson(value.data);
      emit(GetUserDataSuccessState());
    }).catchError((error) {
      emit(GetUserDataErrorState());
    });
  }

  Future<void> changeFirstName({required String name}) async {
    emit(ChangeFirstNameLoadingState());
    await DioHelper.putData(
        url: '${ApiConstants.registerEndPoint}/$userID',
        data: {'FirstName': name}).then((value) {
      currentUser = UserModel.fromJson(value.data);
      emit(ChangeFirstNameSuccessState());
    }).catchError((error) {
      emit(ChangeFirstNameErrorState());
    });
  }

  Future<void> changeLastName({required String name}) async {
    emit(ChangeLastNameLoadingState());
    await DioHelper.putData(
        url: '${ApiConstants.registerEndPoint}/$userID',
        data: {'LastName': name}).then((value) {
      currentUser = UserModel.fromJson(value.data);
      emit(ChangeLastNameSuccessState());
    }).catchError((error) {
      emit(ChangeLastNameErrorState());
    });
  }

  Future<void> changeEmail({required String email}) async {
    emit(ChangeEmailLoadingState());
    await DioHelper.putData(
        url: '${ApiConstants.registerEndPoint}/$userID',
        data: {'Email': email}).then((value) {
      currentUser = UserModel.fromJson(value.data);
      emit(ChangeEmailSuccessState());
    }).catchError((error) {
      emit(ChangeEmailErrorState());
    });
  }

  Future<void> changePassword({required String password}) async {
    emit(ChangePasswordLoadingState());
    await DioHelper.putData(
        url: '${ApiConstants.registerEndPoint}/$userID',
        data: {'Password': password}).then((value) {
      currentUser = UserModel.fromJson(value.data);
      emit(ChangePasswordSuccessState());
    }).catchError((error) {
      emit(ChangePasswordErrorState());
    });
  }

  Future<void> logout(context) async {
    emit(LogoutLoadingState());
    DioHelper.patchData(url: '${ApiConstants.logoutEndPoint}/$userID')
        .then((value) {
      emit(LogoutSuccessState());
      CashHelper.remove(key: 'userID').then((value) {
        CashHelper.remove(key: 'historySearch');
        Navigator.pushAndRemoveUntil(context,
            MaterialPageRoute(builder: (_) => LoginScreen()), (route) => false);
      }).catchError((error) {
        emit(LogoutErrorState());
        Navigator.pop(context);
        Navigator.pop(context);
      });
    });
  }

  Future<void> removeAccount(context) async {
    emit(RemoveAccountLoadingState());
    DioHelper.delete(url: '${ApiConstants.registerEndPoint}/$userID')
        .then((value) {

      emit(RemoveAccountSuccessState());
      CashHelper.remove(key: 'userID').then((value) {
        CashHelper.remove(key: 'historySearch');
        Navigator.pushAndRemoveUntil(context,
            MaterialPageRoute(builder: (_) => LoginScreen()), (route) => false);
      }).catchError((error) {
        emit(RemoveAccountErrorState());
        Navigator.pop(context);
        Navigator.pop(context);
      });
    });
  }
}
