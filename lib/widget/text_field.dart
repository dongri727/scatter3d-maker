import 'package:flutter/material.dart';

class MyTextField extends StatefulWidget {
  const MyTextField({
    super.key,
    required this.label,
    required this.onChanged,
    this.initialValue = '',
    this.hintText,
    this.keyboardType = TextInputType.text,
    this.obscureText = false,
    this.maxLines = 1,
    this.validator,
  });

  final String label;
  final String? hintText;
  final String initialValue;
  final TextInputType keyboardType;
  final bool obscureText;
  final int maxLines;
  final Function(String) onChanged;
  final String? Function(String?)? validator;

  @override
  State<MyTextField> createState() => _MyTextFieldState();
}

class _MyTextFieldState extends State<MyTextField> {
  late TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(text: widget.initialValue);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: TextFormField(
        controller: _controller,
        decoration: InputDecoration(
          labelText: widget.label,
          hintText: widget.hintText,
          hintStyle: const TextStyle(color: Colors.lightBlue),
          border: const OutlineInputBorder(),
          contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          errorStyle: const TextStyle(
            color: Colors.deepOrange,
            fontSize: 12,
          ),
        ),
        keyboardType: widget.keyboardType,
        obscureText: widget.obscureText,
        maxLines: widget.maxLines,
        onChanged: widget.onChanged,
        validator: widget.validator,
        autovalidateMode: AutovalidateMode.onUserInteraction,
      ),
    );
  }
}
