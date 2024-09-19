import 'package:equatable/equatable.dart';

class Thing extends Equatable {
  const Thing({required this.name, required this.description});
  factory Thing.empty() =>
      const Thing(name: 'The Thing', description: 'Benjamin Grimm');

  final String name;
  final String description;

  @override
  List<Object?> get props => [name, description];
}
