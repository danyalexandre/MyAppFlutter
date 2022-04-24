class User {
  final String uid;
  final String prenom;
  final String nom;
  final String email;

  User(this.uid, this.prenom, this.nom, this.email);

  /*User.fromJson(Map<String, dynamic> json) {
    uid = json['uid'];
    prenom = json['name'];
    nom = json['presence'];
    email = json['last_seen'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();

    data['uid'] = this.uid;
    data['name'] = this.name;
    data['presence'] = this.presence;
    data['last_seen'] = this.lastSeenInEpoch;

    return data;
  }*/
}
