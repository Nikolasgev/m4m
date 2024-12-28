import 'dart:async';

import 'package:audioplayers/audioplayers.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'audio_player_state.dart';

class AudioPlayerCubit extends Cubit<AudioPlayerState> {
  final AudioPlayer _audioPlayer;
  StreamSubscription<Duration>? _durationSubscription;
  StreamSubscription<Duration>? _positionSubscription;
  StreamSubscription<void>? _playerCompleteSubscription;

  AudioPlayerCubit(this._audioPlayer)
      : super(const AudioPlayerState(
          duration: Duration.zero,
          position: Duration.zero,
          isPlaying: false,
        )) {
    _initializeListeners();
  }

  void _initializeListeners() {
    _durationSubscription =
        _audioPlayer.onDurationChanged.listen((newDuration) {
      if (!isClosed) {
        emit(state.copyWith(duration: newDuration));
      }
    });

    _positionSubscription =
        _audioPlayer.onPositionChanged.listen((newPosition) {
      if (!isClosed) {
        emit(state.copyWith(position: newPosition));
      }
    });

    _playerCompleteSubscription = _audioPlayer.onPlayerComplete.listen((_) {
      if (!isClosed) {
        emit(state.copyWith(position: Duration.zero, isPlaying: false));
      }
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
    _durationSubscription?.cancel();
    _positionSubscription?.cancel();
    _playerCompleteSubscription?.cancel();
    _audioPlayer.dispose();
    return super.close();
  }
}
