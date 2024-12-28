import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:m4m_f/core/network/api_client.dart';
import 'package:m4m_f/core/network/api_constants.dart';
import 'package:m4m_f/features/meditation/presentation/bloc/auth_bloc.dart';
import 'package:m4m_f/features/meditation/presentation/pages/login_page.dart';
import 'package:provider/provider.dart';

import 'features/meditation/data/datasources/meditation_remote_data_source.dart';
import 'features/meditation/data/repositories/meditation_repository_impl.dart';
import 'features/meditation/domain/usecases/generate_meditation.dart';
import 'features/meditation/presentation/pages/main_navigation.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

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
        BlocProvider(
          create: (context) =>
              AuthBloc(FirebaseAuth.instance)..add(CheckAuthStatusEvent()),
        ),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Meditation App',
      home: BlocBuilder<AuthBloc, AuthState>(
        builder: (context, state) {
          if (state is AuthAuthenticated) {
            return const MainNavigation();
          } else {
            return LoginPage();
          }
        },
      ),
    );
  }
}
