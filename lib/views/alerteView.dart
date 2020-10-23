import 'dart:io';

import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'package:kasata/entities/Citoyen.dart';
import 'package:kasata/views/CameraScreen.dart';
import 'package:kasata/views/addAlerteProcess.dart';


List<CameraDescription> cameras;

class AlertesView extends StatefulWidget {

  String path;
  Citoyen user;

  AlertesView({
    this.path,
    this.user,
  });

  @override
  _AlerteState createState() => new _AlerteState();
}

TextStyle _myHintTextStyle = new TextStyle(
  fontFamily: 'LiberationSerif',
  fontSize: 20.0,
  color: Colors.black,
);

class _AlerteState extends State<AlertesView> {

  String _defaultType = null;
  List<String> listeType = ['Agression','Abus de confiance','Détérioration','Malfonctionnement','Négligence','Sécurité','Autre'];

  final _description = new TextEditingController();

  void _setType(String value){
    setState((){
      _defaultType = value;
    });
  }

  @override
  Widget build(BuildContext context) {

    List<CameraDescription> cameras;

    return new Scaffold(
      appBar: new AppBar(
        automaticallyImplyLeading: false,
        title: new Center(
          child: new Text(
            'Nouvelle Alerte',
            style: new TextStyle(
                color: Colors.white,
                fontSize: 22.0,
                fontFamily: 'LiberationSerif'
            ),
          ),
        ),
        elevation: 5.0,
        backgroundColor: const Color(0xFF19222b),
      ),
      body: new Container(
        child: new ListView(
          shrinkWrap: false,
          children: <Widget>[
            new Container(
              child: new Column(
                children: <Widget>[
                  new Padding(
                    padding: new EdgeInsets.all(5.0),
                    child: new Image.asset(
                      'images/alerteAsset.png',
                      /*width: 200.0,
                          height: 200.0*/
                    ),
                  ),
                  new Container(
                    decoration: widget.path != null
                        ?
                    new BoxDecoration(
                      boxShadow:
                      [
                        BoxShadow(
                          blurRadius: 3.0,
                        )
                      ]
                    )
                        : null,
                    child: widget.path != null
                        ? new Image.file(
                      new File(widget.path),
                      width: 200.0,
                      height: 200.0,
                    )
                        : new Center(
                      child: new IconButton(
                        icon: new Icon(
                          Icons.photo_camera,
                        ),
                        iconSize: 150.0,
                        color: const Color(0xFF00a8f6),
                        onPressed: () async {

                          cameras = await availableCameras();

                          Navigator.of(context)
                            ..pop()
                            ..push(new MaterialPageRoute(
                              builder: (BuildContext context) => new CameraScreen(cameras, widget.user ),
                            ));
                        }
                      ),
                    )
                  ),
                  new Container(
                    //height: 20.0,
                  ),
                  new Container(
                    padding: new EdgeInsets.only(top:10.0),
                    child: new Center(
                      child: new DropdownButton<String>(
                        hint: new Text(
                          'Type d\'alerte',
                          //style: _myInputTextStyle,
                        ),
                        value: _defaultType,
                        items: listeType.map((value) {
                          return new DropdownMenuItem(
                            value: value,
                            child: new Row(
                              children: <Widget>[
                                new Text(
                                  "$value",
                                  //style: _myInputTextStyle,
                                )
                              ],
                            )
                          );
                        }).toList(),
                        onChanged: (String value){_setType(value);},
                      ),
                    )
                  ),
                  new Container(
                    padding: new EdgeInsets.all(10.0),
                    child: new Center(
                      child: new Padding(
                        padding: const EdgeInsets.only(left: 25.0,right: 25.0),
                        child: new TextFormField(
                          /*validator: (value){
                            if(value.isEmpty){
                              return globals.descriptionVide;
                            }
                          },*/
                          controller: _description,
                          style: _myHintTextStyle,
                          decoration: new InputDecoration(
                            hintText: 'Description',
                            hintStyle: _myHintTextStyle,
                            //helperText: _helperText,
                          ),
                        ),
                      ),
                    ),
                  ),
                  new Container(
                    height: 20.0,
                  ),

                  new Material(
                    color: Colors.transparent,
                    child: new Padding(
                      padding: new EdgeInsets.only(left: 40.0, right: 40.0, top: 20.0),
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
                            Navigator.of(context)
                              ..pop()
                              ..push(new MaterialPageRoute(
                                builder: (BuildContext context) => new AddAlerteProcess(
                                  type: _defaultType,
                                  description: _description.text,
                                  path: widget.path,
                                  user: widget.user,
                                ),
                              ));
                          },
                          child: new Center(
                            child: new Text(
                              'Enregistrer',
                              style: new TextStyle(
                                color: const Color(0xFF00a8f6),
                                fontSize: 20.0,
                                fontFamily: 'LiberationSerif',
                                fontWeight: FontWeight.bold,
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
    );
  }
}
