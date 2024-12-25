part of 'meditation_bloc.dart';

abstract class MeditationEvent {}

class GenerateMeditationEvent extends MeditationEvent {
  final Map<String, dynamic> prompt;

  GenerateMeditationEvent({required this.prompt});
}

class ResetMeditationState extends MeditationEvent {}

class ToggleCategorySelection extends MeditationEvent {
  final String category;

  ToggleCategorySelection(this.category);
}
