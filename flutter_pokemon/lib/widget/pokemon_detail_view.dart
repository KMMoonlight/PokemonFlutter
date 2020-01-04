import 'package:flutter/material.dart';
import 'package:flutter_pokemon/net/net.dart';
import 'package:dio/dio.dart';
import 'dart:convert' as convert;
import 'package:flutter_pokemon/model/pokemon_detail.dart';


class DetailView extends StatefulWidget {

  final String number;

  DetailView(@required this.number) : super();


  @override
  _DetailViewState createState() => _DetailViewState();

}

class _DetailViewState extends State<DetailView> {


  PokemonDetailModel _pokemonDetailModel;

  bool _loadingFinish = false;

  String _type = "";
  String _weakness = "";

  void getDetailPokemonInfo() async {
    Response response =  await dio.get("http://49.235.90.5:5000/pokemon/" + this.widget.number);
    _pokemonDetailModel = PokemonDetailModel.fromJson(convert.jsonDecode(response.data));
    for(String item in _pokemonDetailModel.type){
      _type = _type + item + "     ";
    }

    for(String item in _pokemonDetailModel.weakness) {
      _weakness = _weakness + item + "     ";
    }
    setState(() {
      _loadingFinish = true;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getDetailPokemonInfo();
  }


  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
        appBar: AppBar(
            title: Image.asset("image/logo.png", height: 40,)
        ),
        body: _loadingFinish ? Container(
          color: Colors.black87,
          child: ListView(
            children: <Widget>[
              Center(
                child: Stack(
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.only(top: 20),
                      child: Image.asset("image/pokemon_circle_bg.png", height: 200),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 20),
                      child: Image.network("http://49.235.90.5/img/" + _pokemonDetailModel.pokemon_image.split("pm/")[1], height: 200),
                    )
                  ],
                ),
              ),
              Container(
                child: Row(
                  children: <Widget>[
                    Expanded(
                      child: Container(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Text(
                              _pokemonDetailModel.number,
                              style: TextStyle(
                                  fontSize: 24,
                                  color: Color(int.parse("0xffb4ebff"))
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(top: 20),
                              child: Text(
                                _pokemonDetailModel.name,
                                style: TextStyle(
                                    fontSize: 24,
                                    color: Colors.white
                                ),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(top: 20),
                              child: Text(
                                _pokemonDetailModel.category,
                                style: TextStyle(
                                    fontSize: 24,
                                    color: Colors.white
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                      flex: 1,
                    ),
                    Expanded(
                      child: Container(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Text(
                              "身高: " + _pokemonDetailModel.height,
                              style: TextStyle(
                                  fontSize: 24,
                                  color: Color(int.parse("0xffF1BC37"))
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(top: 20),
                              child: Text(
                                "体重: " + _pokemonDetailModel.weight,
                                style: TextStyle(
                                    fontSize: 24,
                                    color: Color(int.parse("0xffF1BC37"))
                                ),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(top: 20),
                              child: Text(
                                "特性: " + _pokemonDetailModel.abilities,
                                style: TextStyle(
                                    fontSize: 24,
                                    color: Color(int.parse("0xffF1BC37"))
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                      flex: 1,
                    )
                  ],
                ),
                height: 200,
                margin: EdgeInsets.only(top: 20),
                padding: EdgeInsets.all(20),
                decoration: BoxDecoration(
                   border: Border.all(
                     width: 2,
                     color: Colors.white
                   ),
                  borderRadius: BorderRadius.circular(16.0)
                ),
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(20,20,0,0),
                child: Text(
                  "属性:",
                  style: TextStyle(
                    fontSize: 22,
                    color: Colors.green[400]
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(20,10,0,0),
                child: Text(
                  _type,
                  style: TextStyle(
                      fontSize: 20,
                      color: Colors.white
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(20,20,0,0),
                child: Text(
                  "弱点:",
                  style: TextStyle(
                      fontSize: 22,
                      color: Colors.redAccent
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(20,10,0,0),
                child: Text(
                  _weakness,
                  style: TextStyle(
                      fontSize: 20,
                      color: Colors.white
                  ),
                ),
              ),
              StoryView(_pokemonDetailModel.story_a, _pokemonDetailModel.story_b),
              LevelView(_pokemonDetailModel.hp, _pokemonDetailModel.attack, _pokemonDetailModel.defense, _pokemonDetailModel.special_attack, _pokemonDetailModel.special_defense, _pokemonDetailModel.speed),
              EvolutionView(_pokemonDetailModel.evolution),
            ],
          ),
          padding: EdgeInsets.only(bottom: 20),
        ) : Container(
          child: Center(
            child: Text("加载中......", style: TextStyle(
                fontSize: 30,
              color: Colors.white
            ),),
          ),
          color: Colors.black87,
        ),
      ),
    );
  }
}





class EvolutionView extends StatelessWidget {

  final List<EvolutionModel> evolutionModelList;
  
  EvolutionView(@required this.evolutionModelList);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 20),
      child: Column(
        children: <Widget>[
          Text(
            "进化列表",
            style: TextStyle(
              fontSize: 22,
              color: Colors.white
            ),
          ),
          getEvolutionList(evolutionModelList),
        ],
      ),
    );
  }
}




Widget getEvolutionList(List<EvolutionModel> evolutionModelList){

  List<Widget> colList = List();


  for(int i = 0 ; i < evolutionModelList.length; i++) {

    colList.add(Container(
      child: Column(
        children: <Widget>[
          Image.network("http://49.235.90.5/img/" + evolutionModelList[i].evolution_image.split("pm/")[1], height: 100,),
          Text(
            evolutionModelList[i].evolution_number,
            style: TextStyle(
                color: Colors.white,
                fontSize: 14
            ),
          ),
          Text(
            evolutionModelList[i].evolution_name,
            style: TextStyle(
                color: Colors.white,
                fontSize: 14
            ),
          ),
          Text(
            i != (evolutionModelList.length - 1) ? "↓\n↓\n↓\n↓" : "",
            style: TextStyle(
                color: Colors.white,
                fontSize: 14
            ),
          ),
        ],
      ),
    ));

  }

  return Column(
    children: colList,
  );

}











class StoryView extends StatefulWidget {

  final String story_a;

  final String story_b;

  StoryView(@required this.story_a, @required this.story_b);

  int _index = 1;

  Color _activeColor = Colors.limeAccent;
  Color _inActiveColor = Colors.blue;


  @override
  _StoryViewState createState() => _StoryViewState();
}

class _StoryViewState extends State<StoryView> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: <Widget>[
          Text(
            "图鉴版本",
            style: TextStyle(
                color: Color(int.parse("0xffb4ebff")),
                fontSize: 26
            ),
          ),
          Row(
            children: <Widget>[
              Expanded(
                child: GestureDetector(
                  onTap: (){
                    setState(() {
                      this.widget._index = 1;
                    });
                  },
                  child: Center(
                    child: Text(
                      "版本A",
                      style: TextStyle(
                          fontSize: 24,
                          color: this.widget._index == 1 ? this.widget._activeColor : this.widget._inActiveColor
                      ),
                    ),
                  )
                ),
                flex: 1,
              ),
              Expanded(
                child: GestureDetector(
                  onTap: (){
                    setState(() {
                      this.widget._index = 2;
                    });
                  },
                  child: Center(
                    child: Text(
                      "版本B",
                      style: TextStyle(
                          fontSize: 24,
                          color: this.widget._index == 2 ? this.widget._activeColor : this.widget._inActiveColor
                      ),
                    ),
                  )
                ),
                flex: 1,
              ),
            ],
          ),
          Padding(
            padding: EdgeInsets.only(top: 20),
            child: Text(
              this.widget._index == 1 ? this.widget.story_a : this.widget.story_b,
              style: TextStyle(
                fontSize: 20,
                color: Colors.white
              ),
            ),
          ),
        ],
      ),
      margin: EdgeInsets.only(top: 20),
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
          border: Border.all(
              width: 2,
              color: Colors.white
          ),
          borderRadius: BorderRadius.circular(16.0)
      ),
    );
  }
}



class LevelView extends StatelessWidget {

  final int hp;

  final int attack;

  final int defense;

  final int special_attack;

  final int special_defense;

  final int speed;

  LevelView(@required this.hp, @required this.attack, @required this.defense, @required this.special_attack, @required this.special_defense, @required this.speed);


  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: <Widget>[

          Container(
            height: 40,
            child: Row(
              children: <Widget>[
                Container(
                  child: Text(
                    "生命值",
                    style: TextStyle(
                        fontSize: 20,
                        color: Colors.white
                    ),
                  ),
                  width: 60,
                ),
                getStarWithValue(hp)
              ],
            ),
          ),
          Container(
            height: 40,
            child: Row(
              children: <Widget>[
                Container(
                  child: Text(
                    "攻击",
                    style: TextStyle(
                        fontSize: 20,
                        color: Colors.white
                    ),
                  ),
                  width: 60,
                ),
                getStarWithValue(attack)
              ],
            ),
          ),
          Container(
            height: 40,
            child: Row(
              children: <Widget>[
                Container(
                  child: Text(
                    "防御",
                    style: TextStyle(
                        fontSize: 20,
                        color: Colors.white
                    ),
                  ),
                  width: 60,
                ),
                getStarWithValue(defense)
              ],
            ),
          ),
          Container(
            height: 40,
            child: Row(
              children: <Widget>[
                Container(
                  child: Text(
                    "特攻",
                    style: TextStyle(
                        fontSize: 20,
                        color: Colors.white
                    ),
                  ),
                  width: 60,
                ),
                getStarWithValue(special_attack)
              ],
            ),
          ),
          Container(
            height: 40,
            child: Row(
              children: <Widget>[
                Container(
                  child: Text(
                    "特防",
                    style: TextStyle(
                        fontSize: 20,
                        color: Colors.white
                    ),
                  ),
                  width: 60,
                ),
                getStarWithValue(special_defense)
              ],
            ),
          ),
          Container(
            height: 40,
            child: Row(
              children: <Widget>[
                Container(
                  child: Text(
                    "速度",
                    style: TextStyle(
                        fontSize: 20,
                        color: Colors.white
                    ),
                  ),
                  width: 60,
                ),
                getStarWithValue(speed)
              ],
            ),
          ),


        ],
      ),
      margin: EdgeInsets.fromLTRB(20, 20, 0,0),
    );
  }
}


Widget getStarWithValue(int value){

  List<Widget> starList = List();
  value += 1;
  for(int i =0; i < value; i++) {
    starList.add(Icon(
      Icons.star,
      color: Color(int.parse("0xfff1bc37")),
    ));
  }

  return Container(
    margin: EdgeInsets.only(left: 20),
    child: Row(
      children: starList,
    ),
  );
}




