part of 'search_cubit.dart';

@immutable
abstract class SearchState {}

class SearchInitial extends SearchState {}
class GetSearchDataLoadingState extends SearchState {}
class GetSearchDataSuccessState extends SearchState {}
class GetSearchDataErrorState extends SearchState {}
