import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import 'package:mdisrupt_tdd_demo/core/errors/failures.dart';
import 'package:mdisrupt_tdd_demo/features/things/domain/entities/thing.dart';
import 'package:mdisrupt_tdd_demo/features/things/domain/repos/things_repo.dart';
import 'package:mdisrupt_tdd_demo/features/things/domain/usecases/get_things.dart';

class MockThingsRepo extends Mock implements ThingsRepo {}

/// Test [GetThings] Usecase
/// Tests:
///   ...
void main() {
  // What are the dependencies?
  late ThingsRepo repo;

  // What are we testing?
  late GetThings usecase;

  // Any sample data nedded
  final tThings = [Thing.empty()];
  const tStorageFailure = StorageFailure('Cannot retrieve things', 500);

  // Setup runs before each test
  setUp(() {
    // Mock the dependency
    repo = MockThingsRepo();

    // Create the subject
    usecase = GetThings(repo: repo);
  });

  test('should call repo and return list of things when succesful', () async {
    // Arrange
    when(() => repo.getThings()).thenReturn(Right(tThings));

    // Act
    final result = usecase();

    // Assert
    expect(result, Right(tThings));
    verify(() => repo.getThings()).called(1);
    verifyNoMoreInteractions(repo);
  });

  test('should call repo and return failure when unsuccesful', () async {
    // Arrange
    when(() => repo.getThings()).thenReturn(const Left(tStorageFailure));

    // Act
    final result = usecase();

    // Assert
    expect(result, const Left(tStorageFailure));
    verify(() => repo.getThings()).called(1);
    verifyNoMoreInteractions(repo);
  });
}
