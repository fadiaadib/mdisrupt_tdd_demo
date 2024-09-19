import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import 'package:mdisrupt_tdd_demo/core/errors/failures.dart';
import 'package:mdisrupt_tdd_demo/features/things/domain/usecases/add_thing.dart';
import 'package:mdisrupt_tdd_demo/features/things/domain/usecases/get_things.dart';
import 'package:mdisrupt_tdd_demo/features/things/data/models/thing_model.dart';
import 'package:mdisrupt_tdd_demo/features/things/presentation/blocs/bloc/thing_bloc.dart';

class MockAddThing extends Mock implements AddThing {}

class MockGetThings extends Mock implements GetThings {}

/// Test [ThingBloc] Bloc
/// Tests:
///   ...
void main() {
  // What are the dependencies?
  late AddThing addThingUsecase;
  late GetThings getThingsUsecase;

  // What do we want to test?
  late ThingBloc bloc;

  setUp(() {
    // Mock the dependencies
    addThingUsecase = MockAddThing();
    getThingsUsecase = MockGetThings();

    // Create the subject
    bloc = ThingBloc(
      addThingUsecase: addThingUsecase,
      getThingsUsecase: getThingsUsecase,
    );
  });

  const tStorageError = 'Storage Error';

  // InitialState test
  test('should have initialState as [InitialState]', () async {
    // Assert
    expect(bloc.state, InitialState());
  });

  // Testing the AddThing usecase effect on the bloc
  group('[AddThing] usecase', () {
    const tThingModel =
        ThingModel(name: 'The Thing', description: 'Benjamin Grimm');

    registerFallbackValue(tThingModel);

    // Failure Test
    blocTest<ThingBloc, ThingState>(
      'should emit [LoadingState, ErrorState] when call to [AddThing] usecase is unsuccesful',
      build: () {
        // Stub usecase
        when(() => addThingUsecase(any())).thenAnswer(
            (_) async => const Left(StorageFailure(tStorageError, 500)));

        return bloc;
      },
      wait: const Duration(seconds: 1),
      act: (bloc) => bloc.add(const AddThingEvent(thingModel: tThingModel)),
      expect: () => [LoadingState(), const ErrorState(message: tStorageError)],
      verify: (bloc) {
        verify(() => addThingUsecase(tThingModel)).called(1);
        verifyNoMoreInteractions(addThingUsecase);
      },
    );
  });

  // Testing the GetThings usecase effect on the bloc
  group('[GetThings] usecase', () {
    // Failure Test
    blocTest<ThingBloc, ThingState>(
      'should emit [LoadingState, ErrorState] when call to [GetThings] usecase is unsuccesful',
      build: () {
        // Stub usecase
        when(() => getThingsUsecase())
            .thenReturn(const Left(StorageFailure(tStorageError, 500)));

        return bloc;
      },
      wait: const Duration(seconds: 1),
      act: (bloc) => bloc.add(GetThingsEvent()),
      expect: () => [LoadingState(), const ErrorState(message: tStorageError)],
      verify: (bloc) {
        verify(() => getThingsUsecase()).called(1);
        verifyNoMoreInteractions(addThingUsecase);
      },
    );
  });
}
