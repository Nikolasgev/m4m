import 'dart:io';

import 'package:m4m_f/core/network/api_client.dart';
import 'package:m4m_f/core/network/api_constants.dart';

abstract class MeditationRemoteDataSource {
  Future<File> generateMeditation(String prompt);
}

class MeditationRemoteDataSourceImpl implements MeditationRemoteDataSource {
  final ApiClient client;

  MeditationRemoteDataSourceImpl(this.client);

  @override
  Future<File> generateMeditation(String prompt) async {
    final response = await client.post(baseURL, {'prompt': prompt});
    if (response.statusCode == 200) {
      print('---200---');
      final file = File('output.mp3');
      await file.writeAsBytes(response.bodyBytes);
      return file;
    } else {
      throw Exception('Failed to generate meditation 04');
    }
  }
}
