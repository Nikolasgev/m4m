part of 'meditation_bloc.dart';

abstract class MeditationState {}

class MeditationInitial extends MeditationState {
  final List<String> selectedCategories;

  MeditationInitial({this.selectedCategories = const []});
}

class MeditationLoading extends MeditationState {}

class MeditationLoaded extends MeditationState {
  final MeditationEntity meditation;

  MeditationLoaded(this.meditation);
}

class MeditationError extends MeditationState {
  final String message;

  MeditationError(this.message);
}
