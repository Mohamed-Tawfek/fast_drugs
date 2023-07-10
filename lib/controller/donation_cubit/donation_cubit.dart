import 'package:fast_drugs/helpers/dio_helper.dart';
import 'package:fast_drugs/shared/components/custom_snackBar.dart';
import 'package:fast_drugs/shared/components/dialogs.dart';
import 'package:fast_drugs/shared/components/extensions.dart';
import 'package:fast_drugs/shared/constants/api_constants.dart';
import 'package:fast_drugs/shared/constants/app_strings.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

import '../../helpers/cash_helper.dart';
import '../../models/association_model.dart';

part 'donation_state.dart';

class DonationCubit extends Cubit<DonationState> {
  DonationCubit() : super(DonationInitial());
  static DonationCubit get(context) => BlocProvider.of(context);
  List<AssociationModel> associations = [];
  AssociationModel? choseAssociation;
  String userID = CashHelper.getData(key: 'userID');
  Future<void> getAssociations() async {
    emit(GetAssociationsLoading());
    associations = [];
    DioHelper.getData(endPoint: ApiConstants.associationsPoint).then((value) {
      List data = value.data;
      data.forEach((association) {
        associations.add(AssociationModel.fromJson(association));
      });
      emit(GetAssociationsSuccess());
    }).catchError((error) {
      print(error.toString());
      emit(GetAssociationsError());
    });
  }

  Future<void> donate(
      {required String drugName,
      required String expirationDate,
      required String quantity,
      required String phone,
      required String address,
      required BuildContext context}) async {
    emit(DonateLoading());
    showProgressDialog(context);

    DioHelper.postData(endPoint: ApiConstants.donateEndPoint, data: {
      "DrugName": drugName,
      "ExpirationDate": expirationDate,
      "Quantity": quantity,
      "Phone": phone,
      "Address": address,
      "donatedBy": userID,
      "association": choseAssociation!.id
    }).then((value) {
      print(value);
      emit(DonateSuccess());
      context.pop();

      showCustomSnackBar(context, AppStrings.donationDone);
    }).catchError((error) {
      context.pop();
      showErrorDialog(context: context, message: AppStrings.error);
      emit(DonateError());
    });
  }
}
