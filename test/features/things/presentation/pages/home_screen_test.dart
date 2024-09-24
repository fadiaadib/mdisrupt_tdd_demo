import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:mdisrupt_tdd_demo/app.dart';
import 'package:mdisrupt_tdd_demo/injection.dart';

class MockSharedPreferences extends Mock implements SharedPreferences {}

/// Tests the [HomePage] widget
/// Tests:
///   ...
void main() async {
  late SharedPreferences sharedPreferences;

  setUpAll(() {
    sharedPreferences = MockSharedPreferences();
    initInjection(sharedPreferences: sharedPreferences);
    // HttpOverrides.global = null;
  });

  /// Test init state
  testWidgets(
    'should show [Nothing Available!] text ',
    (WidgetTester tester) async {
      // Arrange

      // Act
      await tester.pumpWidget(const MDDemoApp());

      // Assert
      expect(find.text('Nothing Available!'), findsOneWidget);
    },
  );

  /// Test interaction
  testWidgets(
    'should click on [+] button and open the form',
    (WidgetTester tester) async {
      // Arrange

      // Act
      await tester.pumpWidget(const MDDemoApp());

      // Tap the '+' icon
      await tester.tap(find.byIcon(Icons.add));
      await tester.pump();

      // Assert
      // Verify that the bottom sheet opened
      expect(find.widgetWithText(TextFormField, 'Name'), findsOneWidget);
      expect(find.widgetWithText(TextFormField, 'Description'), findsOneWidget);
    },
  );

  /// Test accesibility
  testWidgets('Accessibilty test', (WidgetTester tester) async {
    final SemanticsHandle handle = tester.ensureSemantics();
    await tester.pumpWidget(const MDDemoApp());

    // Checks that tappable nodes have a minimum size of 48 by 48 pixels
    // for Android.
    await expectLater(tester, meetsGuideline(androidTapTargetGuideline));

    // Checks that tappable nodes have a minimum size of 44 by 44 pixels
    // for iOS.
    await expectLater(tester, meetsGuideline(iOSTapTargetGuideline));

    // Checks that touch targets with a tap or long press action are labeled.
    await expectLater(tester, meetsGuideline(labeledTapTargetGuideline));

    // Checks whether semantic nodes meet the minimum text contrast levels.
    // The recommended text contrast is 3:1 for larger text
    // (18 point and above regular).
    await expectLater(tester, meetsGuideline(textContrastGuideline));
    handle.dispose();
  });
}
