import 'package:floor/floor.dart';

@entity
class Pokemon {
  @PrimaryKey(autoGenerate: false)
  final int id;

  final String url;
  final String nome;
  final int experiencia;
  final double altura;

  @ColumnInfo(name: 'capturado')
  bool capturado;

  Pokemon({
    required this.id,
    required this.url,
    required this.nome,
    required this.experiencia,
    required this.altura,
    this.capturado = false,
  });
}
