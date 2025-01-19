import 'package:dartz/dartz.dart';
import '../repositories/checkin_repository.dart';
import '../entities/checkin_entity.dart';

class GetCheckins {
  final CheckinRepository repository;

  GetCheckins(this.repository);

  Future<Either<Exception, List<CheckinEntity>>> call() async {
    return await repository.getCheckins();
  }
}