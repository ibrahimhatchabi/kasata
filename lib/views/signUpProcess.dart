import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:kasata/entities/Citoyen.dart';
import 'package:http/http.dart' as http;
import 'package:kasata/globals/globals.dart' as globals;

class SignUpProcess extends StatefulWidget {

  final Citoyen citoyen;

  SignUpProcess({
    this.citoyen,
  });

  @override
  _SignUpProcessState createState() => new _SignUpProcessState();
}
Map<String,String> headers = {"content-type":"application/json","accept":"application/json"};

Future<String> addCitoyen(Citoyen citoyen) async {
  print(citoyen.toJson());
  final response = await http.post('${globals.host}/addCitoyen',headers: headers,body: citoyen.toJson());
  return response.body;
}

class _SignUpProcessState extends State<SignUpProcess> {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Center(
          child: new Image.asset(
            "images/logo_kassata.png",
            color: const Color(0xFF00a8f6),
          ),
        ),
        backgroundColor: const Color(0xFF19222b),
        automaticallyImplyLeading: false,
      ),
      body: new FutureBuilder<String>(
        future: addCitoyen(widget.citoyen),
        builder: (BuildContext context, AsyncSnapshot snapshot){
        if(snapshot.hasData){
          if(snapshot.data == "1"){
            //Its Okay!!!
            SchedulerBinding.instance.addPostFrameCallback((_) {
              showDialog<Null>(
                context: context,
                barrierDismissible: false, // user must tap button!
                child: new AlertDialog(
                  title: new Text("Information"),
                  content: new SingleChildScrollView(
                    child: new ListBody(
                      children: <Widget>[
                        new Text(
                          "Votre compte a été crée. Connectez-vous pour continuer",
                        )
                      ],
                    ),
                  ),
                  actions: <Widget>[
                    new FlatButton(
                      child: new Text(
                        "Okay",
                      ),
                      onPressed: () {
                        Navigator.of(context)
                          ..pop()
                          ..pop();
                      },
                    ),
                  ],
                )
              );
            });
          } else {
            //Not Okay!!!
            SchedulerBinding.instance.addPostFrameCallback((_) {
              showDialog<Null>(
                context: context,
                barrierDismissible: false, // user must tap button!
                child: new AlertDialog(
                  title: new Text("Erreur"),
                  content: new SingleChildScrollView(
                    child: new ListBody(
                      children: <Widget>[
                        new Text(
                          "Désolé, un problème est survenu. Veuillez reéssayer plutard",
                        )
                      ],
                    ),
                  ),
                  actions: <Widget>[
                    new FlatButton(
                      child: new Text(
                        "Okay",
                      ),
                      onPressed: () {
                        Navigator.of(context)
                          ..pop();
                      },
                    ),
                  ],
                )
              );
            });
          }
        } else if(snapshot.hasError){
          return new ListView(
            children: <Widget>[
              new Text("${snapshot.error}"),
            ]
          );
        }
        return Center(
          child: new Container(
            color: Colors.white,
            padding: new EdgeInsets.all(50.0),
            child: new Column(
              children: [
                new CircularProgressIndicator(),
                new Container(
                  padding: new EdgeInsets.only(top: 10.0),
                  child: new Text(
                    "Chargement ...",
                    style: new TextStyle(
                      //fontWeight: FontWeight.bold,
                      letterSpacing: 1.0,
                      fontFamily: "bebas",
                      fontSize: 20.0,
                    )
                  ),
                ),
              ],
            ),
          ),
        );
      }),
    );
  }
}
