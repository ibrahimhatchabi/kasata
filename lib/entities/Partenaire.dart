class Partenaire{
  num id;
  String nomComplet;
  String login;
  String motDePasse;
  String email;
  String dateAdd;
  String dateDel;
  bool status;
  String nomEntreprise;
  String adresse;
  String telephone;
  bool etat;

  Partenaire({
    this.id,
    this.nomComplet,
    this.login,
    this.motDePasse,
    this.email,
    this.dateAdd,
    this.dateDel,
    this.status,
    this.nomEntreprise,
    this.adresse,
    this.telephone,
    this.etat
  });

  factory Partenaire.fromJson(Map<String, dynamic> json) {
    return new Partenaire(
      id: json['id'],
      nomComplet: json['nomComplet'],
      login: json['login'],
      motDePasse: json['motDePasse'],
      email: json['email'],
      dateAdd: json['dateAdd'],
      dateDel: json['dateDel'],
      status: json['status'],
      nomEntreprise: json['nomEntreprise'],
      adresse: json['adresse'],
      telephone: json['telephone'],
      etat: json['etat'],
    );
  }
  Partenaire.map(dynamic obj) {
    this.id = obj['id'];
    this.nomComplet = obj['nomComplet'];
    this.login = obj['login'];
    this.motDePasse = obj['motDePasse'];
    this.email = obj['email'];
    this.dateAdd = obj['dateAdd'];
    this.dateDel = obj['dateDel'];
    this.status = obj['status'] == 1;
    this.nomEntreprise = obj['nomEntreprise'];
    this.adresse = obj['adresse'];
    this.telephone = obj['telephone'];
    this.etat = obj['etat'];
  }
  Map<String, dynamic> toMap() {
    var map = new Map<String, dynamic>();

    map["id"] = id;
    map["nomComplet"] = nomComplet;
    map["login"] = login;
    map["motDePasse"] = motDePasse;
    map["email"] = email;
    map["dateAdd"] = dateAdd;
    map["dateDel"] = dateDel;
    map["status"] = status;
    map["etat"] = etat;
    map["telephone"] = telephone;
    map["adresse"] = adresse;
    map["nomEntreprise"] = nomEntreprise;

    return map;
  }

}