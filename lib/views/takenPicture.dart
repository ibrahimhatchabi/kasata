import 'dart:io';

import 'package:flutter/material.dart';
import 'package:kasata/entities/Citoyen.dart';
import 'package:kasata/views/alerteView.dart';

class TakenPictureScreen extends StatefulWidget {
  String path;
  Citoyen user;
  TakenPictureScreen(this.path,this.user);

  @override
  _TakenPictureScreenState createState() => new _TakenPictureScreenState();
}

class _TakenPictureScreenState extends State<TakenPictureScreen> {

  File myImage;

  @override
  Widget build(BuildContext context) {
    myImage = new File(widget.path);
    return new Scaffold(
      appBar: new AppBar(
        title: new Text(
          "Aperçu",
          style: new TextStyle(
            color: Colors.white,
            fontSize: 22.0,
            fontFamily: 'LiberationSerif'
          ),
        ),
        actions: <Widget>[
          new IconButton(
            icon: new Icon(Icons.refresh),
            onPressed: () {
              Navigator.of(context)
                ..pop();
            }
          ),
          new IconButton(
            icon: new Icon(Icons.send),
            onPressed: () {
              Navigator.of(context)
                ..pop()
                ..push(new MaterialPageRoute(
                  builder: (BuildContext context) => new AlertesView(path: widget.path,user: widget.user,),
                ));
            }
          ),

        ],
        automaticallyImplyLeading: false,
        elevation: 5.0,
        backgroundColor: const Color(0xFF19222b),
      ),
      body: new Center(child: Image.file(myImage)),
    );
  }
}
