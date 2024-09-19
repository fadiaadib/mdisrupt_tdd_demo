import 'package:flutter/material.dart';

import 'package:mdisrupt_tdd_demo/features/things/domain/entities/thing.dart';
import 'package:mdisrupt_tdd_demo/features/things/presentation/widgets/thing_tile.dart';

class ThingsList extends StatelessWidget {
  const ThingsList({
    super.key,
    required this.things,
  });

  final List<Thing> things;

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      itemCount: things.length,
      separatorBuilder: (context, index) => const SizedBox(height: 10),
      itemBuilder: (context, index) {
        return ThingTile(thing: things[index]);
      },
    );
  }
}
