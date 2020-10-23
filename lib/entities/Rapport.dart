class Rapport{
  num id;
  String emplacement;
  String alerteConcernee;
  String dateAdd;
  String dateDel;
  bool status;

  Rapport({
    this.id,
    this.emplacement,
    this.alerteConcernee,
    this.dateAdd,
    this.dateDel,
    this.status,
  });

  factory Rapport.fromJson(Map<String, dynamic> json) {
    return new Rapport(
        id: json['id'],
        emplacement: json['emplacement'],
        alerteConcernee: json['alerteConcernee'],
        dateAdd: json['dateAdd'],
        dateDel: json['dateDel'],
        status: json['status']
    );
  }
  Rapport.map(dynamic obj) {
    this.id = obj['id'];
    this.emplacement = obj['emplacement'];
    this.alerteConcernee = obj['alerteConcernee'];
    this.dateAdd = obj['dateAdd'];
    this.dateDel = obj['dateDel'];
    this.status = obj['status'] == 1;
  }
  Map<String, dynamic> toMap() {
    var map = new Map<String, dynamic>();

    map["id"] = id;
    map["emplacement"] = emplacement;
    map["alerteConcernee"] = alerteConcernee;
    map["dateAdd"] = dateAdd;
    map["dateDel"] = dateDel;
    map["status"] = status;

    return map;
  }

}