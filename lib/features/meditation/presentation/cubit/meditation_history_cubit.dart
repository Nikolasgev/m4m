import 'dart:io';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:path_provider/path_provider.dart';

part 'meditation_history_state.dart';

class MeditationHistoryCubit extends Cubit<MeditationHistoryState> {
  MeditationHistoryCubit() : super(MeditationHistoryLoading()) {
    loadMeditationFiles();
  }

  Future<void> loadMeditationFiles() async {
    emit(MeditationHistoryLoading());
    try {
      final directory = await getApplicationDocumentsDirectory();
      final files = directory.listSync().whereType<File>().toList();
      emit(MeditationHistoryLoaded(files));
    } catch (e) {
      emit(MeditationHistoryError('Failed to load meditation files.'));
    }
  }

  Future<void> renameFile(File file, String newName) async {
    try {
      final directory = await getApplicationDocumentsDirectory();
      final newPath = '${directory.path}/$newName';
      await file.rename(newPath);
      loadMeditationFiles();
    } catch (e) {
      emit(MeditationHistoryError('Failed to rename file.'));
    }
  }

  Future<void> deleteFile(File file) async {
    try {
      await file.delete();
      loadMeditationFiles();
    } catch (e) {
      emit(MeditationHistoryError('Failed to delete file.'));
    }
  }
}
