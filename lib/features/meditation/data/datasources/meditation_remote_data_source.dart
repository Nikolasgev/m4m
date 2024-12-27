import 'dart:io';

import 'package:m4m_f/core/network/api_client.dart';
import 'package:m4m_f/core/network/api_constants.dart';
import 'package:m4m_f/meditation/data/datasources/meditation_remote_data_source.dart';
import 'package:path_provider/path_provider.dart';

class MeditationRemoteDataSourceImpl implements MeditationRemoteDataSource {
  final ApiClient client;

  MeditationRemoteDataSourceImpl(this.client);

  @override
  Future<File> generateMeditation(String prompt) async {
    try {
      print(
          'RemoteDataSource: Sending POST request to $baseURL with prompt: $prompt');
      final response = await client.post(baseURL, {'prompt': prompt});

      print(
          'RemoteDataSource: Received response with status code: ${response.statusCode}');
      if (response.statusCode == 200) {
        // Получаем временную директорию
        final tempDir = await getApplicationDocumentsDirectory();
        final filePath =
            '${tempDir.path}/output_${DateTime.now().millisecondsSinceEpoch}.mp3';

        // Сохраняем файл в указанную директорию
        final file = File(filePath);
        await file.writeAsBytes(response.bodyBytes);
        print('RemoteDataSource: File saved at $filePath');
        return file;
      } else {
        throw Exception('Failed with status code: ${response.statusCode}');
      }
    } catch (e) {
      print('RemoteDataSource: Error occurred: $e');
      throw Exception('Error in RemoteDataSource: $e');
    }
  }
}
