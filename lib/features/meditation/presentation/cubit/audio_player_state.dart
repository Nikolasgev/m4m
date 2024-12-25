part of 'audio_player_cubit.dart';

class AudioPlayerState extends Equatable {
  final Duration duration;
  final Duration position;
  final bool isPlaying;

  const AudioPlayerState({
    required this.duration,
    required this.position,
    required this.isPlaying,
  });

  AudioPlayerState copyWith({
    Duration? duration,
    Duration? position,
    bool? isPlaying,
  }) {
    return AudioPlayerState(
      duration: duration ?? this.duration,
      position: position ?? this.position,
      isPlaying: isPlaying ?? this.isPlaying,
    );
  }

  @override
  List<Object?> get props => [duration, position, isPlaying];
}
