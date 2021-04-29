import 'dart:async';
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:pokeflutter/Models/pokemon.dart';

class ImageLocal {
  Future<String> _localPath() async {
    final directory = await getApplicationDocumentsDirectory();

    return directory.path;
  }

  Future<File> _localFile(String pokemonId, bool pixelImage) async {
    String title = pixelImage ? "pixel_$pokemonId" : "oficial_$pokemonId";
    final path = await _localPath();
    return File('$path/$title.txt');
  }

  saveImage(String base64Image, String pokemonId, bool pixelImage) async {
    final file = await _localFile(pokemonId, pixelImage);
    file.writeAsString(base64Image);
  }

  Future<String> readImage(String pokemonId, bool pixelImage) async {
    try {
      final file = await _localFile(pokemonId, pixelImage);
      String contents = await file.readAsString();
      return contents;
    } catch (e) {
      print("Error $e");
    }
  }
}
