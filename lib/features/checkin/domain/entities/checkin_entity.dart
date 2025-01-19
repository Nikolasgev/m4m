class CheckinEntity {
  final String mood;
  final String energy;
  final String stress;
  final String? notes;
  final DateTime date;

  CheckinEntity({
    required this.mood,
    required this.energy,
    required this.stress,
    this.notes,
    required this.date,
  });
}