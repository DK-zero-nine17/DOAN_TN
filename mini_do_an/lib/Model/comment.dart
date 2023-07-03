class Comment {
  int id;
  int idPost;
  int idUser;
  String dateComment;
  String noidungComment;

  String? nguoiComment;
  String? avatar;
  int isAnDanh;

  Comment(
      {required this.id,
      required this.idPost,
      required this.idUser,
      required this.dateComment,
      required this.noidungComment,
      this.nguoiComment,
      this.avatar,
      required this.isAnDanh});

  factory Comment.fromMap(Map<String, dynamic> json) => Comment(
      id: json["id"],
      idUser: json["idUser"],
      idPost: json["idPost"],
      dateComment: json["dateComment"],
      noidungComment: json["noidungComment"],
      nguoiComment: json["nguoiComment"],
      avatar: json["avatar"],
      isAnDanh: json["isAnDanh"]);

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
