import 'package:dartz/dartz.dart';
import 'package:m4m_f/core/errors/failures.dart';
import 'package:m4m_f/core/usecases/usecase.dart';
import '../entities/meditation_entity.dart';
import '../repositories/meditation_repository.dart';

class GenerateMeditation
    implements UseCase<MeditationEntity, GenerateMeditationParams> {
  final MeditationRepository repository;

  GenerateMeditation(this.repository);

  @override
  Future<Either<Failure, MeditationEntity>> call(
      GenerateMeditationParams params) {
    return repository.generateMeditation(params.prompt);
  }
}

class GenerateMeditationParams {
  final Map<String, dynamic> prompt;

  GenerateMeditationParams({required this.prompt});
}
