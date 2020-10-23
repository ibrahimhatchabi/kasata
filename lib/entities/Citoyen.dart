class Citoyen{
  num id;
  String nomComplet;
  String login;
  String motDePasse;
  String email;
  String dateAdd;
  String dateDel;
  bool status;
  bool etat;

  Citoyen({
    this.id,
    this.nomComplet,
    this.login,
    this.motDePasse,
    this.email,
    this.dateAdd,
    this.dateDel,
    this.status,
    this.etat,
  });

  factory Citoyen.fromJson(Map<String, dynamic> json) {
    return new Citoyen(
      id: json['id'],
      nomComplet: json['nomComplet'],
      login: json['login'],
      motDePasse: json['motDePasse'],
      email: json['email'],
      dateAdd: json['dateAdd'],
      dateDel: json['dateDel'],
      status: json['status'],
      etat: json['etat'],
    );
  }
  Citoyen.map(dynamic obj) {
    this.id = obj['id'];
    this.nomComplet = obj['nomComplet'];
    this.login = obj['login'];
    this.motDePasse = obj['motDePasse'];
    this.email = obj['email'];
    this.dateAdd = obj['dateAdd'];
    this.dateDel = obj['dateDel'];
    this.status = obj['status'] == 1;
    this.etat = obj['etat'];
  }


  String toJson() {
    var map = new Map<String, String>();

    map['"id"'] = '"$id"';
    map['"nomComplet"'] = '"$nomComplet"';
    map['"login"'] = '"$login"';
    map['"motDePasse"'] = '"$motDePasse"';
    map['"email"'] = '"$email"';
    map['"dateAdd"'] = dateAdd != null ? '"$dateAdd"' : null;
    map['"dateDel"'] = dateDel != null ? '"$dateDel"' : null;
    map['"status"'] = '$status';
    map['"etat"'] = '$etat';

    return map.toString();
  }

}