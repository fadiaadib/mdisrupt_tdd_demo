import 'package:flutter/material.dart';

import 'package:mdisrupt_tdd_demo/app.dart';
import 'package:mdisrupt_tdd_demo/injection.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initInjection();

  runApp(const MDDemoApp());
}
