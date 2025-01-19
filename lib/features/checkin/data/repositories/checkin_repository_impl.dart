import 'package:dartz/dartz.dart';
import '../../domain/repositories/checkin_repository.dart';
import '../datasources/checkin_local_data_source.dart';
import '../models/checkin_model.dart';
import '../../domain/entities/checkin_entity.dart';

class CheckinRepositoryImpl implements CheckinRepository {
  final CheckinLocalDataSource localDataSource;

  CheckinRepositoryImpl(this.localDataSource);

  @override
  Future<Either<Exception, void>> addCheckin(CheckinEntity checkin) async {
    try {
      final model = CheckinModel(
        mood: checkin.mood,
        energy: checkin.energy,
        stress: checkin.stress,
        notes: checkin.notes,
        date: checkin.date,
      );
      await localDataSource.addCheckin(model);
      return const Right(null);
    } catch (e) {
      return Left(Exception('Failed to add checkin'));
    }
  }

  @override
  Future<Either<Exception, List<CheckinEntity>>> getCheckins() async {
    try {
      final models = localDataSource.getCheckins();
      final entities = models.map((model) => CheckinEntity(
            mood: model.mood,
            energy: model.energy,
            stress: model.stress,
            notes: model.notes,
            date: model.date,
          )).toList();
      return Right(entities);
    } catch (e) {
      return Left(Exception('Failed to fetch checkins'));
    }
  }
}