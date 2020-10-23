import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:kasata/views/login.dart';

class AlerteDetails extends StatefulWidget {

  final Widget content;

  AlerteDetails({
    this.content,
  });

  @override
  _AlerteDetailsState createState() => new _AlerteDetailsState();
}

class _AlerteDetailsState extends State<AlerteDetails> {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      floatingActionButton: new FloatingActionButton(
        child: new Icon(Icons.add_alert),
        onPressed: (){
          Navigator.of(context)
            ..push(new MaterialPageRoute(
              builder: (BuildContext context) => new Login(),
            ));
        },
      ),
      //backgroundColor: Colors.white,
      appBar: new AppBar(
        title: new Center(
          child: new Image.asset(
            "images/logo_kassata1.png",
            //color: const Color(0xFF00a8f6),
          ),
        ),
        backgroundColor: const Color(0xFF19222b),
        automaticallyImplyLeading: true,
        actions: <Widget>[
          new Icon(
            Icons.more_vert,
            color: Colors.transparent,
          ),
          new Icon(
            Icons.more_vert,
            color: Colors.transparent,
          )
        ],
      ),
      body: widget.content,
    );
  }
}
