import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:m4m_f/features/meditation/presentation/bloc/meditation_bloc.dart';
import 'package:m4m_f/features/meditation/presentation/widgets/mood_button_selector_widget.dart';

class MeditationInputForm extends StatelessWidget {
  final TextEditingController _controller = TextEditingController();

  MeditationInputForm({super.key});

  final List<String> currentMood = [
    'Грусть',
    'Усталость',
    'Радость',
    'Расслабление',
    'Тревога',
    'Страх',
  ];

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Wrap(
              spacing: 16,
              runSpacing: 8,
              children: currentMood.map((label) {
                return MoodButtonSelectorWidget(label: label);
              }).toList(),
            ),
            const SizedBox(height: 32),
            TextFormField(
              controller: _controller,
              maxLines: null,
              keyboardType: TextInputType.multiline,
              decoration: const InputDecoration(
                labelText: 'Я чувствую себя...',
                contentPadding:
                    EdgeInsets.symmetric(vertical: 8, horizontal: 8),
              ),
              style: const TextStyle(fontSize: 18),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                final selectedCategories =
                    (context.read<MeditationBloc>().state as MeditationInitial)
                        .selectedCategories;

                final prompt =
                    '${selectedCategories.join(", ")} ${_controller.text}';

                context.read<MeditationBloc>().add(
                      GenerateMeditationEvent(prompt: prompt),
                    );
              },
              child: const Text('Generate'),
            ),
          ],
        ),
      ),
    );
  }
}
