import 'package:flutter/material.dart';

import 'package:mdisrupt_tdd_demo/features/things/domain/entities/thing.dart';

class ThingTile extends StatelessWidget {
  const ThingTile({super.key, required this.thing});

  final Thing thing;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(15)),
      ),
      tileColor: Theme.of(context).colorScheme.surfaceContainerHigh,
      title: Text(
        thing.name,
        style: Theme.of(context).textTheme.bodyLarge!.copyWith(
              color: Theme.of(context).colorScheme.primary,
              fontWeight: FontWeight.bold,
            ),
      ),
      subtitle: Text(thing.description),
    );
  }
}
