import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:m4m_f/features/meditation/domain/entities/meditation_entity.dart';
import 'package:m4m_f/features/meditation/presentation/cubit/audio_player_cubit.dart';

class MeditationPlayerPage extends StatelessWidget {
  final MeditationEntity meditation;

  const MeditationPlayerPage({super.key, required this.meditation});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) =>
          AudioPlayerCubit(AudioPlayer())..play(meditation.audioFile.path),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Meditation Player'),
          leading: IconButton(
            onPressed: () => Navigator.pop(context),
            icon: const Icon(Icons.arrow_back_ios),
          ),
        ),
        body: BlocBuilder<AudioPlayerCubit, AudioPlayerState>(
          builder: (context, state) {
            final cubit = context.read<AudioPlayerCubit>();

            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  Expanded(
                    child: Center(
                      child: Text(
                        meditation.text,
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                            fontSize: 24, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                  Slider(
                    min: 0,
                    max: state.duration.inSeconds.toDouble(),
                    value: state.position.inSeconds
                        .toDouble()
                        .clamp(0, state.duration.inSeconds.toDouble()),
                    onChanged: (value) {
                      cubit.seek(Duration(seconds: value.toInt()));
                    },
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(_formatDuration(state.position)),
                        Text(_formatDuration(state.duration)),
                      ],
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      IconButton(
                        onPressed: () => cubit
                            .seek(state.position - const Duration(seconds: 10)),
                        icon: const Icon(Icons.replay_10, size: 36),
                      ),
                      IconButton(
                        onPressed: state.isPlaying
                            ? cubit.pause
                            : () => cubit.play(meditation.audioFile.path),
                        icon: Icon(
                          state.isPlaying ? Icons.pause : Icons.play_arrow,
                          size: 36,
                        ),
                      ),
                      IconButton(
                        onPressed: cubit.stop,
                        icon: const Icon(Icons.stop, size: 36),
                      ),
                    ],
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  String _formatDuration(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    final minutes = twoDigits(duration.inMinutes.remainder(60));
    final seconds = twoDigits(duration.inSeconds.remainder(60));
    return '$minutes:$seconds';
  }
}
