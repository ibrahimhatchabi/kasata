import 'dart:async';

import 'package:flutter/material.dart';

class Info extends StatelessWidget {

  num id;
  String image;
  String title;
  String content;
  String dateAdd;
  String dateDel;
  bool status;

  Info({
    this.id,
    this.image,
    this.title,
    this.content,
    this.dateAdd,
    this.dateDel,
    this.status,
  });

  factory Info.fromJson(Map<String, dynamic> json) {
    return new Info(
      id: json['id'],
      image: json['image'],
      title: json['title'],
      content: json['content'],
      dateAdd: json['dateAdd'],
      dateDel: json['dateDel'],
      status: json['status'],
    );
  }
  Info.map(dynamic obj) {
    this.id = obj['id'];
    this.title = obj['title'];
    this.content = obj['content'];
    this.image = obj['image'];
    this.dateAdd = obj['dateAdd'];
    this.dateDel = obj['dateDel'];
    this.status = obj['status'];
  }
  Map<String, dynamic> toMap() {
    var map = new Map<String, dynamic>();

    map["id"] = id;
    map["title"] = title;
    map["image"] = image;
    map["content"] = content;
    map["dateAdd"] = dateAdd;
    map["dateDel"] = dateDel;
    map["status"] = status;

    return map;
  }

  Future<Image> _loadImage(String imageLocation) async{
    return Image.network(imageLocation);
  }
  @override
  Widget build(BuildContext context) {
    return new Container(
      margin: new EdgeInsets.all(20.0),
      decoration: new BoxDecoration(
          color: Colors.white,
          boxShadow:
          [
            BoxShadow(
              blurRadius: 5.0,
            )
          ]
      ),
      child: new Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          //new Image.asset(image),
          new FutureBuilder(
            future: _loadImage(image),
            builder: (BuildContext context, AsyncSnapshot<Image> image) {
              if (image.hasData) {
                return image.data;  // image is ready
              } else {
                return new Image.asset(
                  'images/emptyAsset.png',
                  color: const Color(0xFF00a8f6),
                );  // placeholder
              }
            }
          ),
          new Padding(
            padding: const EdgeInsets.all(8.0),
            child: new Text(
              title,
              style: new TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
                fontFamily: 'LiberationSerif',
              ),
            ),
          ),
          new Row(
            children: <Widget>[
              new Icon(
                Icons.alarm,
                color: Colors.black,
              ),
              new Padding(
                padding: const EdgeInsets.all(8.0),
                child: new Text(
                  dateAdd,
                  style: new TextStyle(
                    fontSize: 15.0,
                    fontFamily: 'bebas',
                  ),
                ),
              ),
            ]
          )
        ],
      ),
    );
  }
}
