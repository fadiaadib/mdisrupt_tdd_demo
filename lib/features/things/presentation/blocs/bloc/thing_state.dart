part of 'thing_bloc.dart';

sealed class ThingState extends Equatable {
  const ThingState();

  @override
  List<Object> get props => [];
}

final class InitialState extends ThingState {}

class LoadingState extends ThingState {}

class LoadedState extends ThingState {
  const LoadedState({required this.things});

  final List<Thing> things;

  @override
  List<Object> get props => [things];
}

class ErrorState extends ThingState {
  const ErrorState({required this.message});

  final String message;

  @override
  List<Object> get props => [message];
}
