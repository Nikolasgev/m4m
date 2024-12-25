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
              return const Center(child: Text('An unexpected error occurred.'));
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

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          TextField(
            controller: _controller,
            decoration: const InputDecoration(labelText: 'Enter prompt'),
          ),
          const SizedBox(height: 16),
          ElevatedButton(
            onPressed: () {
              context.read<MeditationBloc>().add(
                    GenerateMeditationEvent(prompt: _controller.text),
                  );
            },
            child: const Text('Generate'),
          ),
        ],
      ),
    );
  }
}
