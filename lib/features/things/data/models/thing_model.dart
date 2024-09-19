import 'package:mdisrupt_tdd_demo/features/things/domain/entities/thing.dart';
import 'package:mdisrupt_tdd_demo/core/errors/exceptions.dart';

class ThingModel extends Thing {
  const ThingModel({required super.name, required super.description});

  factory ThingModel.fromJson(Map<String, dynamic> json) {
    try {
      return ThingModel(name: json['name'], description: json['description']);
    } on TypeError catch (_) {
      throw BadJsonException();
    }
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'description': description,
    };
  }

  ThingModel copyWith({String? name, String? description}) {
    return ThingModel(
      name: name ?? this.name,
      description: description ?? this.description,
    );
  }
}
