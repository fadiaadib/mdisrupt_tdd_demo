import 'package:dartz/dartz.dart';

import 'package:mdisrupt_tdd_demo/core/errors/failures.dart';
import 'package:mdisrupt_tdd_demo/features/things/domain/entities/thing.dart';
import 'package:mdisrupt_tdd_demo/features/things/domain/repos/things_repo.dart';

class AddThing {
  const AddThing({required ThingsRepo repo}) : _repo = repo;

  final ThingsRepo _repo;

  Future<Either<Failure, bool>> call(Thing thing) => _repo.addThing(thing);
}
