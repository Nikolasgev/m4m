import 'package:flutter/material.dart';
import 'package:m4m_f/core/network/api_constants.dart';
import 'package:provider/provider.dart';

import 'core/network/api_client.dart';
import 'features/meditation/data/datasources/meditation_remote_data_source.dart';
import 'features/meditation/data/repositories/meditation_repository_impl.dart';
import 'features/meditation/domain/usecases/generate_meditation.dart';
import 'features/meditation/presentation/pages/meditation_input_page.dart';

void main() {
  // Setup API client and dependencies
  final apiClient = ApiClient(baseURL);
  final remoteDataSource = MeditationRemoteDataSourceImpl(apiClient);
  final meditationRepository =
      MeditationRepositoryImpl(remoteDataSource: remoteDataSource);
  final generateMeditation = GenerateMeditation(meditationRepository);

  runApp(
    MultiProvider(
      providers: [
        Provider<GenerateMeditation>(create: (_) => generateMeditation),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Meditation App',
      home: MeditationInputPage(),
    );
  }
}
