import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:m4m_f/features/meditation/presentation/pages/meditation_player_page.dart';

import '../../domain/usecases/generate_meditation.dart';
import '../bloc/meditation_bloc.dart';

class MeditationInputPage extends StatelessWidget {
  const MeditationInputPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Generate Meditation')),
      body: BlocProvider(
        create: (_) => MeditationBloc(context.read<GenerateMeditation>()),
        child: BlocConsumer<MeditationBloc, MeditationState>(
          listener: (context, state) {
            if (state is MeditationError) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text(state.message)),
              );
            } else if (state is MeditationLoaded) {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => MeditationPlayerPage(
                    meditation: state.meditation,
                  ),
                ),
              );
              context.read<MeditationBloc>().add(ResetMeditationState());
            }
          },
          builder: (context, state) {
            if (state is MeditationInitial) {
              return MeditationInputForm();
            } else if (state is MeditationLoading) {
              return const Center(child: CircularProgressIndicator());
            } else {
              return Center(
                  child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text('An unexpected error occurred.'),
                  IconButton(
                      onPressed: () {
                        context
                            .read<MeditationBloc>()
                            .add(ResetMeditationState());
                      },
                      icon: const Icon(
                        Icons.replay_outlined,
                        size: 20,
                      ))
                ],
              ));
            }
          },
        ),
      ),
    );
  }
}

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
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          Wrap(
            spacing: 16,
            runSpacing: 8,
            children: currentMood.map((label) {
              return MoodButtonWidget(label: label);
            }).toList(),
          ),
          TextField(
            controller: _controller,
            decoration: const InputDecoration(labelText: 'Enter prompt'),
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
    );
  }
}

class MoodButtonWidget extends StatelessWidget {
  final String label;

  const MoodButtonWidget({
    super.key,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    final isSelected = context.select<MeditationBloc, bool>(
      (bloc) => (bloc.state is MeditationInitial)
          ? (bloc.state as MeditationInitial).selectedCategories.contains(label)
          : false,
    );

    return GestureDetector(
      onTap: () {
        context.read<MeditationBloc>().add(ToggleCategorySelection(label));
      },
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
        decoration: BoxDecoration(
          color: isSelected ? Colors.blue[300] : Colors.blue[50],
          borderRadius: BorderRadius.circular(16),
        ),
        child: Text(
          label,
          style: TextStyle(
            color: isSelected ? Colors.white : Colors.black,
            fontWeight: FontWeight.w500,
            fontSize: 16,
          ),
        ),
      ),
    );
  }
}
