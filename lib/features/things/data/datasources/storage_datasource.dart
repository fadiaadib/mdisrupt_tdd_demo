import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

import 'package:mdisrupt_tdd_demo/core/errors/exceptions.dart';
import 'package:mdisrupt_tdd_demo/features/things/data/models/thing_model.dart';
import 'package:mdisrupt_tdd_demo/features/things/domain/entities/thing.dart';

abstract class StorageDatasource {
  Future<bool> addThing(ThingModel thing);

  List<Thing> getThings();
}

const kThingsKey = 'THINGS_KEY';

class StorageDatasourceImpl extends StorageDatasource {
  StorageDatasourceImpl({required SharedPreferences sharedPreferences})
      : _sharedPreferences = sharedPreferences;

  final SharedPreferences _sharedPreferences;

  @override
  Future<bool> addThing(ThingModel thing) async {
    try {
      List<String> thingsStrings =
          _sharedPreferences.getStringList(kThingsKey) ?? [];
      thingsStrings.add(jsonEncode(thing.toJson()));

      final result =
          await _sharedPreferences.setStringList(kThingsKey, thingsStrings);
      if (!result) {
        throw StorageException();
      }

      return result;
    } catch (e) {
      throw StorageException();
    }
  }

  @override
  List<Thing> getThings() {
    List<String>? thingsStrings = _sharedPreferences.getStringList(kThingsKey);

    if (thingsStrings == null) {
      throw StorageException();
    }

    return thingsStrings
        .map((e) => ThingModel.fromJson(jsonDecode(e)))
        .toList();
  }
}
