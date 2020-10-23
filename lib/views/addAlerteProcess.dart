import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:kasata/entities/Alerte.dart';
import 'package:kasata/entities/Citoyen.dart';
import 'package:kasata/views/home.dart';
import 'dart:math';
import 'dart:typed_data';
import 'dart:async';
import 'package:location/location.dart';
import 'package:http/http.dart' as http;
import 'package:kasata/globals/globals.dart' as globals;
import 'package:flutter_native_image/flutter_native_image.dart';

class AddAlerteProcess extends StatefulWidget {

  final String type;
  final String description;
  final String path;
  final Citoyen user;

  AddAlerteProcess({
    this.type,
    this.description,
    this.path,
    this.user,
  });

  @override
  _AddAlerteProcessState createState() => new _AddAlerteProcessState();
}

Map<String,String> headers = {"content-type":"application/json","accept":"application/json"};

Future<String> addAlerte(Alerte alerte) async {
  final response = await http.post('${globals.host}/addAlerte',headers: headers,body: alerte.toJson());
  //print("************ ${alerte.toJson()} ***********");
  return response.body;
}

Future<String> uploadFile(String filepath) async {
  // Compression de l'image
  File compressedFile = await FlutterNativeImage.compressImage(filepath,
      quality: 50, percentage: 50);
  // Récupération de l'image compressée
  final ByteData bytes = await rootBundle.load(compressedFile.path);
  final Directory tempDir = Directory.systemTemp;
  final String filename = "${Random().nextInt(10000)}.jpg";
  final File file = File('${tempDir.path}/$filename');

  file.writeAsBytes(bytes.buffer.asInt8List(), mode: FileMode.write);

  // Instanciation de firestorage et upload de l'image
  final StorageReference ref = FirebaseStorage.instance.ref().child(filename);
  final StorageUploadTask task = ref.putFile(file);

  // Récupération de l'url de l'image sur firestorage
  final Uri downloadUrl = (await task.future).downloadUrl;

  return downloadUrl.toString();
}



class _AddAlerteProcessState extends State<AddAlerteProcess> {

  Location _location = new Location();
  double latitude;
  double longitude;

  getLocation() async {
     return await _location.getLocation();
  }


  @override
  void initState() {
    super.initState();
    getLocation().then((value){
      latitude = value["latitude"];
      longitude = value["longitude"];
      //print("************** Latitude: ${value["latitude"]}, Longitude: ${value["longitude"]} **************");
    });
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
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
      ),
      body: Center(
        child: new Container(
          child: new FutureBuilder<String>(
            future: uploadFile(widget.path),
            builder: (BuildContext context, AsyncSnapshot snapshot){
              if(snapshot.hasData){
                return new FutureBuilder<String>(
                  future: addAlerte(new Alerte(
                    description: widget.description,
                    type: widget.type,
                    libelle: widget.type,
                    photo: snapshot.data,
                    latitude: latitude.toString(),
                    longitude: longitude.toString(),
                    status: true,
                    signaleePar: widget.user,
                    partenaireConcerne: null,
                    etat: null,
                    dateAdd: null,
                    dateDel: null,
                  )),
                  builder: (BuildContext context, AsyncSnapshot snapshot1){
                    if(snapshot1.hasData){
                      print("********** HEre 0 ");
                      //Afficher Message succès
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
                                    "Alerte envoyée!",
                                    //style: _myAlertDialogTextStyle,
                                  )
                                ],
                              ),
                            ),
                            actions: <Widget>[
                              new FlatButton(
                                child: new Text(
                                  "Okay",
                                  //style: _myAlertDialogTextStyle,
                                ),
                                onPressed: () {
                                  Navigator.of(context)
                                    ..pop()
                                    ..pop()
                                    ..push(new MaterialPageRoute(
                                      builder: (BuildContext context) => new Home(),
                                    ));
                                },
                              ),
                            ],
                          )
                        );
                      });
                    }
                    else if(snapshot1.hasError){
                      return new ListView(
                          children: <Widget>[
                            new Text("${snapshot1.error}"),
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
                );
              } else if(snapshot.hasError){

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
                        "Chargement ...",
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
      ),
    );
  }
}
