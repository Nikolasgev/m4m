part of 'checkin_bloc.dart';

abstract class CheckinEvent {}

class AddCheckinEvent extends CheckinEvent {
  final CheckinEntity checkin;

  AddCheckinEvent(this.checkin);
}

class LoadCheckinsEvent extends CheckinEvent {}