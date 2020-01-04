class PokemonNormalModel {

  String pokemonName;
  double weight;
  String pokemonTypeId;
  String fileName;
  String pokemonSubName;
  int zukanSubId;
  String zukanId;
  String pokemonTypeName;
  double height;

  PokemonNormalModel({
    this.pokemonName,
    this.weight,
    this.pokemonTypeId,
    this.fileName,
    this.pokemonSubName,
    this.zukanSubId,
    this.zukanId,
    this.pokemonTypeName,
    this.height
  });



  factory PokemonNormalModel.fromJson(Map<String, dynamic> json) {
    return PokemonNormalModel(
      pokemonName : json['pokemon_name'],
      weight : json['weight'].toDouble(),
      pokemonTypeId : json['pokemon_type_id'],
      fileName : json['file_name'],
      pokemonSubName : json['pokemon_sub_name'],
      zukanSubId : json['zukan_sub_id'],
      zukanId : json['zukan_id'],
      pokemonTypeName : json['pokemon_type_name'],
      height : json['height'].toDouble()
    );
  }


}