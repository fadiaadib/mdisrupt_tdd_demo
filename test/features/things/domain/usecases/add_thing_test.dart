import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import 'package:mdisrupt_tdd_demo/core/errors/failures.dart';
import 'package:mdisrupt_tdd_demo/features/things/domain/entities/thing.dart';
import 'package:mdisrupt_tdd_demo/features/things/domain/repos/things_repo.dart';
import 'package:mdisrupt_tdd_demo/features/things/domain/usecases/add_thing.dart';

class MockThingsRepo extends Mock implements ThingsRepo {}

/// Test [AddThing] Usecase
/// Tests:
///   ...
void main() {
  // What are the dependencies?
  late ThingsRepo repo;

  // What are we testing?
  late AddThing usecase;

  // Any sample data needed
  final tThing = Thing.empty();
  const tStorageFailure = StorageFailure('Bad Thing', 500);

  // Setup all runs before all tests - Could be moved to setUp() instead
  setUpAll(() => registerFallbackValue(tThing));

  // Setup runs before each test
  setUp(() {
    // Mock the dependency
    repo = MockThingsRepo();

    // Create the subject
    usecase = AddThing(repo: repo);
  });

  test('should call repo and return true when succesful', () async {
    // Arrange
    when(() => repo.addThing(any<Thing>()))
        .thenAnswer((_) async => const Right(true));

    // Act
    final result = await usecase(tThing);

    // Assert
    expect(result, equals(const Right(true)));
    verify(() => repo.addThing(tThing)).called(1);
    verifyNoMoreInteractions(repo);
  });

  test('should call repo and return failure when unsuccesful', () async {
    // Arrange
    when(() => repo.addThing(any<Thing>()))
        .thenAnswer((_) async => const Left(tStorageFailure));

    // Act
    final result = await usecase(tThing);

    // Assert
    expect(result, equals(const Left(tStorageFailure)));
    verify(() => repo.addThing(tThing)).called(1);
    verifyNoMoreInteractions(repo);
  });
}
