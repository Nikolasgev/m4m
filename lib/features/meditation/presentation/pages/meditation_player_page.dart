import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';

import '../../domain/entities/meditation_entity.dart';

class MeditationPlayerPage extends StatefulWidget {
  final MeditationEntity meditation;

  const MeditationPlayerPage({super.key, required this.meditation});

  @override
  State<MeditationPlayerPage> createState() => _MeditationPlayerPageState();
}

class _MeditationPlayerPageState extends State<MeditationPlayerPage> {
  final AudioPlayer _audioPlayer = AudioPlayer();
  Duration _duration = Duration.zero;
  Duration _position = Duration.zero;

  @override
  void initState() {
    super.initState();

    // Устанавливаем обработчики
    _audioPlayer.onDurationChanged.listen((newDuration) {
      setState(() {
        _duration = newDuration;
      });
    });

    _audioPlayer.onPositionChanged.listen((newPosition) {
      setState(() {
        _position = newPosition;
      });
    });

    _audioPlayer.onPlayerComplete.listen((_) {
      setState(() {
        _position = Duration.zero;
      });
    });

    // Загружаем файл для воспроизведения
    _audioPlayer.setSource(DeviceFileSource(widget.meditation.audioFile.path));
  }

  @override
  void dispose() {
    _audioPlayer.dispose();
    super.dispose();
  }

  String _formatDuration(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    final minutes = twoDigits(duration.inMinutes.remainder(60));
    final seconds = twoDigits(duration.inSeconds.remainder(60));
    return '$minutes:$seconds';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Meditation Player'),
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(Icons.arrow_back_ios),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Текст медитации
            Expanded(
              child: Center(
                child: Text(
                  widget.meditation.text,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                      fontSize: 24, fontWeight: FontWeight.bold),
                ),
              ),
            ),

            // Ползунок для перемотки
            Slider(
              min: 0,
              max: _duration.inSeconds.toDouble(),
              value: _position.inSeconds
                  .toDouble()
                  .clamp(0, _duration.inSeconds.toDouble()),
              onChanged: (value) async {
                final position = Duration(seconds: value.toInt());
                await _audioPlayer.seek(position);
                setState(() {
                  _position = position;
                });
              },
            ),

            // Время воспроизведения
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(_formatDuration(_position)),
                  Text(_formatDuration(_duration)),
                ],
              ),
            ),

            // Кнопки управления воспроизведением
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                  onPressed: () async {
                    final newPosition = _position - const Duration(seconds: 10);
                    await _audioPlayer.seek(newPosition < Duration.zero
                        ? Duration.zero
                        : newPosition);
                  },
                  icon: const Icon(Icons.replay_10, size: 36),
                ),
                IconButton(
                  onPressed: () async {
                    await _audioPlayer.resume();
                  },
                  icon: const Icon(Icons.play_arrow, size: 36),
                ),
                IconButton(
                  onPressed: () async {
                    await _audioPlayer.pause();
                  },
                  icon: const Icon(Icons.pause, size: 36),
                ),
                IconButton(
                  onPressed: () async {
                    await _audioPlayer.stop();
                    setState(() {
                      _position = Duration.zero;
                    });
                  },
                  icon: const Icon(Icons.stop, size: 36),
                ),
              ],
            ),

            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }
}
