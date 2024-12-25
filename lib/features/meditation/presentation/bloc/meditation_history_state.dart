part of 'meditation_history_bloc.dart';

abstract class MeditationHistoryState extends Equatable {
  @override
  List<Object?> get props => [];
}

class MeditationHistoryLoading extends MeditationHistoryState {}

class MeditationHistoryLoaded extends MeditationHistoryState {
  final List<File> history;

  MeditationHistoryLoaded(this.history);

  @override
  List<Object?> get props => [history];
}

class MeditationHistoryError extends MeditationHistoryState {
  final String message;

  MeditationHistoryError(this.message);

  @override
  List<Object?> get props => [message];
}
