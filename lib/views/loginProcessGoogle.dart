import 'dart:async';
import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:http/http.dart' as http;
import 'package:kasata/entities/Citoyen.dart';
import 'package:kasata/globals/globals.dart' as globals;
import 'package:kasata/views/alerteView.dart';

class LoginProcessGoogle extends StatefulWidget {
  @override
  _LoginProcessGoogleState createState() => new _LoginProcessGoogleState();
}

class _LoginProcessGoogleState extends State<LoginProcessGoogle> {

  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn googleSignIn = new GoogleSignIn();
  FirebaseUser user;
  Map<String,String> headers = {"content-type":"application/json","accept":"application/json"};

  Future<dynamic> addCitoyen(Citoyen citoyen) async {
    final response = await http.post('${globals.host}/addCitoyenFromGoogle',headers: headers,body: citoyen.toJson());
    final responseJson = json.decode(response.body);
    return responseJson;
  }


  Future<FirebaseUser> _signIn() async{
    GoogleSignInAccount googleSignInAccount = await googleSignIn.signIn();
    GoogleSignInAuthentication googleSignInAuthentication = await googleSignInAccount.authentication;

    FirebaseUser user = await _auth.signInWithGoogle(
        idToken: googleSignInAuthentication.idToken,
        accessToken: googleSignInAuthentication.accessToken
    );

    //print("Username: ${user.displayName}");

    return user;
  }

  Future<dynamic> connect() async {
    user = await _signIn();
    final response = await http.get('${globals.host}/connexionGoogle/${user.email}');
    if(response.body != ""){
      final responseJson = json.decode(response.body);
      return responseJson;
    } else {
      return "none";
    }
  }


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
      body: new FutureBuilder(
        future: connect(),
        builder: (BuildContext context, AsyncSnapshot snapshot){
          if(snapshot.hasData){
            if(snapshot.data != "none"){
              //Its Okay!!!
              //print(snapshot.data);
              SchedulerBinding.instance.addPostFrameCallback((_) {
                Navigator.of(context)
                  ..pop()
                  ..pop()
                  ..push(new MaterialPageRoute(
                    builder: (BuildContext context) =>
                    new AlertesView(
                      path: null,
                      user: new Citoyen.fromJson(snapshot.data),
                    )
                  ));
              });
            } else {
              //Not Okay!!!
              Citoyen me = new Citoyen(
                email: user.email,
                nomComplet: user.displayName,
                etat: true,
                status: true,
                dateAdd: null,
                dateDel: null,
              );
              return new FutureBuilder(
                future: addCitoyen(me),
                builder: (BuildContext context, AsyncSnapshot snapshot1){
                  if(snapshot1.hasData){
                    if(snapshot1.data != null){
                      //Its Okay!!!
                      //print(snapshot.data);
                      SchedulerBinding.instance.addPostFrameCallback((_) {
                        Navigator.of(context)
                          ..pop()
                          ..pop()
                          ..push(new MaterialPageRoute(
                            builder: (BuildContext context) =>
                            new AlertesView(
                              path: null,
                              user: new Citoyen.fromJson(snapshot1.data),
                            )
                          ));
                      });
                    } else {
                      //Not Okay!!!
                      return new Container(
                        child: new Text('Erreur lors de l\'ajout, veuillez réessayer'),
                      );
                    }
                  } else if(snapshot1.hasError){
                    return new ListView(
                      children: <Widget>[
                        new Text("${snapshot1.error}"),
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
                                fontSize: 20.0,
                              )
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                }
              );
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
                        fontSize: 20.0,
                      )
                    ),
                  ),
                ],
              ),
            ),
          );
        }
      ),
    );
  }
}
