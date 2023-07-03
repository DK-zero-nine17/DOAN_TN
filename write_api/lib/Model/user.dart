import 'dart:convert';

import 'package:mysql1/mysql1.dart';

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
  int status = 1;
  int rule = 3;

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
      required this.status,
      required this.rule});

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
      status: json["status"],
      rule: json["rule"]);

  Map<String, dynamic> toMap() => {
        "id": id,
        "mssvUser": mssvUser,
        "nameUser": nameUser,
        "emailUser": emailUser,
        "lopUser": lopUser,
        "sdtUser": sdtUser,
        "dateUser": dateUser,
        "diachiUser": diachiUser,
        "avatarUser": avatarUser,
        "passwordUser": passwordUser,
        'status': status,
        'rule': rule
      };

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> json = {
      'id': id,
      'mssvUser': mssvUser,
      'nameUser': nameUser,
      'emailUser': emailUser,
      'passwordUser': passwordUser,
      'status': status,
      'rule': rule
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
    return json;
  }
}

List<Map<String, dynamic>> toListJsonUser(List<User> lstUser) {
  return lstUser.map((p) => p.toJson()).toList();
}

User userFromJson(String str) {
  final jsonData = json.decode(str);
  return User.fromMap(jsonData);
}

String userToJson(User data) {
  final dyn = data.toMap();
  return json.encode(dyn);
}
