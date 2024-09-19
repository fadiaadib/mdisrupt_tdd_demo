import 'package:flutter/material.dart';

import 'package:mdisrupt_tdd_demo/app.dart';
import 'package:mdisrupt_tdd_demo/injection.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  initInjection(sharedPreferences: await SharedPreferences.getInstance());

  runApp(const MDDemoApp());
}
