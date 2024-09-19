import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:mdisrupt_tdd_demo/features/things/data/datasources/storage_datasource.dart';
import 'package:mdisrupt_tdd_demo/features/things/data/repos/things_repo_impl.dart';
import 'package:mdisrupt_tdd_demo/features/things/domain/repos/things_repo.dart';
import 'package:mdisrupt_tdd_demo/features/things/domain/usecases/add_thing.dart';
import 'package:mdisrupt_tdd_demo/features/things/domain/usecases/get_things.dart';
import 'package:mdisrupt_tdd_demo/features/things/presentation/blocs/thing_bloc.dart';

/// Short for Service Locator
final sl = GetIt.instance;

void initInjection({required SharedPreferences sharedPreferences}) {
  // Register the Bloc
  sl.registerFactory(
    () => ThingBloc(
      addThingUsecase: sl(),
      getThingsUsecase: sl(),
    ),
  );

  // Register the Use cases
  sl.registerLazySingleton(() => AddThing(repo: sl()));
  sl.registerLazySingleton(() => GetThings(repo: sl()));

  // Register the Repo Implementation (not the contract)
  sl.registerLazySingleton<ThingsRepo>(() => ThingsRepoImpl(datasource: sl()));

  // Register the Data source
  sl.registerLazySingleton<StorageDatasource>(
    () => StorageDatasourceImpl(
      sharedPreferences: sl(),
    ),
  );

  // Register the External packages
  sl.registerSingleton<SharedPreferences>(sharedPreferences);
}
