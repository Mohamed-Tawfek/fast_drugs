import 'package:bloc/bloc.dart';
import 'package:fast_drugs/helpers/cash_helper.dart';
import 'package:fast_drugs/helpers/dio_helper.dart';
import 'package:fast_drugs/shared/constants/api_constants.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

import '../../models/user_model.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit() : super(LoginInitial());
 static LoginCubit get(context)=>BlocProvider.of(context);
  UserModel? user;
 Future userLogin({
    required String email,
    required String password,
  }) async{
    emit(LoginUserInProgress());
    Map<String, dynamic>? sentData = {
      "Email": email,
      "Password": password,
    };

    DioHelper.postData(endPoint: ApiConstants.loginEndPoint, data: sentData)
        .then((value) {
      user = UserModel.fromJson(value.data['user']);
      print('*'*50);
      print(user!.role);
      print('*'*50);
      if (user != null) {
        CashHelper.setData(key: 'userID', value: user!.id);
        CashHelper.setData(key: 'role', value: user!.role);
        CashHelper.setData(key: 'token', value: value.data['token']);

      }
      emit(LoginUserSuccess());
    }).catchError((error) {
      emit(LoginUserError('ERROR'));
    });
  }
}
