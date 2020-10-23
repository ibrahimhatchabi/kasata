import 'dart:async';

import 'package:flutter/material.dart';
import 'package:kasata/entities/Citoyen.dart';
import 'package:kasata/views/alerteView.dart';
import 'package:kasata/views/loginProcess.dart';
import 'package:kasata/views/loginProcessGoogle.dart';
import 'package:kasata/views/signUp.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => new _LoginState();
}
TextStyle _myInputTextStyle = new TextStyle(
  fontFamily: 'LiberationSerif',
  fontSize: 16.0,
  color: Colors.black,
);
TextStyle _myHintTextStyle = new TextStyle(
  fontFamily: 'bebas',
  fontSize: 16.0,
  color: Colors.black,
);
TextEditingController _email = new TextEditingController();
TextEditingController _password = new TextEditingController();

final GlobalKey<FormState> _formKey = new GlobalKey<FormState>();

class _LoginState extends State<Login> {

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
      body: Form(
        key: _formKey,
        child: new Container(
          decoration: new BoxDecoration(
            gradient: new LinearGradient(
              colors: [
                Colors.white,
                Colors.white,
                Colors.white,
                Colors.grey,
              ],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            )
          ),
          child: new ListView(
            shrinkWrap: false,
            children: <Widget>[
              SizedBox(
                height: 10.0,
              ),
              Center(
                child: new Text(
                'Connectez-vous',
                  style: new TextStyle(
                    color: const Color(0xFF00a8f6),
                    fontSize: 22.0,
                    fontFamily: 'bebas',
                  )
                ),
              ),
              new Container(
                child: new Column(
                  children: <Widget>[
                    new Padding(
                      padding: new EdgeInsets.only(top: 10.0),
                      child: new Image.asset(
                        'images/loginAsset.png',
                        width: 100.0,
                        height: 100.0
                      ),
                    ),
                    new Container(
                      padding: new EdgeInsets.only(top: 5.0, bottom: 5.0, right: 40.0, left: 40.0),
                      child: new TextFormField(
                        controller: _email,
                        validator: (value){
                          if(value.length == 0){
                            return 'veuillez saisir votre email';
                          }
                        },
                        style: _myHintTextStyle,
                        decoration: new InputDecoration(
                          hintText: 'Email',
                          hintStyle: _myHintTextStyle,
                          //helperText: _helperText,
                        ),
                      ),
                    ),
                    new Container(
                      height: 10.0,
                    ),
                    new Container(
                      padding: new EdgeInsets.only(top: 5.0, bottom: 5.0, right: 40.0, left: 40.0),
                      child: new TextFormField(
                        obscureText: true,
                        controller: _password,
                        style: _myHintTextStyle,
                        validator: (value){
                          if(value.length == 0){
                            return 'veuillez saisir votre mot de passe';
                          }
                        },
                        decoration: new InputDecoration(
                          hintText: 'Mot de passe',
                          hintStyle: _myHintTextStyle,
                          //helperText: _helperText,
                        ),
                      ),
                    ),
                    new Container(
                      height: 20.0,
                    ),
                    new Material(
                      color: Colors.transparent,
                      child: new Padding(
                        padding: new EdgeInsets.only(left: 70.0, right: 70.0, top: 10.0),
                        child: new Container(
                          decoration: new BoxDecoration(
                              borderRadius: new BorderRadius.circular(4.0),
                              border: new Border.all(
                                color: const Color(0xFF00a8f6),
                                width: 4.0,
                              )
                          ),
                          width: double.infinity,
                          height: 50.0,
                          child: new InkWell(
                            splashColor: const Color(0xFF00a8f6).withOpacity(0.3),
                            onTap: (){
                              if(_formKey.currentState.validate()){
                                Navigator.of(context)
                                  ..pop()
                                  ..push(new MaterialPageRoute(
                                    builder: (BuildContext context) => new LoginProcess(
                                      email: _email.text,
                                      password: _password.text,
                                    ),
                                  ));
                              }
                            },
                            child: new Center(
                              child: new Text(
                                'Se connecter',
                                style: new TextStyle(
                                  color: const Color(0xFF00a8f6),
                                  fontSize: 20.0,
                                  fontFamily: 'bebas',
                                  //fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                        )
                      ),
                    ),new Container(
                      height: 20.0,
                    ),
                    new Center(
                      child: new Text(
                        'Vous n\'avez pas de compte?',
                        style: new TextStyle(
                            fontFamily: 'LiberationSerif',
                            fontStyle: FontStyle.italic,
                            fontSize: 14.0,
                            color: Colors.black,//const Color(0xFF00a8f6)
                        ),
                      ),
                    ),
                    new Container(
                      margin: new EdgeInsets.only(top: 10.0,bottom: 10.0, right: 50.0, left: 50.0),
                      child: new Row(
                        children: <Widget>[
                          Container(
                            padding: new EdgeInsets.only(right: 5.0),
                            child: new Image.asset(
                              "images/account.png",
                              color: Colors.teal,//const Color(0xFF00a8f6),
                              height: 50.0,
                            ),
                          ),
                          new Container(
                            height: 50.0,
                            width: 200.0,
                            decoration: new BoxDecoration(
                              //color: Theme.of(context).cardColor,
                                color: Colors.teal,
                                borderRadius: new BorderRadius.all(new Radius.circular(4.0))
                            ),
                            child: new Material(
                              color: Colors.transparent,
                              child: new InkWell(
                                splashColor: Colors.white10,
                                child: new Center(
                                  child: new Text(
                                    "Créer un compte",
                                    style: new TextStyle(
                                        fontFamily: "bebas",
                                        letterSpacing: 1.0,
                                        color: Colors.white,
                                        fontSize: 16.0
                                    ),
                                  ),
                                ),
                                onTap: (){
                                  //print("!!!!!!!!!!!!!!!!!!!! Im tapped !!!!!!!!!!!!!!!!!!");
                                  Navigator.of(context)
                                    ..pop()
                                    ..push(new MaterialPageRoute(
                                      builder: (BuildContext context) => new SignUp()
                                  ));
                                },
                              ),
                            ),
                          ),
                        ]
                      ),
                    ),
                    new Center(
                      child: new Text(
                        'ou encore',
                        style: new TextStyle(
                            fontFamily: 'LiberationSerif',
                            fontStyle: FontStyle.italic,
                            fontSize: 14.0,
                            color: Colors.black,//const Color(0xFF00a8f6)
                        ),
                      ),
                    ),
                    new Container(
                      margin: new EdgeInsets.only(top: 10.0,bottom: 10.0, right: 50.0, left: 50.0),
                      child: new Row(
                        children: <Widget>[
                          Container(
                            padding: new EdgeInsets.only(right: 5.0),
                            child: new Image.asset(
                              "images/google.png",
                              height: 50.0,
                            ),
                          ),
                          new Container(
                            height: 50.0,
                            width: 200.0,
                            decoration: new BoxDecoration(
                              //color: Theme.of(context).cardColor,
                                color: Colors.blue,
                                borderRadius: new BorderRadius.all(new Radius.circular(4.0))
                            ),
                            child: new Material(
                              color: Colors.transparent,
                              child: new InkWell(
                                splashColor: Colors.white10,
                                child: new Center(
                                  child: new Text(
                                    "Se connecter avec Google",
                                    style: new TextStyle(
                                      fontFamily: "bebas",
                                      letterSpacing: 1.0,
                                      color: Colors.white,
                                      fontSize: 16.0
                                    ),
                                  ),
                                ),
                                onTap: () => Navigator.of(context)
                                  ..push(new MaterialPageRoute(
                                    builder: (BuildContext context) => new LoginProcessGoogle(),
                                  )),
                              ),
                            ),
                          ),
                        ]
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
