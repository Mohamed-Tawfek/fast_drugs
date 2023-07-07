part of 'notification_cubit.dart';

@immutable
abstract class NotificationState {}

class NotificationInitial extends NotificationState {}

class GetNotificationSuccess extends NotificationState {}
class GetNotificationLoading extends NotificationState {}
class GetNotificationError extends NotificationState {}
