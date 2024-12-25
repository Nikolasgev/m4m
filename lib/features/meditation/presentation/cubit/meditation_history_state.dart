part of 'meditation_history_cubit.dart';

abstract class MeditationHistoryState extends Equatable {
  @override
  List<Object?> get props => [];
}

class MeditationHistoryLoading extends MeditationHistoryState {}

class MeditationHistoryLoaded extends MeditationHistoryState {
  final List<File> files;

  MeditationHistoryLoaded(this.files);

  @override
  List<Object?> get props => [files];
}

class MeditationHistoryError extends MeditationHistoryState {
  final String message;

  MeditationHistoryError(this.message);

  @override
  List<Object?> get props => [message];
}
