import 'package:dartz/dartz.dart';

import 'package:mdisrupt_tdd_demo/core/errors/failures.dart';
import 'package:mdisrupt_tdd_demo/features/things/domain/entities/thing.dart';
import 'package:mdisrupt_tdd_demo/features/things/domain/repos/things_repo.dart';

class GetThings {
  const GetThings({required ThingsRepo repo}) : _repo = repo;

  final ThingsRepo _repo;

  Either<Failure, List<Thing>> call() => _repo.getThings();
}
