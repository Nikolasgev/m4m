import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:m4m_f/features/checkin/domain/entities/checkin_entity.dart';

import '../bloc/checkin_bloc.dart';
import '../widgets/emotion_selector_widget.dart';

class CheckinQuestionsPage extends StatelessWidget {
  final _moodController = TextEditingController();
  final _energyController = TextEditingController();
  final _stressController = TextEditingController();
  final _notesController = TextEditingController();

  CheckinQuestionsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Ежедневный чек-ин')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            EmotionSelectorWidget(
              title: 'Какое у вас сегодня настроение?',
              options: const ['😊', '😐', '😔'],
              onSelected: (value) => _moodController.text = value,
            ),
            const SizedBox(height: 20),
            EmotionSelectorWidget(
              title: 'Как вы оцениваете свой уровень энергии?',
              options: const ['🔋', '🔋🔋', '🔋🔋🔋'],
              onSelected: (value) => _energyController.text = value,
            ),
            const SizedBox(height: 20),
            EmotionSelectorWidget(
              title: 'Насколько вы чувствуете стресс?',
              options: const ['☁️', '☁️☁️', '☁️☁️☁️'],
              onSelected: (value) => _stressController.text = value,
            ),
            const SizedBox(height: 20),
            TextField(
              controller: _notesController,
              decoration: const InputDecoration(
                labelText: 'Дополнительные заметки',
                border: OutlineInputBorder(),
              ),
              maxLines: 3,
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                final checkin = CheckinEntity(
                  mood: _moodController.text,
                  energy: _energyController.text,
                  stress: _stressController.text,
                  notes: _notesController.text,
                  date: DateTime.now(),
                );
                context.read<CheckinBloc>().add(AddCheckinEvent(checkin));
              },
              child: const Text('Сохранить'),
            ),
          ],
        ),
      ),
    );
  }
}
