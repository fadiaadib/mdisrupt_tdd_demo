import 'package:equatable/equatable.dart';

abstract class Failure extends Equatable {
  const Failure(this.message, this.statusCode);

  final String message;
  final int statusCode;

  @override
  List<Object?> get props => [];
}

class StorageFailure extends Failure {
  const StorageFailure(super.message, super.statusCode);
}

class TypeFailure extends Failure {
  const TypeFailure(super.message, super.statusCode);
}
