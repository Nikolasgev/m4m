part of 'meditation_history_bloc.dart';

abstract class MeditationHistoryEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class LoadMeditationHistory extends MeditationHistoryEvent {}

class DeleteMeditation extends MeditationHistoryEvent {
  final File file;

  DeleteMeditation(this.file);

  @override
  List<Object?> get props => [file];
}

class RenameMeditation extends MeditationHistoryEvent {
  final File file;
  final String newName;

  RenameMeditation(this.file, this.newName);

  @override
  List<Object?> get props => [file, newName];
}
