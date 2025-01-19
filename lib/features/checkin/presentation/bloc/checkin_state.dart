part of 'checkin_bloc.dart';

abstract class CheckinState {}

class CheckinInitial extends CheckinState {}

class CheckinLoading extends CheckinState {}

class CheckinAdded extends CheckinState {}

class CheckinsLoaded extends CheckinState {
  final List<CheckinEntity> checkins;

  CheckinsLoaded(this.checkins);
}

class CheckinError extends CheckinState {
  final String message;

  CheckinError(this.message);
}
