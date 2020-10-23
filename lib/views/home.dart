import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:kasata/entities/Info.dart';
import 'package:kasata/entities/Alerte.dart';

import 'package:kasata/globals/globals.dart' as globals;
import 'package:http/http.dart' as http;
import 'package:kasata/views/alerteView.dart';
import 'package:kasata/views/login.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => new _HomeState();
}
TextStyle _myTextStyle = new TextStyle(
    fontFamily: 'LiberationSerif',
    fontSize: 20.0,
    color: Colors.white,//const Color(0xFF00a8f6),
    //color: color
);
class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {

    Future<List<Info>> _fetchInfos() async {
      final response = await http.get('${globals.host}/infos');
      final responseJson = json.decode(response.body);
      List<Info> liste = new List<Info>();
      //return new Compte.fromJson(responseJson);
      final items = (responseJson as List).map((i) => new Info.fromJson(i));
      for (final item in items) {
        liste.add(item);
      }
      //print("-------------------------------------------- fetchBA, time: ${DateTime.now().toIso8601String()}");
      return liste;
    }

    Future<List<Widget>> _fetchAlertes() async {
      final response = await http.get('${globals.host}/alertes');
      final responseJson = json.decode(response.body);
      List<Widget> liste = new List<Widget>();
      final items = (responseJson as List).map((i) => new Alerte.fromJson(i));
      for (final item in items) {
        liste.add(item);
      }
      //print("-------------------------------------------- fetchBA, time: ${DateTime.now().toIso8601String()}");
      return liste;
    }

    return new DefaultTabController(
      length: 3,
      child: new Scaffold(
        floatingActionButton: new FloatingActionButton(
          child: new Icon(Icons.add_alert),
          onPressed: (){
            Navigator.of(context)
              ..pop()
              ..push(new MaterialPageRoute(
                builder: (BuildContext context) => new Login(),
              ));
          },
        ),
        backgroundColor: Colors.white,
        appBar: new AppBar(
          title: new Center(
            child: new Image.asset(
              "images/logo_kassata1.png",
              //color: const Color(0xFF00a8f6),
            ),
          ),
          backgroundColor: const Color(0xFF19222b),
          automaticallyImplyLeading: false,
          leading: IconButton(
            icon: Icon(Icons.more_vert),
            onPressed: (){
              //Todo:
            }
          ),
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.person),
              onPressed: (){
                //Todo:
              }
            )
          ],
          bottom: new TabBar(
            labelStyle: new TextStyle(
              //fontWeight: FontWeight.bold,
              fontFamily: 'LiberationSerif',
              fontSize: 20.0,
            ),
            indicatorColor: const Color(0xFF00a8f6),
            unselectedLabelColor: Colors.grey,
            isScrollable: true,
            tabs: [
              new Tab(
                text: 'Alertes',
              ),
              new Tab(
                text: 'Infos',
              ),
              new Tab(
                text: 'Annuaire',
              ),
            ],
          ),
        ),
        body: new TabBarView(
          children: [
            //Alertes
            new Form(
              //key: _formKeyPers,
              child: new FutureBuilder<List<Widget>>(
                future: _fetchAlertes(),
                builder: (BuildContext context, AsyncSnapshot snapshot){
                  if(snapshot.hasData) {

                    return new Form(
                      //key: _formKeyInt,
                      child: new Padding(
                        padding: const EdgeInsets.only(top: 20.0),
                        child: new ListView(
                          children: snapshot.data,
                        ),
                      ),
                    );
                  }
                  else if (snapshot.hasError) {
                    return new ListView(
                      children: <Widget>[
                        new Text("${snapshot.error}"),
                      ]
                    );
                  }
                  return new Container(
                    color: Colors.white,
                    padding: new EdgeInsets.all(50.0),
                    child: new Column(
                      children: [
                        new CircularProgressIndicator(),
                        new Container(
                          padding: new EdgeInsets.only(top: 10.0),
                          child: new Text(
                            "Chargement",
                            style: new TextStyle(
                              //fontWeight: FontWeight.bold,
                              letterSpacing: 1.0,
                              fontFamily: "liberationSerif",
                              fontSize: 20.0,
                            )
                          ),
                        ),
                      ],
                    ),
                  );
                }
              ),
            ),
            //Infos
            new Container(
              child:new FutureBuilder<List<Info>>(
                future: _fetchInfos(),
                builder: (BuildContext context, AsyncSnapshot snapshot){
                  if(snapshot.hasData){
                    return new Form(
                      //key: _formKeyInt,
                      child: new Padding(
                        padding: const EdgeInsets.only(top: 20.0),
                        child: new ListView(
                          children: snapshot.data, /*<Widget>[
                            new Info(
                              //image: 'images/infoAsset1.jpg',
                              image: 'https://firebasestorage.googleapis.com/v0/b/kassata-ab137.appspot.com/o/infoAsset1.jpg?alt=media&token=a8d414c5-8938-4e36-8045-5deaf10810ff',
                              title: 'La Nigelec prévient son aimable clinetèle de la chute d\'un poteau sur la route de Maradi. Les travaux sont en cours. Avec la nigelec le courant trépasse!',
                              hour:  'Il y a 10 heures',
                            ),
                            new Info(
                              //image: 'images/infoAsset4.jpg',
                              image: 'https://firebasestorage.googleapis.com/v0/b/kassata-ab137.appspot.com/o/infoAsset4.jpg?alt=media&token=56d5943d-3ffc-4269-9854-4bdefb37de86',
                              title: 'Des travaux commenceront le samedi 04 août 2018 sur la voie du allant du rond point 6è au cinéma zabarkan, pour tout désagrément éviter ce tronçon.',
                              hour:  'Il y a 04 heures',
                            ),
                            new Info(
                              //image: 'images/infoAsset2.jpg',
                              image: 'https://firebasestorage.googleapis.com/v0/b/kassata-ab137.appspot.com/o/infoAsset2.jpg?alt=media&token=8008b4ea-b653-4562-a780-d95c83b9cdeb',
                              title: 'A cause de travaux en cours, des baisses de pressions seront observées durant la nuit du 1er au 02 aôut 2018. La SEEN s\'excuse auprès de son aimable clientèle.',
                              hour:  'Il y a 08 heures',
                            ),
                            new Info(
                              //image: 'images/infoAsset3.jpg',
                              image: 'https://firebasestorage.googleapis.com/v0/b/kassata-ab137.appspot.com/o/infoAsset3.jpg?alt=media&token=d165527b-02c6-4165-97af-7976e8e00b25',
                              title: 'Des bourses d\'études pour l\'année académique 2018/2019 sont disponibles.',
                              hour:  'Il y a 07 heures',
                            ),
                          ],*/
                        ),
                      ),
                    );
                  }else if(snapshot.hasError){

                  }
                  return new Container(
                    color: Colors.white,
                    padding: new EdgeInsets.all(50.0),
                    child: new Column(
                      children: [
                        new CircularProgressIndicator(),
                        new Container(
                          padding: new EdgeInsets.only(top: 10.0),
                          child: new Text(
                            "Chargement",
                            style: new TextStyle(
                              //fontWeight: FontWeight.bold,
                              letterSpacing: 1.0,
                              fontFamily: "liberationSerif",
                              fontSize: 20.0,
                            )
                          ),
                        ),
                      ],
                    ),
                  );
              }),
            ),
            //Annuaire
            new Form(
              //key: _formKeyExt,
              child: new Center(
                //padding: const EdgeInsets.only(top: 20.0),
                child: new GridView.count(
                  primary: false,
                  shrinkWrap: true,
                  padding: const EdgeInsets.all(0.0),
                  crossAxisSpacing: 10.0,
                  crossAxisCount: 2,
                  children: <Widget>[
                    new Container(
                      margin: new EdgeInsets.all(10.0),
                      decoration: new BoxDecoration(
                        color: const Color(0xFF19222b),
                        borderRadius: new BorderRadius.circular(10.0),
                      ),
                      child: new Center(
                        child: new FlatButton(
                          onPressed: (){
                            //onTap(title1);
                          },
                          child: new Column(
                            children: <Widget>[
                              new Image.asset(
                                'images/annuaireAsset1.png',
                                color: const Color(0xFF00a8f6),
                                height: 120.0,
                                width: 120.0,
                              ),
                              new FittedBox(
                                fit: BoxFit.contain,
                                child: new Center(
                                  child: new Padding(
                                    padding: new EdgeInsets.only(top:10.0),
                                    child: new Text(
                                      'Urgences',
                                      style: _myTextStyle,
                                    ),
                                  ),
                                ),
                              )
                            ],
                          )
                        ),
                      ),
                    ),
                    new Container(
                      margin: new EdgeInsets.all(10.0),
                      decoration: new BoxDecoration(
                        color: const Color(0xFF19222b),
                        borderRadius: new BorderRadius.circular(10.0),
                      ),
                      child: new Center(
                        child: new FlatButton(
                          onPressed: (){
                            //onTap(title2);
                          },
                          child: new Column(
                            children: <Widget>[
                              new Image.asset(
                                'images/annuaireAsset2.png',
                                color: const Color(0xFF00a8f6),
                                height: 120.0,
                                width: 120.0,
                              ),
                              new FittedBox(
                                fit: BoxFit.contain,
                                child: new Center(
                                  child: new Padding(
                                    padding: new EdgeInsets.only(top:10.0),
                                    child: new Text(
                                      'Police',
                                      style: _myTextStyle,
                                    ),
                                  ),
                                ),
                              )
                            ],
                          )
                        ),
                      ),
                    ),
                    new Container(
                      margin: new EdgeInsets.all(10.0),
                      decoration: new BoxDecoration(
                        color: const Color(0xFF19222b),
                        borderRadius: new BorderRadius.circular(10.0),
                      ),
                      child: new Center(
                        child: new FlatButton(
                          onPressed: (){
                            //onTap(title3);
                          },
                          child: new Column(
                            children: <Widget>[
                              new Image.asset(
                                'images/annuaireAsset3.png',
                                color: const Color(0xFF00a8f6),
                                height: 120.0,
                                width: 120.0,
                              ),
                              new FittedBox(
                                fit: BoxFit.contain,
                                child: new Center(
                                  child: new Padding(
                                    padding: new EdgeInsets.only(top:10.0),
                                    child: new Text(
                                      'Municipalité',
                                      style: _myTextStyle,
                                    ),
                                  ),
                                ),
                              )
                            ],
                          )
                        ),
                      ),
                    ),
                    new Container(
                      margin: new EdgeInsets.all(10.0),
                      decoration: new BoxDecoration(
                        color: const Color(0xFF19222b),
                        borderRadius: new BorderRadius.circular(10.0),
                      ),
                      child: new Center(
                        child: new FlatButton(
                          onPressed: (){
                            //onTap(title4);
                          },
                          child: new Column(
                            children: <Widget>[
                              new Image.asset(
                                'images/annuaireAsset4.png',
                                color: const Color(0xFF00a8f6),
                                height: 120.0,
                                width: 120.0,
                              ),
                              new FittedBox(
                                fit: BoxFit.contain,
                                child: new Center(
                                  child: new Padding(
                                    padding: new EdgeInsets.only(top:10.0),
                                    child: new Text(
                                      'Hopitaux',
                                      style: _myTextStyle,
                                    ),
                                  ),
                                ),
                              )
                            ],
                          )
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

