import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:mdisrupt_tdd_demo/core/theme/theme.dart';
import 'package:mdisrupt_tdd_demo/features/things/presentation/blocs/bloc/thing_bloc.dart';
import 'package:mdisrupt_tdd_demo/features/things/presentation/pages/home_screen.dart';
import 'package:mdisrupt_tdd_demo/injection.dart';

class MDDemoApp extends StatelessWidget {
  const MDDemoApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Mdisrupt TDD Demo',
      theme: kThemeData,
      home: BlocProvider(
        create: (_) => sl<ThingBloc>(),
        child: const HomeScreen(),
      ),
    );
  }
}
