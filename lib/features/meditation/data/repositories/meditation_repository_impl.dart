// ignore_for_file: avoid_print

import 'package:dartz/dartz.dart';
import 'package:m4m_f/core/errors/failures.dart';
import 'package:m4m_f/features/meditation/data/datasources/meditation_remote_data_source.dart';

import '../../domain/entities/meditation_entity.dart';
import '../../domain/repositories/meditation_repository.dart';

class MeditationRepositoryImpl implements MeditationRepository {
  final MeditationRemoteDataSource remoteDataSource;

  MeditationRepositoryImpl({required this.remoteDataSource});

  @override
  Future<Either<Failure, MeditationEntity>> generateMeditation(
      Map<String, dynamic> prompt) async {
    try {
      print(
          'Repository: Sending request to remote data source with prompt: $prompt');
      final audioFile = await remoteDataSource.generateMeditation(prompt);
      print('Repository: Received audio file at path: ${audioFile.path}');
      return Right(MeditationEntity(
        text: 'Generated Meditation Text',
        audioFile: audioFile,
      ));
    } catch (e) {
      print('Repository: Error occurred: $e');
      return Left(ServerFailure('Failed to generate meditation 03'));
    }
  }
}
