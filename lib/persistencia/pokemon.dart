import 'package:floor/floor.dart';

@entity
class Pokemon {
  @primaryKey
  final int id;

  final String name;
  final String type;

  Pokemon({
    required this.id,
    required this.name,
    required this.type,
  });
}
