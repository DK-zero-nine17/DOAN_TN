import 'package:mini_do_an/Model/picture.dart';

class Post {
  int id;
  int idUser;
  String tieudePost;
  String nguoiguiPost;
  String datePost;
  String noidungPost;
  String? trangThai;
  String? mdHuHong;
  String? mdCanThiet;
  String thietBi;
  String? diachi;
  int? status;
  List<Picture>? lstPicture;
  String? avatar;

  Post(
      {required this.id,
      required this.idUser,
      required this.tieudePost,
      required this.nguoiguiPost,
      required this.datePost,
      required this.noidungPost,
      this.trangThai,
      this.mdCanThiet,
      this.mdHuHong,
      required this.thietBi,
      this.diachi,
      this.status,
      this.lstPicture,
      this.avatar});

  factory Post.fromMap(Map<String, dynamic> json) => Post(
      id: json["id"],
      idUser: json["idUser"],
      tieudePost: json["tieudePost"],
      nguoiguiPost: json["nguoiguiPost"],
      noidungPost: json["noidungPost"],
      datePost: json["datePost"],
      trangThai: json["trangThai"],
      mdHuHong: json["mdHuHong"],
      mdCanThiet: json["mdCanThiet"],
      thietBi: json["thietBi"],
      diachi: json["diachi"],
      status: json["status"] ?? -1,
      avatar: json["avatar"]);

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> json = {
      'id': id,
      'idUser': idUser,
      'tieudePost': tieudePost,
      'nguoiguiPost': nguoiguiPost,
      'datePost': datePost,
      'noidungPost': noidungPost,
      'thietBi': thietBi,
      'avatar': avatar,
    };

    if (trangThai != null) {
      json['trangThai'] = trangThai;
    }
    if (mdHuHong != null) {
      json['mdHuHong'] = mdHuHong;
    }
    if (mdCanThiet != null) {
      json['mdCanThiet'] = mdCanThiet;
    }
    if (diachi != null) {
      json['diachi'] = diachi;
    }
    if (status != -1) {
      json['status'] = status;
    }
    if (lstPicture != null) {
      json['lstPicture'] = toListJsonPicture(lstPicture!);
    }
    if (avatar != null) {
      json['avatar'] = avatar;
    }
    return json;
  }
}

List<Map<String, dynamic>> toListJson(List<Post> lstPost) {
  return lstPost.map((p) => p.toJson()).toList();
}
