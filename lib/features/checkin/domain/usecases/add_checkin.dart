import 'package:dartz/dartz.dart';
import '../repositories/checkin_repository.dart';
import '../entities/checkin_entity.dart';

class AddCheckin {
  final CheckinRepository repository;

  AddCheckin(this.repository);

  Future<Either<Exception, void>> call(CheckinEntity checkin) async {
    return await repository.addCheckin(checkin);
  }
}