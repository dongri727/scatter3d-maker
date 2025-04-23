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
    this.controller,
  });

  final String label;
  final String? hintText;
  final String initialValue;
  final TextInputType keyboardType;
  final bool obscureText;
  final int maxLines;
  final Function(String) onChanged;
  final String? Function(String?)? validator;
  final TextEditingController? controller;
  @override
  State<MyTextField> createState() => _MyTextFieldState();
}

class _MyTextFieldState extends State<MyTextField> {
  late TextEditingController _controller;
  final FocusNode _focusNode = FocusNode();
  late TextSelection _selection;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(text: widget.initialValue);
    _selection = TextSelection.fromPosition(TextPosition(offset: widget.initialValue.length));
    _controller.selection = _selection;
    //fetchAndUpdate();
  }

  @override
  void dispose() {
    _controller.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  Future<void> fetchAndUpdate() async {
    if (!mounted) return;
    if (!_focusNode.hasFocus) {
      setState(() {
        _controller.text = widget.initialValue;
      });
    }else{
      final oldSelection = _controller.selection;
      _controller.value = TextEditingValue(
        text: widget.initialValue,
        selection: oldSelection,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: TextFormField(
        controller: _controller,
        focusNode: _focusNode,
        decoration: InputDecoration(
          labelText: widget.label,
          hintText: widget.hintText,
          border: const OutlineInputBorder(),
          contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          errorStyle: const TextStyle(
            color: Colors.red,
            fontSize: 12,
          ),
        ),
        keyboardType: widget.keyboardType,
        obscureText: widget.obscureText,
        maxLines: widget.maxLines,
        onChanged: (value){ 
          // _selection = TextSelection.fromPosition(TextPosition(offset: value.length));
          // _controller.selection = _selection;  
          widget.onChanged(value);
        },
        validator: widget.validator,
        autovalidateMode: AutovalidateMode.onUserInteraction,
      ),
    );
  }
}
