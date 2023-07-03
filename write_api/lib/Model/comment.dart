import 'dart:convert';

class Comment {
  int id;
  int idPost;
  int idUser;
  String dateComment;
  String noidungComment;
  String? avatar;
  String? nguoiComment;
  int isAnDanh;
  // List<String>? pictures;
  //nameperson
  //avatarPerson

  Comment({
    required this.id,
    required this.idPost,
    required this.idUser,
    required this.dateComment,
    required this.noidungComment,
    this.avatar,
    this.nguoiComment,
    required this.isAnDanh,
    // this.pictures,
  });

  factory Comment.fromMap(Map<String, dynamic> json) => Comment(
      id: json["id"],
      idUser: json["idUser"],
      idPost: json["idPost"],
      dateComment: json["dateComment"],
      noidungComment: json["noidungComment"],
      avatar: json["avatar"],
      nguoiComment: json["nguoiComment"],
      isAnDanh: json["isAnDanh"]);

  Map<String, dynamic> toMap() => {
        "id": id,
        "idPost": idPost,
        "idUser": idUser,
        "dateComment": dateComment,
        "noidungComment": noidungComment,
        "avatar": avatar,
        "nguoiComment": nguoiComment,
        "isAnDanh": isAnDanh,
      };
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> json = {
      "id": id,
      "idPost": idPost,
      "idUser": idUser,
      "dateComment": dateComment,
      "noidungComment": noidungComment,
      "isAnDanh": isAnDanh
    };
    if (avatar != null) {
      json["avatar"] = avatar;
    }
    if (nguoiComment != null) {
      json["nguoiComment"] = nguoiComment;
    }
    return json;
  }
}

List<Map<String, dynamic>> toListCmtJson(List<Comment> lst) {
  return lst.map((p) => p.toJson()).toList();
}

Comment commentFromJson(String str) {
  final jsonData = json.decode(str);
  return Comment.fromMap(jsonData);
}

String commentToJson(Comment data) {
  final dyn = data.toMap();
  return json.encode(dyn);
}
