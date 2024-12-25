import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:m4m_f/features/meditation/presentation/bloc/meditation_bloc.dart';
import 'package:m4m_f/features/meditation/presentation/widgets/custom_dropdown_selector.dart';
import 'package:m4m_f/features/meditation/presentation/widgets/custom_wrap.dart';

class MeditationInputForm extends StatelessWidget {
  MeditationInputForm({super.key});

  final List<String> currentMood = [
    'Грусть',
    'Усталость',
    'Радость',
    'Расслабление',
    'Тревога',
    'Страх',
  ];

  final List<String> voiceOptions = [
    'Мужской',
    'Женский',
    'Робот',
  ];

  final List<String> durations = [
    '5 минут',
    '10 минут',
    '15 минут',
  ];

  @override
  Widget build(BuildContext context) {
    final textController = context.read<MeditationBloc>().textController;

    return SafeArea(
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 32),
              const Text(
                'Генерация медитации',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.w500),
              ),
              const SizedBox(height: 32),
              // Выбор состояния
              CustomWrap(
                list: currentMood,
                title: 'Какие эмоции вы сейчас испытываете?',
              ),
              const SizedBox(height: 32),

              // Выбор голоса
              CustomDropdownSelector(
                context: context,
                title: 'Выберите голос озвучки',
                options: voiceOptions,
                onSelected: (selectedVoice) {
                  context.read<MeditationBloc>().add(
                        ToggleCategorySelection('voice:$selectedVoice'),
                      );
                },
              ),
              const SizedBox(height: 32),

              // Выбор длительности
              CustomDropdownSelector(
                context: context,
                title: 'Выберите длительность',
                options: durations,
                onSelected: (selectedDuration) {
                  context.read<MeditationBloc>().add(
                        ToggleCategorySelection('duration:$selectedDuration'),
                      );
                },
              ),
              const SizedBox(height: 32),

              // Поле ввода текста
              TextFormField(
                controller: textController,
                maxLines: null,
                keyboardType: TextInputType.multiline,
                decoration: const InputDecoration(
                  labelText: 'Напишите что бы вы хотели добавить?',
                  contentPadding:
                      EdgeInsets.symmetric(vertical: 8, horizontal: 8),
                ),
                style: const TextStyle(fontSize: 18),
              ),
              const SizedBox(height: 16),

              // Кнопка генерации
              ElevatedButton(
                onPressed: () => _onGeneratePressed(context),
                child: const Text('Generate'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _onGeneratePressed(BuildContext context) {
    final selectedCategories =
        (context.read<MeditationBloc>().state as MeditationInitial)
            .selectedCategories;

    // Проверка обязательных полей
    final isValid = [
      _hasSelection(selectedCategories, currentMood),
      _hasSelection(selectedCategories, voiceOptions, prefix: 'voice:'),
      _hasSelection(selectedCategories, durations, prefix: 'duration:'),
    ].every((condition) => condition);

    if (!isValid) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            'Пожалуйста, заполните обязательные поля: выберите настроение, голос и длительность.',
          ),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    // Получаем выбранные значения
    final moods = selectedCategories
        .where((category) => currentMood.contains(category))
        .toList(); // Список выбранных настроений
    final voice = selectedCategories
        .firstWhere((category) => category.startsWith('voice:'))
        .replaceFirst('voice:', '');
    final duration = selectedCategories
        .firstWhere((category) => category.startsWith('duration:'))
        .replaceFirst('duration:', '');
    final additionalText = context.read<MeditationBloc>().textController.text;

    // Формируем JSON
    final jsonBody = {
      'moods': moods, // Теперь moods - это список
      'voice': voice,
      'duration': duration,
      'additionalText': additionalText,
    };

    // Отправляем JSON на сервер
    context.read<MeditationBloc>().add(
          GenerateMeditationEvent(prompt: jsonBody),
        );
  }

  bool _hasSelection(List<String> selectedCategories, List<String> options,
      {String prefix = ''}) {
    return selectedCategories
        .any((category) => options.contains(category.replaceFirst(prefix, '')));
  }
}
