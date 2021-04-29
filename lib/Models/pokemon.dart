import 'dart:typed_data';

class Pokemon {
  int id;
  String name;
  String ability;
  List<String> types;
  String sprite;
  String officialArtwork;
  Uint8List spriteOffline;
  Uint8List oficialOffiline;

  Pokemon(
      {this.ability,
      this.id,
      this.name,
      this.types,
      this.sprite,
      this.officialArtwork});

  factory Pokemon.fromJson(Map<String, dynamic> json) {
    List<String> types = [];
    var list = json["types"] as List;
    list.forEach((value) => types.add(value["type"]["name"]));
    return Pokemon(
        id: json["id"],
        name: json["name"],
        ability: json["abilities"][0]["ability"]["name"],
        officialArtwork: json["sprites"]["other"]["official-artwork"]
            ["front_default"],
        sprite: json["sprites"]["front_default"],
        types: types);
  }
  factory Pokemon.fromJsonShared(Map<String, dynamic> json) {
    var list = json["types"] as List;
    List<String> types = [];
    list.forEach((value) => types.add(value));

    return Pokemon(
        id: json["id"],
        name: json["name"],
        ability: json["ability"],
        officialArtwork: json["officialArtwork"],
        sprite: json["sprites"],
        types: types);
  }

  Map<String, dynamic> toJson() {
    Map<String, dynamic> data = new Map<String, dynamic>();
    data["name"] = this.name;
    data["ability"] = this.ability;
    data["id"] = this.id;
    data["types"] = this.types;
    data["sprites"] = this.sprite;
    data["officialArtwork"] = this.officialArtwork;
    return data;
  }

  setOfflineImages(Uint8List official, Uint8List sprite) {
    this.spriteOffline = sprite;
    this.oficialOffiline = official;
  }
}
