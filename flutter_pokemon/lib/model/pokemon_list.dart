import 'package:flutter_pokemon/model/pokemon_normal.dart';

class PokemonListModel {

  List<PokemonNormalModel> pokemonModelList;


  PokemonListModel(
    this.pokemonModelList
  );

  factory PokemonListModel.fromJson(List<dynamic> json) {
    return PokemonListModel(
      json.map((i)=>PokemonNormalModel.fromJson(i)).toList()
    );
  }

}