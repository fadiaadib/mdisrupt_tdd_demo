import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:mdisrupt_tdd_demo/core/errors/exceptions.dart';
import 'package:mdisrupt_tdd_demo/features/things/data/datasources/storage_datasource.dart';
import 'package:mdisrupt_tdd_demo/features/things/data/models/thing_model.dart';

class MockSharedPreferences extends Mock implements SharedPreferences {}

/// Test [StorageDatasourceImpl] Datastource Implementation
/// Tests:
///   ...
void main() {
  // What are the dependencies?
  late SharedPreferences sharedPreferences;

  // What do we want to test?
  late StorageDatasourceImpl datasourceImpl;

  setUp(() {
    // Mock the dependency
    sharedPreferences = MockSharedPreferences();

    // Create the subject
    datasourceImpl =
        StorageDatasourceImpl(sharedPreferences: sharedPreferences);
  });

  group('[addThing] Method', () {
    // Any sample data needed
    const tThingModel =
        ThingModel(name: 'The Thing', description: 'Benjamin Grimm');

    test(
        'should call the sharedPreferences to save the thing and return true on success',
        () async {
      // Arrange
      when(() => sharedPreferences.getStringList(any())).thenReturn([]);
      when(
        () => sharedPreferences.setStringList(any(), any()),
      ).thenAnswer((_) async => true);

      // Act
      final result = await datasourceImpl.addThing(tThingModel);

      // Assert
      expect(result, equals(true));
      verify(
        () => sharedPreferences.getStringList(kThingsKey),
      ).called(1);
      verify(
        () => sharedPreferences.setStringList(
          kThingsKey,
          [jsonEncode(tThingModel.toJson())],
        ),
      ).called(1);
      verifyNoMoreInteractions(sharedPreferences);
    });

    test(
        'should call the sharedPreferences to save the thing and throw [StorageException] on failure',
        () async {
      // Arrange
      when(() => sharedPreferences.getStringList(any())).thenReturn([]);
      when(
        () => sharedPreferences.setStringList(any(), any()),
      ).thenAnswer((_) async => false);

      // Act and Assert
      expect(() => datasourceImpl.addThing(tThingModel),
          throwsA(const TypeMatcher<StorageException>()));
      verify(
        () => sharedPreferences.getStringList(kThingsKey),
      ).called(1);
      verify(
        () => sharedPreferences.setStringList(
          kThingsKey,
          [jsonEncode(tThingModel.toJson())],
        ),
      ).called(1);
      verifyNoMoreInteractions(sharedPreferences);
    });
  });

  group('[getThings] Method', () {
    const tThingModels = [
      ThingModel(name: 'The Thing', description: 'Benjamin Grimm')
    ];
    final tThingModelStrings = [
      jsonEncode(
        const ThingModel(name: 'The Thing', description: 'Benjamin Grimm')
            .toJson(),
      )
    ];

    test(
        'should call the sharedPreferences to get the things list and return them on success',
        () async {
      // Arrange
      when(() => sharedPreferences.getStringList(any()))
          .thenReturn(tThingModelStrings);

      // Act
      final result = datasourceImpl.getThings();

      // Assert
      expect(result, equals(tThingModels));
      verify(
        () => sharedPreferences.getStringList(kThingsKey),
      ).called(1);
      verifyNoMoreInteractions(sharedPreferences);
    });

    test(
        'should call the sharedPreferences to get the things and throw [StorageException] on failure',
        () async {
      // Arrange
      when(() => sharedPreferences.getStringList(any())).thenReturn(null);

      // Act and Assert
      expect(() => datasourceImpl.getThings(),
          throwsA(const TypeMatcher<StorageException>()));
      verify(
        () => sharedPreferences.getStringList(kThingsKey),
      ).called(1);

      verifyNoMoreInteractions(sharedPreferences);
    });
  });
}
