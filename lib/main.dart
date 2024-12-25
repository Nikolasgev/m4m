import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:m4m_f/core/network/api_client.dart';
import 'package:m4m_f/core/network/api_constants.dart';
import 'package:m4m_f/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:m4m_f/features/auth/presentation/pages/login_page.dart';
import 'package:m4m_f/features/meditation/domain/repositories/meditation_repository.dart';
import 'package:provider/provider.dart';

import 'features/meditation/data/datasources/meditation_remote_data_source.dart';
import 'features/meditation/data/repositories/meditation_repository_impl.dart';
import 'features/meditation/domain/usecases/generate_meditation.dart';
import 'features/meditation/presentation/pages/main_navigation.dart';

final getIt = GetIt.instance;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  getIt.registerSingleton<ApiClient>(ApiClient(baseURL));
  getIt.registerSingleton<MeditationRemoteDataSource>(
      MeditationRemoteDataSourceImpl(getIt<ApiClient>()));
  getIt.registerSingleton<MeditationRepository>(MeditationRepositoryImpl(
      remoteDataSource: getIt<MeditationRemoteDataSource>()));
  getIt.registerSingleton<GenerateMeditation>(
      GenerateMeditation(getIt<MeditationRepository>()));

  runApp(
    MultiProvider(
      providers: [
        Provider<GenerateMeditation>(
            create: (_) => getIt<GenerateMeditation>()),
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
