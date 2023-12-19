// lib/persistencia/pokemon_dao.dart
import 'package:floor/floor.dart';
import 'package:terceira_prova/persistencia/pokemon.dart';

@dao
abstract class PokemonDao {
  @Query('SELECT * FROM Pokemon')
  Future<List<Pokemon>> findAllPokemons();

  @Query('SELECT * FROM Pokemon WHERE id = :id')
  Future<Pokemon?> findPokemonById(int id);

  @insert
  Future<void> insertPokemon(Pokemon pokemon);

  @delete
  Future<void> deletePokemon(Pokemon pokemon);

  @Update(onConflict: OnConflictStrategy.replace)
  Future<void> updatePokemon(Pokemon pokemon);
}
