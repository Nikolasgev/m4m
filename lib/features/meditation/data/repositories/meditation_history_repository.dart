import 'dart:io';

import 'package:path_provider/path_provider.dart';

class MeditationHistoryRepository {
  Future<List<File>> fetchMeditationHistory() async {
    final directory = await getApplicationDocumentsDirectory();
    return directory.listSync().whereType<File>().toList();
  }

  Future<void> deleteMeditation(File file) async {
    await file.delete();
  }

  Future<void> renameMeditation(File file, String newName) async {
    final directory = await getApplicationDocumentsDirectory();
    final newFilePath = '${directory.path}/$newName.mp3';
    await file.rename(newFilePath);
  }
}
