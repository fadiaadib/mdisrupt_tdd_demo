import 'package:flutter/material.dart';

import 'package:mdisrupt_tdd_demo/features/things/presentation/widgets/thing_input.dart';

class ThingForm extends StatefulWidget {
  const ThingForm({super.key, required this.callback});

  final void Function(String name, String description) callback;

  @override
  State<ThingForm> createState() => _ThingFormState();
}

class _ThingFormState extends State<ThingForm> {
  final _formKey = GlobalKey<FormState>();
  var _name = '';
  var _description = '';

  void _saveThing() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      Navigator.of(context).pop();
      widget.callback(_name, _description);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            ThingInput(label: 'Name', onSaved: (value) => _name = value),
            const SizedBox(height: 12),
            ThingInput(
                label: 'Description', onSaved: (value) => _description = value),
            const SizedBox(height: 12),
            ElevatedButton.icon(
              onPressed: _saveThing,
              label: const Text('Add Thing'),
              icon: const Icon(Icons.add),
            ),
          ],
        ),
      ),
    );
  }
}
