import 'dart:convert';

import 'package:pokeflutter/Models/pokemon.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PokemonShared {
  SharedPreferences _prefs;

  getInstance() async {
    _prefs = await SharedPreferences.getInstance();
  }

  savePokemons(List<Pokemon> pokemons) async {
    List<String> jsonPokemons =
        pokemons.map((pokemon) => jsonEncode(pokemon.toJson())).toList();
    _prefs.setStringList("pokemons", jsonPokemons);
  }

  List<Pokemon> getPokemons() {
    List<String> jsonPokemons = _prefs.getStringList("pokemons");
    print(jsonPokemons);
    if (jsonPokemons != null) {
      List<Pokemon> pokemons = jsonPokemons
          .map((pokemon) => Pokemon.fromJsonShared(json.decode(pokemon)))
          .toList();
      return pokemons;
    }
  }
}
