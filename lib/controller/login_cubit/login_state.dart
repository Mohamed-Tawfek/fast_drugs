part of 'login_cubit.dart';

@immutable
abstract class LoginState {}

class LoginInitial extends LoginState {}
class LoginUserInProgress extends LoginState {}
class LoginUserSuccess extends LoginState {}
class LoginUserError extends LoginState {
   final String error;
    LoginUserError(this.error);
}

