import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import 'package:mdisrupt_tdd_demo/features/things/data/models/thing_model.dart';
import 'package:mdisrupt_tdd_demo/features/things/domain/entities/thing.dart';
import 'package:mdisrupt_tdd_demo/features/things/domain/usecases/add_thing.dart';
import 'package:mdisrupt_tdd_demo/features/things/domain/usecases/get_things.dart';
part 'thing_event.dart';
part 'thing_state.dart';

class ThingBloc extends Bloc<ThingEvent, ThingState> {
  ThingBloc({
    required this.addThingUsecase,
    required this.getThingsUsecase,
  }) : super(InitialState()) {
    on<AddThingEvent>(_handelAddThing);
    on<GetThingsEvent>(_handleGetThings);
  }

  // Usecases
  final AddThing addThingUsecase;
  final GetThings getThingsUsecase;

  Future<void> _handelAddThing(event, emit) async {
    emit(LoadingState());
    await Future.delayed(const Duration(seconds: 1));

    final result = await addThingUsecase(event.thingModel);

    result.fold((failure) {
      emit(ErrorState(message: failure.message));
    }, (_) {
      final result = getThingsUsecase();
      result.fold((failure) {
        emit(ErrorState(message: failure.message));
      }, (things) {
        emit(LoadedState(things: things));
      });
    });
  }

  Future<void> _handleGetThings(event, emit) async {
    emit(LoadingState());
    await Future.delayed(const Duration(seconds: 1));

    final result = getThingsUsecase();

    result.fold((failure) {
      emit(ErrorState(message: failure.message));
    }, (things) {
      if (things.isNotEmpty) {
        emit(LoadedState(things: things));
      } else {
        emit(InitialState());
      }
    });
  }
}
