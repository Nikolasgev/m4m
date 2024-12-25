import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:m4m_f/features/meditation/presentation/bloc/meditation_bloc.dart';

class MoodButtonSelectorWidget extends StatelessWidget {
  final String label;

  const MoodButtonSelectorWidget({
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
            fontWeight: FontWeight.w400,
            fontSize: 14,
          ),
        ),
      ),
    );
  }
}
