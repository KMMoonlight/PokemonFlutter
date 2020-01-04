import 'dart:convert' as convert;

class PokemonDetailModel {

  String pokemon_image;

  String story_a;

  String story_b;

  int attack;

  int defense;

  int special_attack;

  String category;

  int speed;

  int hp;

  String sub_name;

  String weight;

  String name;

  String number;

  List<dynamic> weakness;

  List<dynamic> type;

  int special_defense;

  String abilities;

  String height;

  List<EvolutionModel> evolution;

  PokemonDetailModel({this.pokemon_image, this.story_a, this.story_b,
      this.attack, this.defense, this.special_attack, this.category, this.speed,
      this.hp, this.sub_name, this.weight, this.name, this.number,
      this.weakness, this.type, this.special_defense, this.abilities,
      this.height, this.evolution});

  factory PokemonDetailModel.fromJson(Map<String, dynamic> json) {

    List<EvolutionModel> evolutionList = List();
    for(dynamic item in json["evolution"]) {
      evolutionList.add(EvolutionModel.fromJson(item));
    }

    return PokemonDetailModel(
      pokemon_image: json["pokemon_image"],
      story_a: json["story_a"],
      story_b: json["story_b"],
      attack: json["attack"],
      defense: json["defense"],
      special_attack: json["special_attack"],
      category: json["category"],
      speed: json["speed"],
      hp: json["hp"],
      sub_name: json["sub_name"],
      weight: json["weight"],
      name: json["name"],
      number: json["number"],
      weakness: json["weakness"],
      type: json["type"],
      special_defense: json["special_defense"],
      abilities: json["abilities"],
      height: json["height"],
      evolution: evolutionList,
    );
  }

}



class EvolutionModel {

  String evolution_image;

  String evolution_name;

  String evolution_number;

  EvolutionModel({this.evolution_name, this.evolution_image, this.evolution_number});

  factory EvolutionModel.fromJson(Map<String, dynamic> json) {
    return EvolutionModel(
      evolution_image: json["evolution_image"],
      evolution_name:  json["evolution_name"],
      evolution_number:  json["evolution_number"]
    );
  }

}