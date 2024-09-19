import 'package:dartz/dartz.dart';

import 'package:mdisrupt_tdd_demo/core/errors/failures.dart';
import 'package:mdisrupt_tdd_demo/features/things/domain/entities/thing.dart';

abstract class ThingsRepo {
  Future<Either<Failure, bool>> addThing(Thing thing);

  Either<Failure, List<Thing>> getThings();
}
