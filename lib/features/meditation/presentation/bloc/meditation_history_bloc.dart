import 'dart:io';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:m4m_f/features/meditation/data/repositories/meditation_history_repository.dart';

part 'meditation_history_event.dart';
part 'meditation_history_state.dart';

class MeditationHistoryBloc
    extends Bloc<MeditationHistoryEvent, MeditationHistoryState> {
  final MeditationHistoryRepository repository;

  MeditationHistoryBloc(this.repository) : super(MeditationHistoryLoading()) {
    on<LoadMeditationHistory>((event, emit) async {
      emit(MeditationHistoryLoading());
      try {
        final history = await repository.fetchMeditationHistory();
        emit(MeditationHistoryLoaded(history));
      } catch (e) {
        emit(MeditationHistoryError('Failed to load meditation history.'));
      }
    });

    on<DeleteMeditation>((event, emit) async {
      try {
        await repository.deleteMeditation(event.file);
        add(LoadMeditationHistory());
      } catch (e) {
        emit(MeditationHistoryError('Failed to delete meditation.'));
      }
    });

    on<RenameMeditation>((event, emit) async {
      try {
        await repository.renameMeditation(event.file, event.newName);
        add(LoadMeditationHistory());
      } catch (e) {
        emit(MeditationHistoryError('Failed to rename meditation.'));
      }
    });
  }
}
