import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mdisrupt_tdd_demo/injection.dart';
import 'package:mocktail/mocktail.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:mdisrupt_tdd_demo/app.dart';

class MockSharedPreferences extends Mock implements SharedPreferences {}

void main() async {
  setUpAll(() {
    initInjection(sharedPreferences: MockSharedPreferences());
  });

  testWidgets(
    'should show [Nothing Available!] text',
    (WidgetTester tester) async {
      await tester.pumpWidget(const MDDemoApp());

      expect(find.text('Nothing Available!'), findsOneWidget);

      // Tap the '+' icon
      await tester.tap(find.byIcon(Icons.add));
      await tester.pump();

      // Verify that the bottom sheet opened
      expect(find.widgetWithText(TextFormField, 'Name'), findsOneWidget);
      expect(find.widgetWithText(TextFormField, 'Description'), findsOneWidget);
    },
  );
}
