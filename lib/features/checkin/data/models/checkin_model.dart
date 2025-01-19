import 'package:hive/hive.dart';

part 'checkin_model.g.dart';

@HiveType(typeId: 1)
class CheckinModel {
  @HiveField(0)
  final String mood;

  @HiveField(1)
  final String energy;

  @HiveField(2)
  final String stress;

  @HiveField(3)
  final String? notes;

  @HiveField(4)
  final DateTime date;

  CheckinModel({
    required this.mood,
    required this.energy,
    required this.stress,
    this.notes,
    required this.date,
  });
}