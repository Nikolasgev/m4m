import 'package:dartz/dartz.dart';
import '../entities/checkin_entity.dart';

abstract class CheckinRepository {
  Future<Either<Exception, void>> addCheckin(CheckinEntity checkin);
  Future<Either<Exception, List<CheckinEntity>>> getCheckins();
}