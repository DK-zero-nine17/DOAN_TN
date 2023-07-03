import 'dart:convert';

import 'package:mysql1/mysql1.dart';
import 'package:write_api/Model/picture.dart';

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
  String? thoiHan;
  String? ghiChu;
  //String avatarOfPost

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
      this.avatar,
      this.thoiHan,
      this.ghiChu});

  factory Post.fromMap(Map<String, dynamic> json) => Post(
      id: json["id"],
      idUser: json["idUser"],
      tieudePost: _convertBlobToString(json["tieudePost"]),
      nguoiguiPost: _convertBlobToString(json["nguoiguiPost"]),
      noidungPost: _convertBlobToString(json["noidungPost"]),
      datePost: _convertBlobToString(json["datePost"]),
      trangThai: _convertBlobToString(json["trangThai"]),
      mdHuHong: _convertBlobToString(json["mdHuHong"]),
      mdCanThiet: _convertBlobToString(json["mdCanThiet"]),
      thietBi: _convertBlobToString(json["thietBi"]),
      diachi: _convertBlobToString(json["diachi"]),
      status: json["status"] ?? -1,
      avatar: json["avatar"],
      thoiHan: json["thoiHan"],
      ghiChu: json["ghiChu"]);

  Map<String, dynamic> toMap() => {
        "id": id,
        "idUser": idUser,
        "tieudePost": tieudePost,
        "nguoiguiPost": nguoiguiPost,
        "datePost": datePost,
        "noidungPost": noidungPost,
        "trangThai": trangThai,
        "mdHuhong": mdHuHong,
        "mdCanThiet": mdCanThiet,
        "thietBi": thietBi,
        "diachi": diachi,
        "avatar": avatar,
        "thoiHan": thoiHan,
        "ghiChu": ghiChu
      };

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> json = {
      'id': id,
      'idUser': idUser,
      'tieudePost': tieudePost,
      'nguoiguiPost': nguoiguiPost,
      'datePost': datePost,
      'noidungPost': noidungPost,
      'thietBi': thietBi,
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

  Map<String, dynamic> toJsonWithAdmin() {
    final Map<String, dynamic> json = {
      'id': id,
      'idUser': idUser,
      'tieudePost': tieudePost,
      'nguoiguiPost': nguoiguiPost,
      'datePost': datePost,
      'noidungPost': noidungPost,
      'thietBi': thietBi,
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
    if (thoiHan != null) {
      json['thoiHan'] = thoiHan;
    }
    if (ghiChu != null) {
      json['ghiChu'] = ghiChu;
    }
    return json;
  }
}

List<Map<String, dynamic>> toListJson(List<Post> lstPost) {
  return lstPost.map((p) => p.toJson()).toList();
}

List<Map<String, dynamic>> toListJsonWithAdmin(List<Post> lstPost) {
  return lstPost.map((p) => p.toJsonWithAdmin()).toList();
}

String _convertBlobToString(dynamic value) {
  if (value is Blob) {
    final blobBytes = value.toString().codeUnits;
    return String.fromCharCodes(blobBytes);
  }
  return value ?? "";
}

Post postFromJson(String str) {
  final jsonData = json.decode(str);
  return Post.fromMap(jsonData);
}

String postToJson(Post data) {
  final dyn = data.toMap();
  return json.encode(dyn);
}
