import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';

import 'package:mdisrupt_tdd_demo/core/errors/exceptions.dart';
import 'package:mdisrupt_tdd_demo/features/things/data/models/thing_model.dart';
import 'package:mdisrupt_tdd_demo/features/things/domain/entities/thing.dart';
import '../../../../fixtures/read.dart';

/// Test [ThingModel] Model
/// Tests:
///   ...
void main() {
  test('should be a subclass of [Thing]', () async {
    // Act
    const model =
        ThingModel(name: 'The Thing Model', description: 'Benjamin Grimm');

    // Assert
    expect(model, isA<Thing>());
  });

  group('[fromJson] method', () {
    const tModel = ThingModel(description: 'Benjamin Grimm', name: 'The Thing');

    test('should create a [ThingModel] from a correct json', () async {
      // Arrange
      final stringJson = read('thing.json');
      final json = jsonDecode(stringJson);

      // Act
      final model = ThingModel.fromJson(json);

      // Assert
      expect(model, equals(tModel));
    });

    test(
        'should throw a [BadJsonException] when the json fields have the wrong type',
        () async {
      // Arrange
      final stringJson = read('wrong_type_thing.json');
      final json = jsonDecode(stringJson);

      // Act & Assert
      expect(
        () => ThingModel.fromJson(json),
        throwsA(const TypeMatcher<BadJsonException>()),
      );
    });

    test('should throw a [BadJsonException] when the json is missing a field',
        () async {
      // Arrange
      final stringJson = read('missing_thing.json');
      final json = jsonDecode(stringJson);

      // Act & Assert
      expect(
        () => ThingModel.fromJson(json),
        throwsA(const TypeMatcher<BadJsonException>()),
      );
    });
  });
}
