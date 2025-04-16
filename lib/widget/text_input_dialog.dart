import 'package:flutter/material.dart';

class TextInputDialog extends StatefulWidget {
  final String title;
  final String hintText;
  final String? initialValue;
  final String? Function(String?)? validator;

  const TextInputDialog({
    super.key,
    required this.title,
    required this.hintText,
    this.initialValue,
    this.validator,
  });

  static Future<String?> show(
    BuildContext context, {
    required String title,
    required String hintText,
    String? initialValue,
    String? Function(String?)? validator,
  }) {
    return showDialog<String>(
      context: context,
      builder: (context) => TextInputDialog(
        title: title,
        hintText: hintText,
        initialValue: initialValue,
        validator: validator,
      ),
    );
  }

  @override
  State<TextInputDialog> createState() => _TextInputDialogState();
}

class _TextInputDialogState extends State<TextInputDialog> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _controller;
  bool _isValid = false;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(text: widget.initialValue);
    _isValid = widget.validator == null || 
               widget.validator!(_controller.text) == null;
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(widget.title),
      content: Form(
        key: _formKey,
        child: TextFormField(
          controller: _controller,
          decoration: InputDecoration(
            hintText: widget.hintText,
            border: const OutlineInputBorder(),
          ),
          validator: widget.validator,
          onChanged: (value) {
            setState(() {
              _isValid = widget.validator == null || 
                        widget.validator!(value) == null;
            });
          },
          autofocus: true,
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('キャンセル'),
        ),
        TextButton(
          onPressed: _isValid
              ? () {
                  if (_formKey.currentState!.validate()) {
                    Navigator.pop(context, _controller.text);
                  }
                }
              : null,
          child: const Text('OK'),
        ),
      ],
    );
  }
} 