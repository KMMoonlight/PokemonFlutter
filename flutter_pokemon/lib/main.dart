import 'package:flutter/material.dart';
import 'package:flutter_pokemon/widget/pokemon_listview.dart';

void main() => runApp(MyApp());



class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Pokemon",
      home: PokemonList(),
      theme: ThemeData(
        primaryColor: Colors.blue
      ),
    );
  }
}
