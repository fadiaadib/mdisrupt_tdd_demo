import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mdisrupt_tdd_demo/features/things/data/models/thing_model.dart';
import 'package:mocktail/mocktail.dart';

import 'package:mdisrupt_tdd_demo/core/errors/failures.dart';
import 'package:mdisrupt_tdd_demo/core/errors/exceptions.dart';
import 'package:mdisrupt_tdd_demo/features/things/data/repos/things_repo_impl.dart';
import 'package:mdisrupt_tdd_demo/features/things/domain/entities/thing.dart';
import 'package:mdisrupt_tdd_demo/features/things/data/datasources/storage_datasource.dart';

class MockStorageDatasource extends Mock implements StorageDatasource {}

/// Test [ThingsRepoImpl] Repo Implementation
/// Tests:
///   ...
void main() {
  // What are the dependencies?
  late StorageDatasource datasource;

  // What do we want to test?
  late ThingsRepoImpl repoImpl;

  setUp(() {
    // Mock the dependency
    datasource = MockStorageDatasource();

    // Create the subject
    repoImpl = ThingsRepoImpl(datasource: datasource);
  });

  group('[addThing] Method', () {
    // Any sample data needed
    const tThingModel =
        ThingModel(name: 'The Thing', description: 'Benjamin Grimm');
    const tStorageFailure = StorageFailure('Bad Thing', 500);

    // Register fallback
    registerFallbackValue(tThingModel);

    test('should call the storage datasource and return true when succesful',
        () async {
      // Arrange
      when(() => datasource.addThing(any<ThingModel>()))
          .thenAnswer((_) async => true);

      // Act
      final result = await repoImpl.addThing(tThingModel);

      // Assert
      expect(result, const Right(true));
      verify(() => datasource.addThing(tThingModel)).called(1);
      verifyNoMoreInteractions(datasource);
    });

    test(
        'should call the storage datasource and return Failure on datastorage Exception',
        () async {
      // Arrange
      when(() => datasource.addThing(any<ThingModel>()))
          .thenThrow(StorageException());

      // Act
      final result = await repoImpl.addThing(tThingModel);

      // Assert
      expect(result, equals(const Left(tStorageFailure)));
      verify(() => datasource.addThing(tThingModel)).called(1);
      verifyNoMoreInteractions(datasource);
    });
  });

  group('[getThings] Method', () {
    // Any sample data needed
    final tThingsList = [Thing.empty()];
    const tStorageFailure = StorageFailure('Bad Things', 500);

    test(
        'should call the storage datasource and return list of things when succesful',
        () async {
      // Arrange
      when(() => datasource.getThings()).thenReturn(tThingsList);

      // Act
      final result = repoImpl.getThings();

      // Assert
      expect(result, Right(tThingsList));
      verify(() => datasource.getThings()).called(1);
      verifyNoMoreInteractions(datasource);
    });

    test(
        'should call the storage datasource and return Failure on datastorage Exception',
        () async {
      // Arrange
      when(() => datasource.getThings()).thenThrow(StorageException());

      // Act
      final result = repoImpl.getThings();

      // Assert
      expect(result, equals(const Left(tStorageFailure)));
      verify(() => datasource.getThings()).called(1);
      verifyNoMoreInteractions(datasource);
    });
  });
}
