import 'package:bloc/bloc.dart';
import 'package:fast_drugs/helpers/dio_helper.dart';
import 'package:fast_drugs/shared/constants/api_constants.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

import '../../models/notification_model.dart';

part 'notification_state.dart';

class NotificationCubit extends Cubit<NotificationState> {
  NotificationCubit() : super(NotificationInitial());
  List<NotificationModel> notifications = [];
  static NotificationCubit get(context) => BlocProvider.of(context);
  Future<void> getAllNotifications() async {
    emit(GetNotificationLoading());
    DioHelper.getData(endPoint: ApiConstants.notifyEndPoint).then((value) {
      List data = value.data;

      data.forEach((notify) {
        notifications.add(NotificationModel.fromJson(notify));
      });

      emit(GetNotificationSuccess());
    }).catchError((error) {
      emit(GetNotificationError());
    });
  }
}
