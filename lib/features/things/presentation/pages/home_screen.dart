import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:mdisrupt_tdd_demo/features/things/data/models/thing_model.dart';
import 'package:mdisrupt_tdd_demo/features/things/presentation/blocs/thing_bloc.dart';
import 'package:mdisrupt_tdd_demo/core/widgets/center_message.dart';
import 'package:mdisrupt_tdd_demo/features/things/presentation/widgets/thing_form.dart';
import 'package:mdisrupt_tdd_demo/features/things/presentation/widgets/things_list.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    BlocProvider.of<ThingBloc>(context).add(GetThingsEvent());
    super.initState();
  }

  void _openAddThingForm(BuildContext context) {
    showModalBottomSheet(
      useSafeArea: true,
      isScrollControlled: true,
      context: context,
      builder: (_) => Container(
        padding: const EdgeInsets.all(15),
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.surfaceDim,
          borderRadius: const BorderRadius.all(Radius.circular(20)),
        ),
        child: ThingForm(
          callback: (name, description) {
            BlocProvider.of<ThingBloc>(context).add(
              AddThingEvent(
                thingModel: ThingModel(name: name, description: description),
              ),
            );
          },
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Testing Demo: Things'),
        actions: [
          IconButton(
            onPressed: () => _openAddThingForm(context),
            icon: const Icon(Icons.add),
            tooltip: 'Add New Thing',
          ),
        ],
      ),
      body: BlocBuilder<ThingBloc, ThingState>(
        builder: (context, state) {
          if (state is InitialState) {
            return const CenterMessage(message: 'Nothing Available!');
          } else if (state is LoadingState) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is ErrorState) {
            return CenterMessage(message: state.message);
          } else if (state is LoadedState) {
            return ThingsList(things: state.things);
          }
          return const CenterMessage(message: 'Unexpected State');
        },
      ),
    );
  }
}
