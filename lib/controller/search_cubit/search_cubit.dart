import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:fast_drugs/helpers/cash_helper.dart';
import 'package:fast_drugs/helpers/dio_helper.dart';
import 'package:fast_drugs/shared/constants/api_constants.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

import '../../models/drug_model.dart';

part 'search_state.dart';

class SearchCubit extends Cubit<SearchState> {
  SearchCubit() : super(SearchInitial()) {
     String? history = CashHelper.getData(key: 'historySearch');
    historySearch = history !=null?jsonDecode(history):[];
  }
  static SearchCubit get(context) => BlocProvider.of(context);
  List<DrugModel> searchedData = [];
  List  historySearch = [];
  Future<void> search({required String name,bool cashWordInHistory=true}) async {
    searchedData = [];
    emit(GetSearchDataLoadingState());
    DioHelper.getData(endPoint: '${ApiConstants.searchEndPoint}$name')
        .then((value) {
          if(cashWordInHistory) {
            if (name.isNotEmpty) {
              historySearch.add(name);
              CashHelper.setData(
                  key: 'historySearch', value: jsonEncode(historySearch));
            }
          }

      for (var drug in value.data) {
        searchedData.add(DrugModel.fromJson(drug));
      }
      emit(GetSearchDataSuccessState());
    }).catchError((error) {
      emit(GetSearchDataErrorState());
    });
  }
}
