import 'package:flutter/material.dart';

class TextBox extends StatelessWidget {
  const TextBox({
    super.key,
    required this.label,
    this.controller,
    this.validator,
  });

  final String label;
  final TextEditingController? controller;
  final String? Function(String?)? validator;

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        label: Text(label),
        enabledBorder: InputBorder.none,
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: theme.primaryColor, width: 1.0),
          borderRadius: const BorderRadius.all(Radius.circular(10)),
        ),
      ),
      validator: validator,
    );
  }
}
