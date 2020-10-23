import 'package:flutter/material.dart';
import 'package:kasata/entities/Citoyen.dart';
import 'package:kasata/views/login.dart';
import 'package:kasata/views/signUpProcess.dart';

class SignUp extends StatefulWidget {

  @override
  _SignUpState createState() => new _SignUpState();
}
TextStyle _myHintTextStyle = new TextStyle(
  fontFamily: 'bebas',
  fontSize: 18.0,
  color: Colors.black,
);

TextEditingController _nomComplet = new TextEditingController();
TextEditingController _email = new TextEditingController();
TextEditingController _password = new TextEditingController();
TextEditingController _repeatPassword = new TextEditingController();

final GlobalKey<FormState> _formKey = new GlobalKey<FormState>();


class _SignUpState extends State<SignUp> {

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
                  'Créez votre compte',
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
                      padding: new EdgeInsets.all(5.0),
                      child: new Image.asset(
                        'images/account.png',
                        color: const Color(0xFF00a8f6),
                        width: 100.0,
                        height: 100.0
                      ),
                    ),
                    new Container(
                      padding: new EdgeInsets.only(top: 10.0, bottom: 10.0, right: 70.0, left: 70.0),
                      child: new TextFormField(
                        controller: _nomComplet,
                        style: _myHintTextStyle,
                        decoration: new InputDecoration(
                          hintText: 'Nom Complet',
                          hintStyle: _myHintTextStyle,
                          //helperText: _helperText,
                        ),
                      ),
                    ),
                    new Container(
                      padding: new EdgeInsets.only(top: 10.0, bottom: 10.0, right: 70.0, left: 70.0),
                      child: new TextFormField(
                        validator: (value){
                          if(!value.contains('@') || !value.contains('.')){
                            return 'email invalide';
                          }
                        },
                        controller: _email,
                        style: _myHintTextStyle,
                        decoration: new InputDecoration(
                          hintText: 'Email',
                          hintStyle: _myHintTextStyle,
                          //helperText: _helperText,
                        ),
                      ),
                    ),
                    new Container(
                      padding: new EdgeInsets.only(top: 10.0, bottom: 10.0, right: 70.0, left: 70.0),
                      child: new TextFormField(
                        obscureText: true,
                        style: _myHintTextStyle,
                        validator: (value){
                          if(value.length < 6){
                            return 'trop court, 6 caractères minimum';
                          }
                        },
                        controller: _password,
                        decoration: new InputDecoration(
                          hintText: 'Mot de passe',
                          hintStyle: _myHintTextStyle,
                          //helperText: _helperText,
                        ),
                      ),
                    ),
                    new Container(
                      padding: new EdgeInsets.only(top: 10.0, bottom: 10.0, right: 70.0, left: 70.0),
                      child: new TextFormField(
                        obscureText: true,
                        style: _myHintTextStyle,
                        controller: _repeatPassword,
                        validator: (value){
                          if(value != _password.text){
                            return 'mots de passe différents';
                          }
                        },
                        decoration: new InputDecoration(
                          hintText: 'Confirmer mot de passe',
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
                        padding: new EdgeInsets.only(left: 50.0, right: 50.0, top: 20.0),
                        child: new Container(
                          decoration: new BoxDecoration(
                            borderRadius: new BorderRadius.circular(4.0),
                            border: new Border.all(
                              color: const Color(0xFF00a8f6),
                              width: 4.0,
                            )
                          ),
                          width: double.infinity,
                          height: 60.0,
                          child: new InkWell(
                            splashColor: const Color(0xFF00a8f6).withOpacity(0.3),
                            onTap: (){
                              if (_formKey.currentState.validate()) {

                                Citoyen alpha = new Citoyen(
                                  nomComplet: _nomComplet.text,
                                  motDePasse: _password.text,
                                  email: _email.text,
                                  status: true,
                                );

                                Navigator.of(context)
                                  ..pop()
                                  ..push(new MaterialPageRoute(
                                      builder: (BuildContext context) => new SignUpProcess(citoyen: alpha,)
                                ));
                              }
                            },
                            child: new Center(
                              child: new Text(
                                'Enregistrer',
                                style: new TextStyle(
                                  color: const Color(0xFF00a8f6),
                                  fontSize: 20.0,
                                  fontFamily: 'bebas',
                                ),
                              ),
                            ),
                          ),
                        )
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
