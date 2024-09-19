part of 'thing_bloc.dart';

sealed class ThingEvent extends Equatable {
  const ThingEvent();

  @override
  List<Object> get props => [];
}

class AddThingEvent extends ThingEvent {
  const AddThingEvent({required this.thingModel});

  final ThingModel thingModel;

  @override
  List<Object> get props => [thingModel];
}

class GetThingsEvent extends ThingEvent {}
