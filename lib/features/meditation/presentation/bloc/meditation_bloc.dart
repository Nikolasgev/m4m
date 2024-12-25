import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:m4m_f/features/meditation/domain/entities/meditation_entity.dart';

import '../../domain/usecases/generate_meditation.dart';

part 'meditation_event.dart';
part 'meditation_state.dart';

class MeditationBloc extends Bloc<MeditationEvent, MeditationState> {
  final GenerateMeditation generateMeditation;

  MeditationBloc(this.generateMeditation) : super(MeditationInitial()) {
    on<GenerateMeditationEvent>((event, emit) async {
      emit(MeditationLoading());
      final result = await generateMeditation(
          GenerateMeditationParams(prompt: event.prompt));
      result.fold(
        (failure) => emit(MeditationError(failure.message)),
        (meditation) => emit(MeditationLoaded(meditation)),
      );
    });

    on<ResetMeditationState>((event, emit) {
      emit(MeditationInitial());
    });
  }
}
