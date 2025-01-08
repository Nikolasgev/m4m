import 'package:flutter/material.dart';

class CommonButton extends StatelessWidget {
  const CommonButton({
    super.key,
    this.color = const Color(0xFF8E97FD),
    required this.text,
    this.textColor = Colors.white,
    required this.onTap,
    this.width = double.infinity,
    this.margin = const EdgeInsets.all(20),
    this.padding = const EdgeInsets.symmetric(vertical: 20, horizontal: 5),
    this.borderRadius = 40,
  });

  final Color color;
  final String text;
  final Color textColor;
  final VoidCallback onTap;
  final double width;
  final EdgeInsets margin;
  final EdgeInsets padding;
  final double borderRadius;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: width,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(borderRadius),
          color: color,
        ),
        margin: margin,
        padding: padding,
        child: Text(
          text,
          style: TextStyle(
            color: textColor,
            fontWeight: FontWeight.w600,
            fontSize: 18,
          ),
        ),
      ),
    );
  }
}
