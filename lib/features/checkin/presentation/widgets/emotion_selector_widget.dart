import 'package:flutter/material.dart';

class EmotionSelectorWidget extends StatelessWidget {
  final String title;
  final List<String> options;
  final Function(String) onSelected;

  const EmotionSelectorWidget({
    super.key,
    required this.title,
    required this.options,
    required this.onSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title, style: const TextStyle(fontSize: 18)),
        const SizedBox(height: 10),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: options.map((option) {
            return GestureDetector(
              onTap: () => onSelected(option),
              child: Text(option, style: const TextStyle(fontSize: 32)),
            );
          }).toList(),
        ),
      ],
    );
  }
}