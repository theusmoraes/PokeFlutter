import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pokeflutter/Models/pokemon.dart';
import 'package:pokeflutter/datasource/local/images.dart';
import 'package:pokeflutter/datasource/local/pokemon_shared.dart';
import 'package:pokeflutter/datasource/remote/pokemons_remote.dart';

class PokemonController extends GetxController {
  PokemonRemote _pokemonremote = PokemonRemote();
  PokemonShared _shared = PokemonShared();
  Pokemon selectedPokemon;
  final imageLoading = false.obs;
  List<String> pokemonNames = [
    "pikachu",
    "charmander",
    "squirtle",
    "ivysaur",
    "charizard",
    "charmeleon",
    "blastoise",
    "bulbasaur",
    "wartortle",
    "venusaur",
  ];
  List<Pokemon> pokemons = [];
  final completed = false.obs;

  @override
  void onInit() {
    getAllPokemons();
    if (selectedPokemon != null) {}
    super.onInit();
  }

  selectPokemon(int index) => selectedPokemon = pokemons[index];

  Map<String, dynamic> getColor(String type) {
    Map<String, dynamic> cardColor = {
      "grass": {"primary": Color(0xFF56E799), "secondary": Color(0xFF249C5B)},
      "fire": {"primary": Color(0xFFEC2525), "secondary": Color(0xFFAF2525)},
      "water": {"primary": Color(0xFF4B9DE9), "secondary": Color(0xFF61C9EA)},
      "electric": {"primary": Color(0xFFF9E63C), "secondary": Color(0xFFDDC54A)}
    };
    return cardColor[type];
  }

  saveImage(Pokemon pokemon) async {
    String base64ImageOfficial =
        await _pokemonremote.networkImageToBase64(pokemon.officialArtwork);
    String base64ImageSprite =
        await _pokemonremote.networkImageToBase64(pokemon.sprite);
    if (base64ImageOfficial != null) {
      print("Imagem official a caminho de ser salva");
      await ImageLocal()
          .saveImage(base64ImageOfficial, pokemon.id.toString(), false);
    }
    if (base64ImageSprite != null) {
      print("Sprite a caminho de ser salva");
      await ImageLocal()
          .saveImage(base64ImageSprite, pokemon.id.toString(), true);
    }
  }

  Future<Uint8List> getImage(String pokemonId, isSprite) async {
    print("entrei");
    String base64Image = await ImageLocal().readImage(pokemonId, isSprite);
    if (base64Image != null) {
      final decodedBytes = base64Decode(base64Image);
      return decodedBytes;
    }
  }

  getAllPokemons() async {
    await _shared.getInstance();
    Uint8List official;
    Uint8List sprite;
    List<Pokemon> result = _shared.getPokemons();
    if (result != null) {
      //CASO ESTEJA ARMAZENADO NO SHARED
      await Future.forEach(result, (Pokemon element) async {
        official = await getImage(element.id.toString(), false);
        sprite = await getImage(element.id.toString(), true);
        if (official != null && sprite != null) {
          element.setOfflineImages(official, sprite);
          pokemons.add(element);
        }
      });
      print("Entrei pelo shared");
    } else {
      print("Entrei pelo http");

      // CASO NAO ESTEJA ARMAZENADO NO SHARED
      await Future.forEach((pokemonNames), (name) async {
        var pokemon = await _pokemonremote.getPokemon(name.toString());
        if (pokemon != null) {
          saveImage(pokemon);
          official = await getImage(pokemon.id.toString(), false);
          sprite = await getImage(pokemon.id.toString(), true);
          if (official != null && sprite != null) {
            pokemon.setOfflineImages(official, sprite);
          }

          pokemons.add(pokemon);
        } else {
          print("Pokemon $name não encontrado");
        }
      });
      pokemons.sort((a, b) => a.id.compareTo(b.id));
      _shared.savePokemons(pokemons);
    }
    pokemons.forEach((element) {
      print(element.name);
    });
    completed.value = true;
  }
}
