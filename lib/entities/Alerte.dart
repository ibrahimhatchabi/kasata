import 'package:flutter/material.dart';
import 'package:kasata/entities/Citoyen.dart';
import 'package:kasata/entities/Partenaire.dart';
import 'package:kasata/views/alerteDetailsView.dart';

class Alerte extends StatelessWidget{
  num id;
  String libelle;
  String description;
  String photo;
  String latitude;
  String longitude;
  String type;
  bool etat;
  Partenaire partenaireConcerne;
  Citoyen signaleePar;
  String dateAdd;
  String dateDel;
  bool status;

  Alerte({
    this.id,
    this.libelle,
    this.description,
    this.photo,
    this.latitude,
    this.longitude,
    this.type,
    this.etat,
    this.partenaireConcerne,
    this.signaleePar,
    this.dateAdd,
    this.dateDel,
    this.status,
  });

  factory Alerte.fromJson(Map<String, dynamic> json) {
    return new Alerte(
      id: json['id'],
      libelle: json['libelle'],
      description: json['description'],
      photo: json['photo'],
      latitude: json['latitude'],
      longitude: json['longitude'],
      type: json['type'],
      etat: json['etat'] == 1,
      partenaireConcerne: json['partenaireConcerne'] == null ? null : Partenaire.fromJson(json['partenaireConcerne']),
      signaleePar: json['signaleePar'] == null ? null : Citoyen.fromJson(json['signaleePar']),
      dateAdd: json['dateAdd'],
      dateDel: json['dateDel'],
      status: json['status'] == 1,
    );
  }
  Alerte.map(dynamic obj) {
    this.id = obj['id'];
    this.libelle = obj['libelle'];
    this.description = obj['description'];
    this.photo = obj['photo'];
    this.latitude = obj['latitude'];
    this.longitude = obj['longitude'];
    this.type = obj['type'];
    this.etat = obj['etat'] == 1;
    this.partenaireConcerne = obj['partenaireConcerne'];
    this.signaleePar = obj['signaleePar'];
    this.dateAdd = obj['dateAdd'];
    this.dateDel = obj['dateDel'];
    this.status = obj['status'] == 1;
  }
  Map<String, dynamic> toMap() {
    var map = new Map<String, dynamic>();

    map["id"] = id;
    map["libelle"] = libelle;
    map["description"] = description;
    map["photo"] = photo;
    map["latitude"] = latitude;
    map["longitude"] = longitude;
    map["type"] = type;
    map["etat"] = etat;
    map["partenaireConcerne"] = partenaireConcerne;
    map["signaleePar"] = signaleePar;
    map["dateAdd"] = dateAdd;
    map["dateDel"] = dateDel;
    map["status"] = status;

    return map;
  }

  String toJson() {
    var map = new Map<String, String>();

    map['"id"'] = '"$id"';
    map['"libelle"'] = '"$libelle"';
    map['"description"'] = '"$description"';
    map['"photo"'] = '"$photo"';
    map['"latitude"'] = '"$latitude"';
    map['"longitude"'] = '"$longitude"';
    map['"type"'] = '"$type"';
    map['"partenaireConcerne"'] = partenaireConcerne == null ? null : '"$partenaireConcerne"';
    map['"signaleePar"'] = signaleePar == null ? null : '${signaleePar.toJson()}';
    map['"dateAdd"'] = dateAdd != null ? '"$dateAdd"' : null;
    map['"dateDel"'] = dateDel != null ? '"$dateDel"' : null;
    map['"status"'] = '$status';
    map['"etat"'] = '$etat';

    return map.toString();
  }

  String _iconOf(String type){
    switch (type) {
      case "Securite":
        return 'images/securiteAsset.png';
        break;
      case "Deterioration":
        return 'images/deteriorationAsset.png';
        break;
      case "Sécurite":
        return 'images/securiteAsset.png';
        break;
      case "Détérioration":
        return 'images/deteriorationAsset.png';
        break;
      case "Malfonctionnement":
        return 'images/deteriorationAsset.png';
        break;
      case "Négligence":
        return 'images/securiteAsset.png';
        break;
      default:
        return 'images/alerteAsset.png';
        break;
    }
  }

  Color _colorOf(String type){
    switch (type) {
      case "Securite":
        return Colors.deepOrangeAccent.withOpacity(0.7);
        break;
      case "Deterioration":
        return Colors.lime.withOpacity(0.7);
        break;
      case "Sécurite":
        return Colors.deepOrangeAccent.withOpacity(0.7);
        break;
      case "Détérioration":
        return Colors.lime.withOpacity(0.7);
        break;
      case "Malfonctionnement":
        return Colors.lightBlueAccent.withOpacity(0.7);
        break;
      case "Négligence":
        return Colors.indigoAccent.withOpacity(0.7);
        break;
      default:
        return Colors.redAccent.withOpacity(0.7);
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    List<String> newDescription = description.split(" ");
    String minDescription;
    if(newDescription.length > 3)
      minDescription = "${newDescription[0]} ${newDescription[1]} ${newDescription[2]} ..." ;
    else
      minDescription = "${newDescription[0]} ...";
    return new InkWell(
      onTap: (){
        Navigator.of(context)
          ..push(new MaterialPageRoute(
            builder: (BuildContext context) => new AlerteDetails(
              content: new Container(
                color: Colors.white,
                child: new ListView(
                  children: <Widget>[
                    new Image.network(photo),
                    new SizedBox(height: 10.0),
                    new Text(
                      libelle.toUpperCase(),
                      style: new TextStyle(
                        color: Colors.black,
                        fontSize: 14.0,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 1.0,
                        height: 1.5,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    new SizedBox(height: 10.0),
                    new Container(
                      child: new Text(description),
                      padding: new EdgeInsets.all(12.0),
                    ),
                    new SizedBox(height: 50.0),
                    new Container(
                      padding: new EdgeInsets.all(12.0),
                      child: new RichText(
                        text: new TextSpan(
                          text: '',
                          children: [
                            new TextSpan(
                              text: 'Signalée par: ',
                              style: new TextStyle(
                                color: Colors.black,
                                fontSize: 14.0,
                                fontWeight: FontWeight.bold,
                                letterSpacing: 1.0,
                                height: 1.5,
                              )
                            ),
                            new TextSpan(
                              text: '${signaleePar.nomComplet}\n',
                              style: new TextStyle(
                                color: Colors.black,
                                fontSize: 14.0,
                                letterSpacing: 2.0,
                                height: 1.5,
                              )
                            ),
                            new TextSpan(
                              text: 'Partenaire Concerné: ',
                              style: new TextStyle(
                                color: Colors.black,
                                fontSize: 14.0,
                                letterSpacing: 1.0,
                                fontWeight: FontWeight.bold,
                                height: 1.5,
                              )
                            ),
                            new TextSpan(
                              text: '${partenaireConcerne.nomEntreprise}',
                              style: new TextStyle(
                                color: Colors.black,
                                fontSize: 14.0,
                                letterSpacing: 2.0,
                                height: 1.5,
                              )
                            )
                          ]
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          )
        );
      },
      child: new Container(
        margin: new EdgeInsets.only(left: 20.0, right: 20.0, top: 10.0, bottom: 10.0),
        decoration: new BoxDecoration(
          color: _colorOf(type),
          boxShadow:
          [
            BoxShadow(
              blurRadius: 3.0,
            )
          ]
        ),
        height: 80.0,
        width: double.infinity,
        child: new Row(
          children: <Widget>[
            //new Image.network(photo),
            new Container(
              margin: EdgeInsets.only(left: 10.0,right: 8.0),
              color: Colors.grey.withOpacity(0.6),
              child: Image.asset(
                _iconOf(type),
                width: 80.0,
                height: 80.0,
                color: const Color(0xFF00a8f6).withOpacity(0.7),
              ),
            ),
            new Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                new Container(
                  width: 160.0,
                  //margin: EdgeInsets.only(left:4.0),
                  child: new Text(
                    type.trim(),
                    style: TextStyle(
                      fontFamily: "LiberationSerif",
                      fontSize: 22.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                new Container(
                  width: 160.0,
                  //margin: EdgeInsets.only(top: 10.0, left: 4.0, right: 4.0),
                  child: Text(
                    minDescription,
                    style: TextStyle(
                      fontFamily: "LiberationSerif",
                      fontSize: 16.0,
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                )
              ],
            ),
            new Expanded(child: Container()),
            new Container(
              margin: EdgeInsets.only(right: 10.0),
              color: Colors.grey.withOpacity(0.6),
              width: 10.0,
              height: 80.0,
              child: new Center(
                child: new Container(
                  color: const Color(0xFF00a8f6).withOpacity(0.4),
                  width: 2.0,
                  height: 80.0,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

}