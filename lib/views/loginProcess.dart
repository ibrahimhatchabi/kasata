import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:kasata/entities/Citoyen.dart';
import 'package:http/http.dart' as http;
import 'package:kasata/globals/globals.dart' as globals;
import 'package:kasata/views/alerteView.dart';
import 'package:kasata/views/home.dart';

class LoginProcess extends StatefulWidget {

  final String email;
  final String password;

  LoginProcess({
    this.email,
    this.password,
  });

  @override
  _LoginProcessState createState() => new _LoginProcessState();
}

Future<dynamic> connect(String email, String password) async {
  final response = await http.get('${globals.host}/connexion/$email/$password');
  final responseJson = json.decode(response.body);
  return responseJson;
}

class _LoginProcessState extends State<LoginProcess> {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Center(
          child: new Image.asset(
            "images/logo_kassata1.png",
            //color: const Color(0xFF00a8f6),
          ),
        ),
        backgroundColor: const Color(0xFF19222b),
        automaticallyImplyLeading: false,
      ),
      body: new FutureBuilder<dynamic>(
        future: connect(widget.email,widget.password),
        builder: (BuildContext context, AsyncSnapshot snapshot){
          if(snapshot.hasData){
            if(snapshot.data != null){
              //Its Okay!!!
              //print(snapshot.data);
              SchedulerBinding.instance.addPostFrameCallback((_) {
                print(snapshot.data);
                Navigator.of(context)
                  ..pop()
                  ..pop()
                  ..push(new MaterialPageRoute(
                    builder: (BuildContext context) =>
                     new AlertesView(
                       path: null,
                       user: new Citoyen.fromJson(snapshot.data),
                     )
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
                              "Identifiants incorrects",
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
