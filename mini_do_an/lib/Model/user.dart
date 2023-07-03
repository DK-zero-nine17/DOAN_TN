class User {
  int id;
  String mssvUser;
  String nameUser;
  String emailUser;
  String? lopUser;
  String? sdtUser;
  String? dateUser;
  String? diachiUser;
  String? avatarUser;
  String passwordUser;
  int? status = 1;
  int? rule = 3;

  User(
      {required this.id,
      required this.mssvUser,
      required this.nameUser,
      required this.emailUser,
      this.lopUser,
      this.sdtUser,
      this.dateUser,
      this.diachiUser,
      this.avatarUser,
      required this.passwordUser,
      this.status,
      this.rule});

  factory User.fromMap(Map<String, dynamic> json) => User(
      id: json["id"],
      mssvUser: json["mssvUser"],
      nameUser: json["nameUser"],
      emailUser: json["emailUser"],
      lopUser: json["lopUser"],
      sdtUser: json["sdtUser"],
      dateUser: json["dateUser"],
      diachiUser: json["diachiUser"],
      avatarUser: json["avatarUser"],
      passwordUser: json["passwordUser"],
      status: json["status"] ?? 1,
      rule: json["rule"] ?? 3);
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> json = {
      'id': id,
      'mssvUser': mssvUser,
      'nameUser': nameUser,
      'emailUser': emailUser,
      'passwordUser': passwordUser
    };

    if (lopUser != null) {
      json['lopUser'] = lopUser;
    }
    if (sdtUser != null) {
      json['sdtUser'] = sdtUser;
    }
    if (dateUser != null) {
      json['dateUser'] = dateUser;
    }
    if (diachiUser != null) {
      json['diachiUser'] = diachiUser;
    }
    if (avatarUser != null) {
      json['avatarUser'] = avatarUser;
    }
    if (status != null) {
      json['status'] = status;
    }
    if (status != null) {
      json['rule'] = rule;
    }
    return json;
  }
}
