part of 'profile_cubit.dart';

@immutable
abstract class ProfileState {}

class ProfileInitial extends ProfileState {}

class GetUserDataLoadingState extends ProfileState {}
class GetUserDataSuccessState extends ProfileState {}
class GetUserDataErrorState extends ProfileState {}
class ChangeFirstNameLoadingState extends ProfileState {}
class ChangeFirstNameSuccessState extends ProfileState {}
class ChangeFirstNameErrorState extends ProfileState {}
class ChangeLastNameLoadingState extends ProfileState {}
class ChangeLastNameSuccessState extends ProfileState {}
class ChangeLastNameErrorState extends ProfileState {}
class ChangeEmailLoadingState extends ProfileState {}
class ChangeEmailSuccessState extends ProfileState {}
class ChangeEmailErrorState extends ProfileState {}
class ChangePasswordLoadingState extends ProfileState {}
class ChangePasswordSuccessState extends ProfileState {}
class ChangePasswordErrorState extends ProfileState {}

class LogoutLoadingState extends ProfileState {}
class LogoutSuccessState extends ProfileState {}
class LogoutErrorState extends ProfileState {}

class RemoveAccountLoadingState extends ProfileState {}
class RemoveAccountSuccessState extends ProfileState {}
class RemoveAccountErrorState extends ProfileState {}
