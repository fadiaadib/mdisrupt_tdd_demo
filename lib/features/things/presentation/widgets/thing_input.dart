import 'package:flutter/material.dart';

class ThingInput extends StatelessWidget {
  const ThingInput({super.key, required this.onSaved, required this.label});

  final Function(String value) onSaved;
  final String label;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      maxLength: 20,
      decoration: InputDecoration(label: Text(label)),
      validator: (value) {
        if (value == null || value.length <= 1 || value.length > 20) {
          return 'Must be between 2 and 20 characters';
        }
        return null;
      },
      onSaved: (value) => onSaved(value!),
      style:
          Theme.of(context).textTheme.bodyMedium!.copyWith(color: Colors.white),
    );
  }
}
