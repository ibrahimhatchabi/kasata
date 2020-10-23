import 'dart:io';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'package:kasata/entities/Citoyen.dart';
import 'package:kasata/views/takenPicture.dart';

class CameraScreen extends StatefulWidget {

  List<CameraDescription> cameras;
  Citoyen user;
  CameraScreen(this.cameras, this.user);

  @override
  _CameraScreenState createState() => new _CameraScreenState();
}

class _CameraScreenState extends State<CameraScreen> {

  CameraController controller;
  String fileName;
  String path;

  @override
  void initState() {
    super.initState();
    fileName = "${Random().nextInt(10000)}";
    path = '/data/user/0/ne.kasata.kasata/$fileName';
    //print("£££££££££££££££££££££££££--------$fileName");
    controller = new CameraController(widget.cameras[0], ResolutionPreset.low);
    controller.initialize().then((_){
      if(!mounted){
        return;
      }
      setState(() {

      });
    });
  }



  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if(!controller.value.isInitialized){
      return new Container();
    }
    return new AspectRatio(
      aspectRatio: controller.value.aspectRatio,
      child: new Stack(children:<Widget>[
        new CameraPreview(controller),
        new Material(
          color: Colors.transparent,
          child: new Center(
            child: new Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                //new Image.file(myImage),
                new Container(
                  padding: new EdgeInsets.all(10.0),
                  child: new InkWell(
                    borderRadius: new BorderRadius.all(new Radius.circular(50.0)),
                    splashColor: Colors.transparent,
                    child: new Icon(
                      Icons.camera,
                      size: 70.0,
                      color: const Color(0xFF00a8f6)
                    ),
                    onTap: () async {
                      await controller.takePicture(path);
                      Navigator.of(context)
                        ..pop()
                        ..push(new MaterialPageRoute(
                          builder: (BuildContext context) => new TakenPictureScreen(path,widget.user),
                        ));
                    }
                  ),
                ),
              ]
            ),
          ),
        )
      ]),
    );
  }
}
