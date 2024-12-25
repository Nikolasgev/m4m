import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:m4m_f/features/meditation/presentation/pages/meditation_player_page.dart';
import 'package:m4m_f/features/meditation/presentation/widgets/meditation_input_form.dart';

import '../bloc/meditation_bloc.dart';

class MeditationInputPage extends StatelessWidget {
  const MeditationInputPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<MeditationBloc, MeditationState>(
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
          return const Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Генерация медитации...',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w400),
                ),
                CircularProgressIndicator()
              ],
            ),
          );
        } else {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  'An unexpected error occurred.',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.w400),
                ),
                IconButton(
                    onPressed: () {
                      context
                          .read<MeditationBloc>()
                          .add(ResetMeditationState());
                    },
                    icon: const Icon(
                      Icons.replay_outlined,
                      size: 40,
                    ))
              ],
            ),
          );
        }
      },
    );
  }
}
