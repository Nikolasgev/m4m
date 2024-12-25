import 'package:dartz/dartz.dart';
import 'package:m4m_f/core/errors/failures.dart';

import '../../domain/entities/meditation_entity.dart';
import '../../domain/repositories/meditation_repository.dart';
import '../datasources/meditation_remote_data_source.dart';

class MeditationRepositoryImpl implements MeditationRepository {
  final MeditationRemoteDataSource remoteDataSource;

  MeditationRepositoryImpl({required this.remoteDataSource});

  @override
  Future<Either<Failure, MeditationEntity>> generateMeditation(
      String prompt) async {
    try {
      final audioFile = await remoteDataSource.generateMeditation(prompt);
      return Right(MeditationEntity(
        text: 'Generated Meditation Text',
        audioFile: audioFile,
      ));
    } catch (e) {
      return Left(ServerFailure('Failed to generate meditation 03'));
    }
  }
}
