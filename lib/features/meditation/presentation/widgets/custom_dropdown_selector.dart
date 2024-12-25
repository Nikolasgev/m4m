import 'package:flutter/material.dart';

class CustomDropdownSelector extends StatelessWidget {
  const CustomDropdownSelector({
    super.key,
    required this.context,
    required this.title,
    required this.options,
    required this.onSelected,
  });

  final BuildContext context;
  final String title;
  final List<String> options;
  final Function(String p1) onSelected;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        DropdownButtonFormField<String>(
          hint: Text(
            title,
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          isExpanded: true,
          decoration: const InputDecoration(
            contentPadding: EdgeInsets.symmetric(vertical: 8, horizontal: 8),
          ),
          items: options
              .map((option) => DropdownMenuItem(
                    value: option,
                    child: Text(option),
                  ))
              .toList(),
          onChanged: (value) {
            if (value != null) {
              onSelected(value);
            }
          },
        ),
      ],
    );
  }
}
