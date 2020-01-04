import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_pokemon/model/pokemon_list.dart';
import 'package:flutter_pokemon/net/net.dart';
import 'dart:convert' as convert;
import 'package:flutter_pokemon/widget/pokemon_detail_view.dart';

class PokemonList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
        appBar: AppBar(
          title: Image.asset(
              "image/logo.png",
              height: 40,
          ),
        ),
        body: PokemonListView(),
      ),
    );
  }
}


class PokemonListView extends StatefulWidget {


  @override
  _PokemonListViewState createState() => _PokemonListViewState();



}

class _PokemonListViewState extends State<PokemonListView> {

  PokemonListModel _pokemonListModel;
  int _list_count = 0;

  @override
  void initState() {
    super.initState();
    getPokemonList();
  }

  void getPokemonList() async{
    Response response = await dio.get("http://49.235.90.5:5000/list");
    _pokemonListModel = PokemonListModel.fromJson(convert.jsonDecode(response.data));

    setState(() {
      _list_count = _pokemonListModel.pokemonModelList.length;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListView.builder(
          itemBuilder: (context, index){
              return GestureDetector(
                child: Card(
                  margin: EdgeInsets.all(10.0),
                  child: Column(
                    children: <Widget>[
                      Stack(
                        children: <Widget>[
                          Image.asset(
                            "image/pokemon_circle_bg.png",
                            height: 200,
                          ),
                          Image.network(
                            "http://49.235.90.5/img/" + _pokemonListModel.pokemonModelList[index].fileName.split("pm/")[1],
                            height: 200,
                          ),
                        ],
                      ),
                      Container(
                        height: 130,
                        child: Center(
                          child: Column(
                            children: <Widget>[
                              Padding(
                                padding: EdgeInsets.only(top: 10),
                                child: Text(
                                  _pokemonListModel.pokemonModelList[index].zukanId,
                                  style: TextStyle(
                                      fontSize: 22,
                                      color: Color(int.parse("0xffb4ebff"))
                                  ),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.only(top: 10),
                                child: Text(
                                  _pokemonListModel.pokemonModelList[index].pokemonName,
                                  style: TextStyle(
                                      fontSize: 22,
                                      color: Colors.white
                                  ),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.only(top: 10),
                                child: Text(
                                  _pokemonListModel.pokemonModelList[index].pokemonTypeName,
                                  style: TextStyle(
                                      fontSize: 22,
                                      color: Color(int.parse("0xffF1BC37"))
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        decoration: BoxDecoration(
                            border: Border.all(
                                width: 2,
                                color: Colors.white,
                                style : BorderStyle.solid
                            ),
                            color: Colors.black
                        ),
                      )

                    ],
                  ),
                  color: Colors.white,
                ),
                onTap: (){
                  Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => DetailView( _pokemonListModel.pokemonModelList[index].zukanId,))
                  );
                },
              );
          },
          itemCount: _list_count
      ),
      decoration: BoxDecoration(
        color: Colors.black87
      ),
    );
  }
}

