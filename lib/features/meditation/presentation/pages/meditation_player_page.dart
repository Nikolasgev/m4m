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
      appBar: AppBar(
        title: const Text('Meditation Player'),
        leading: IconButton(
          onPressed: () {
            audioPlayer.dispose();
            Navigator.pop(context);
          },
          icon: const Icon(Icons.arrow_back_ios),
        ),
      ),
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
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                  onPressed: () async {
                    await audioPlayer
                        .play(DeviceFileSource(meditation.audioFile.path));
                  },
                  icon: const Icon(Icons.play_arrow),
                ),
                IconButton(
                  onPressed: () async {
                    await audioPlayer.pause();
                  },
                  icon: const Icon(Icons.pause),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
