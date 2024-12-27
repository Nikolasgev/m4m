import 'package:flutter/material.dart';
import 'package:m4m_f/features/meditation/presentation/widgets/mood_button_selector_widget.dart';

class CustomWrap extends StatelessWidget {
  const CustomWrap({super.key, required this.list, required this.title});

  final List<String> list;
  final String title;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w400),
        ),
        const SizedBox(height: 16),
        Wrap(
          spacing: 16,
          runSpacing: 8,
          children: list.map((label) {
            return MoodButtonSelectorWidget(label: label);
          }).toList(),
        ),
      ],
    );
  }
}
