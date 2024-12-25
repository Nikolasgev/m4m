import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';

import '../../domain/entities/meditation_entity.dart';

class MeditationPlayerPage extends StatelessWidget {
  final MeditationEntity meditation;

  const MeditationPlayerPage({super.key, required this.meditation});

  @override
  Widget build(BuildContext context) {
    final audioPlayer = AudioPlayer();

    return Scaffold(
      appBar: AppBar(title: const Text('Meditation Player')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              meditation.text,
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 18),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () async {
                print('object');
                await audioPlayer
                    .play(DeviceFileSource(meditation.audioFile.path));
              },
              child: const Text('Play Meditation Audio'),
            ),
          ],
        ),
      ),
    );
  }
}
