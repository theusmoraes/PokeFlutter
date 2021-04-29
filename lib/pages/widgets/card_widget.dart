import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pokeflutter/Controller/pokemon_controller.dart';
import 'package:pokeflutter/Models/pokemon.dart';
import 'package:pokeflutter/pages/details_pokemon_page.dart';

class PokemonCard extends StatelessWidget {
  final PokemonController controller = Get.find();
  final int index;
  PokemonCard({Key key, @required this.index}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final color = controller.getColor(controller.selectedPokemon.types[0]);

    return GestureDetector(
      onTap: () => {
        controller.selectPokemon(index),
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => DetailsPokemon())),
      },
      child: Container(
        decoration: BoxDecoration(
            color: color["primary"],
            borderRadius: BorderRadius.all(Radius.circular(10))),
        height: Get.height * 0.18,
        width: Get.width * 0.40,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(15, 10, 10, 5),
              child: Text(
                controller.selectedPokemon.name.capitalize,
                style: TextStyle(fontSize: 24, color: Colors.white),
              ),
            ),
            Row(
              children: [
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        width: 60,
                        height: 60,
                        child: Padding(
                          padding: const EdgeInsets.only(top: 4.0),
                          child: ListView.builder(
                              itemCount:
                                  controller.selectedPokemon.types.length,
                              itemBuilder: (BuildContext context, int index) {
                                return Padding(
                                  padding: const EdgeInsets.only(bottom: 10),
                                  child: Container(
                                    width: 55,
                                    height: 18,
                                    decoration: BoxDecoration(
                                        color: color["secondary"],
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(10))),
                                    child: Center(
                                      child: Text(
                                        controller.selectedPokemon.types[index],
                                        style: TextStyle(color: Colors.white),
                                      ),
                                    ),
                                  ),
                                );
                              }),
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Container(
                    child: Image.memory(
                      controller.selectedPokemon.spriteOffline,
                      fit: BoxFit.fitWidth,
                      width: 65,
                      height: 65,
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
