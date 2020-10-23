import 'package:flutter/material.dart';
import 'package:kasata/views/alerteView.dart';
import 'package:kasata/views/teaser.dart';
//import 'package:camera/camera.dart';

//List<CameraDescription> cameras;

void main() async {
  //cameras = await availableCameras();
  runApp(new MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Kassata',
      home: new TeaserPage(),
      //home: new Alerte(cameras),
    );
  }
}
