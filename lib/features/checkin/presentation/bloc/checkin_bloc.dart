import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/entities/checkin_entity.dart';
import '../../domain/usecases/add_checkin.dart';
import '../../domain/usecases/get_checkins.dart';

part 'checkin_event.dart';
part 'checkin_state.dart';

class CheckinBloc extends Bloc<CheckinEvent, CheckinState> {
  final AddCheckin addCheckin;
  final GetCheckins getCheckins;

  CheckinBloc({required this.addCheckin, required this.getCheckins})
      : super(CheckinInitial()) {
    on<AddCheckinEvent>(_onAddCheckin);
    on<LoadCheckinsEvent>(_onLoadCheckins);
  }

  Future<void> _onAddCheckin(
      AddCheckinEvent event, Emitter<CheckinState> emit) async {
    emit(CheckinLoading());
    final result = await addCheckin(event.checkin);
    result.fold(
      (failure) => emit(CheckinError('Failed to add checkin')),
      (_) => emit(CheckinAdded()),
    );
  }

  Future<void> _onLoadCheckins(
      LoadCheckinsEvent event, Emitter<CheckinState> emit) async {
    emit(CheckinLoading());
    final result = await getCheckins();
    result.fold(
      (failure) => emit(CheckinError('Failed to load checkins')),
      (checkins) => emit(CheckinsLoaded(checkins)),
    );
  }
}
