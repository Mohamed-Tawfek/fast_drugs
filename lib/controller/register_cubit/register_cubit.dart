import 'package:bloc/bloc.dart';
import 'package:fast_drugs/helpers/dio_helper.dart';
import 'package:fast_drugs/models/user_model.dart';
import 'package:fast_drugs/shared/components/dialogs.dart';
import 'package:fast_drugs/shared/constants/api_constants.dart';
import 'package:fast_drugs/shared/constants/app_strings.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

import '../../helpers/cash_helper.dart';

part 'register_state.dart';

class RegisterCubit extends Cubit<RegisterState> {
  RegisterCubit() : super(RegisterInitial());
  static RegisterCubit get(context) => BlocProvider.of(context);
  UserModel? user;
  List<String> roles = [
    AppStrings.user,
    AppStrings.association,

  ];
  String chosenRole = AppStrings.user;

  Future<void> createAccount({
    required String firstName,
    required String lastName,
    required String email,
    required String password,
    required String confirmPassword,
  }) async {
    emit(CreateAccountInProgress());
    Map<String, dynamic>? sentData = {
      "FirstName": firstName,
      "LastName": lastName,
      "Email": email,
      "Password": password,
      "ConfirmPassword": confirmPassword,
      "role":translateRole()
    };
    DioHelper.postData(endPoint: ApiConstants.registerEndPoint, data: sentData)
        .then((value) {
      user = UserModel.fromJson(value.data['user']);
      if (user != null) {
        CashHelper.setData(key: 'userID', value: user!.id);
        CashHelper.setData(key: 'role', value: user!.role);
        CashHelper.setData(key: 'token', value: value.data['token']);

      }

      emit(CreateAccountSuccess());
    }).catchError((error) {
      emit(CreateAccountError(AppStrings.error));
    });
  }
  void changeRole({required String role}){
    chosenRole=role;
    emit(ChangeRole());

  }
   String translateRole(){
    if(chosenRole==AppStrings.user){
      return 'USER';
    }
    else{
      return 'ASSOCIATION';

    }
    }
}
