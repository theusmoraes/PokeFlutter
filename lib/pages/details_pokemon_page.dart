import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:get/get.dart';
import 'package:pokeflutter/Controller/pokemon_controller.dart';
import 'package:pokeflutter/datasource/remote/pokemons_remote.dart';

class DetailsPokemon extends StatelessWidget {
  final PokemonController controller = Get.find();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
      ),
      backgroundColor:
          controller.getColor(controller.selectedPokemon.types[0])["primary"],
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Align(
            alignment: Alignment.center,
            child: Container(
              child: Image.memory(
                controller.selectedPokemon.oficialOffiline,
                width: Get.width * 0.8,
                height: Get.height * 0.4,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 20.0),
            child: Text(
              controller.selectedPokemon.name.capitalize,
              style: TextStyle(color: Colors.white, fontSize: 45),
            ),
          ),
          Text(
            "#00${controller.selectedPokemon.id}",
            style: TextStyle(color: Colors.white, fontSize: 30),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 30.0),
            child: Container(
              width: Get.width,
              height: 35,
              child: Align(
                alignment: Alignment.center,
                child: ListView.builder(
                    shrinkWrap: true,
                    scrollDirection: Axis.horizontal,
                    itemCount: controller.selectedPokemon.types.length,
                    itemBuilder: (BuildContext contex, int index) {
                      return Padding(
                        padding: EdgeInsets.only(left: 10.0, right: 10),
                        child: Container(
                          width: 125,
                          decoration: BoxDecoration(
                              color: controller.getColor(controller
                                  .selectedPokemon.types[0])["secondary"],
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10))),
                          child: Center(
                            child: Text(
                              controller.selectedPokemon.types[index],
                              style:
                                  TextStyle(color: Colors.white, fontSize: 20),
                            ),
                          ),
                        ),
                      );
                    }),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 40.0),
            child: Text(
              "Hability: ${controller.selectedPokemon.ability}",
              style: TextStyle(color: Colors.white, fontSize: 30),
            ),
          ),
        ],
      ),
    );
  }
}
