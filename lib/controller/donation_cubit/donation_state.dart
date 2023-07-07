part of 'donation_cubit.dart';

@immutable
abstract class DonationState {}

class DonationInitial extends DonationState {}
class GetAssociationsLoading extends DonationState {}
class GetAssociationsSuccess extends DonationState {}
class GetAssociationsError extends DonationState {}
class DonateLoading extends DonationState {}
class DonateSuccess extends DonationState {}
class DonateError extends DonationState {}
