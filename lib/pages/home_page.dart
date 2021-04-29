import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pokeflutter/Controller/pokemon_controller.dart';
import 'package:pokeflutter/pages/widgets/card_widget.dart';

class MyHomePage extends StatelessWidget {
  MyHomePage({Key key}) : super(key: key);
  final controller = Get.put(PokemonController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("Pokedex"),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Container(
            child: GetX<PokemonController>(
              builder: (_) {
                return _.completed.isFalse
                    ? CircularProgressIndicator()
                    : Container(
                        width: Get.width,
                        height: Get.height,
                        child: GridView.builder(
                          itemCount: 10,
                          gridDelegate:
                              SliverGridDelegateWithMaxCrossAxisExtent(
                                  maxCrossAxisExtent: 200,
                                  childAspectRatio: 3 / 2,
                                  crossAxisSpacing: 20,
                                  mainAxisSpacing: 20),
                          itemBuilder: (BuildContext context, int index) {
                            _.selectPokemon(index);

                            return PokemonCard(index: index);
                          },
                        ),
                      );
              },
            ),
          ),
        ),
      ),
    );
  }
}
