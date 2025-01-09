import 'package:flutter/material.dart';

class CommonTextField extends StatefulWidget {
  const CommonTextField({
    super.key,
    required TextEditingController controller,
    required this.labelText,
    this.isPasswordField = false,
    this.validator,
  }) : _controller = controller;

  final TextEditingController _controller;
  final String labelText;
  final bool isPasswordField;
  final String? Function(String?)? validator;

  @override
  State<CommonTextField> createState() => _CommonTextFieldState();
}

class _CommonTextFieldState extends State<CommonTextField> {
  bool _isPasswordVisible = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      decoration: BoxDecoration(
        color: const Color.fromARGB(255, 231, 231, 231),
        borderRadius: BorderRadius.circular(15),
      ),
      child: TextFormField(
        controller: widget._controller,
        obscureText: widget.isPasswordField && !_isPasswordVisible,
        decoration: InputDecoration(
          labelText: widget.labelText,
          labelStyle: const TextStyle(color: Color.fromARGB(255, 96, 98, 105)),
          border: InputBorder.none,
          suffixIcon: widget.isPasswordField
              ? IconButton(
                  icon: Icon(
                    _isPasswordVisible
                        ? Icons.visibility
                        : Icons.visibility_off,
                    color: Colors.grey,
                  ),
                  onPressed: () {
                    setState(() {
                      _isPasswordVisible = !_isPasswordVisible;
                    });
                  },
                )
              : null,
        ),
        validator: widget.validator,
      ),
    );
  }
}
