import 'package:audioplayers/audioplayers.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'audio_player_state.dart';

class AudioPlayerCubit extends Cubit<AudioPlayerState> {
  final AudioPlayer _audioPlayer;

  AudioPlayerCubit(this._audioPlayer)
      : super(AudioPlayerState(
          duration: Duration.zero,
          position: Duration.zero,
          isPlaying: false,
        )) {
    _initializeListeners();
  }

  void _initializeListeners() {
    _audioPlayer.onDurationChanged.listen((newDuration) {
      emit(state.copyWith(duration: newDuration));
    });

    _audioPlayer.onPositionChanged.listen((newPosition) {
      emit(state.copyWith(position: newPosition));
    });

    _audioPlayer.onPlayerComplete.listen((_) {
      emit(state.copyWith(position: Duration.zero, isPlaying: false));
    });
  }

  Future<void> play(String filePath) async {
    await _audioPlayer.setSource(DeviceFileSource(filePath));
    await _audioPlayer.resume();
    emit(state.copyWith(isPlaying: true));
  }

  Future<void> pause() async {
    await _audioPlayer.pause();
    emit(state.copyWith(isPlaying: false));
  }

  Future<void> stop() async {
    await _audioPlayer.stop();
    emit(state.copyWith(position: Duration.zero, isPlaying: false));
  }

  Future<void> seek(Duration position) async {
    await _audioPlayer.seek(position);
    emit(state.copyWith(position: position));
  }

  @override
  Future<void> close() {
    _audioPlayer.dispose();
    return super.close();
  }
}
