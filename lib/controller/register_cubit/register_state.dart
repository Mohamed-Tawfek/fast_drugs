part of 'register_cubit.dart';

@immutable
abstract class RegisterState {}

class RegisterInitial extends RegisterState {}

class CreateAccountInProgress extends RegisterState {}
class CreateAccountSuccess extends RegisterState {}
class CreateAccountError extends RegisterState {
 final String errorMessage;
  CreateAccountError(this.errorMessage);
}
