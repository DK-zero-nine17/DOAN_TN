import 'dart:convert';

class Picture {
  String id;
  String url;
  String contentType;
  int? idPost;

  Picture(
      {required this.id,
      required this.url,
      required this.contentType,
      this.idPost});

  factory Picture.fromMap(Map<String, dynamic> json) => Picture(
      id: json["id"], url: json["url"], contentType: json["contentType"]);

  Map<String, dynamic> toMap() =>
      {'id': id, "url": url, "contentType": contentType};

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> json = {
      'id': id,
      'url': url,
      'contentType': contentType
    };
    return json;
  }
}

List<Map<String, dynamic>> toListJsonPicture(List<Picture> lstPicture) {
  return lstPicture.map((p) => p.toJson()).toList();
}

Picture postFromJsonPicture(String str) {
  final jsonData = json.decode(str);
  return Picture.fromMap(jsonData);
}

String postToJsonPicture(Picture data) {
  final dyn = data.toMap();
  return json.encode(dyn);
}
