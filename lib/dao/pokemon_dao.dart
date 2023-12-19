import 'package:floor/floor.dart';
import 'package:terceira_prova/persistencia/pokemon.dart';
@dao
abstract class PokemonDao {
  @Query('SELECT * FROM Pokemon')
  Future<List<Pokemon>> findAllPokemons();

  @Query('SELECT * FROM Pokemon WHERE id = :id')
  Future<Pokemon?> findPokemonById(int id);

  @Insert(onConflict: OnConflictStrategy.replace)
  Future<void> insertPokemon(Pokemon pokemon);

  @delete
  Future<void> deletePokemon(Pokemon pokemon);
}
