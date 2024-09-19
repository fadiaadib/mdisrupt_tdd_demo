import 'package:dartz/dartz.dart';

import 'package:mdisrupt_tdd_demo/core/errors/exceptions.dart';
import 'package:mdisrupt_tdd_demo/core/errors/failures.dart';
import 'package:mdisrupt_tdd_demo/features/things/data/datasources/storage_datasource.dart';
import 'package:mdisrupt_tdd_demo/features/things/data/models/thing_model.dart';
import 'package:mdisrupt_tdd_demo/features/things/domain/entities/thing.dart';
import 'package:mdisrupt_tdd_demo/features/things/domain/repos/things_repo.dart';

class ThingsRepoImpl implements ThingsRepo {
  ThingsRepoImpl({required StorageDatasource datasource})
      : _datasource = datasource;

  final StorageDatasource _datasource;

  @override
  Future<Either<Failure, bool>> addThing(Thing thing) async {
    // Should call storage datasource to save
    try {
      final result = await _datasource.addThing(thing as ThingModel);
      return Right(result);
    } on StorageException catch (_) {
      return Future.value(
          const Left(StorageFailure('Bad Thing Happened', 500)));
    }
  }

  @override
  Either<Failure, List<Thing>> getThings() {
    // Should call storage datasource to fetch
    try {
      return Right(_datasource.getThings());
    } on StorageException catch (_) {
      return const Left(StorageFailure('Nothing here :(', 500));
    }
  }
}
