import 'dart:convert';
import 'package:http/http.dart' as http;

import 'package:pokeflutter/Models/pokemon.dart';

class PokemonRemote {
  Future<Pokemon> getPokemon(String name) async {
    try {
      http.Response response =
          await http.get(Uri.parse("https://pokeapi.co/api/v2/pokemon/$name"));
      Map<String, dynamic> json =
          jsonDecode(response.body) as Map<String, dynamic>;
      Pokemon pokemon = Pokemon.fromJson(json);
      return pokemon;
    } catch (error) {
      print("Erro on get $error");
    }
  }

  Future<String> networkImageToBase64(String imageUrl) async {
    http.Response response = await http.get(Uri.parse(imageUrl));
    final bytes = response.bodyBytes;
    return (bytes != null ? base64Encode(bytes) : null);
  }
}
