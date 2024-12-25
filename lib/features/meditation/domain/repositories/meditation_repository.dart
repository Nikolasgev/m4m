import 'package:dartz/dartz.dart';
import 'package:m4m_f/core/errors/failures.dart';

import '../entities/meditation_entity.dart';

abstract class MeditationRepository {
  Future<Either<Failure, MeditationEntity>> generateMeditation(String prompt);
}
