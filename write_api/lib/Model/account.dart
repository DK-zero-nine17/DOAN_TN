

class HiddenPost {
  int idPost;
  int idUser;

  HiddenPost({
    required this.idPost,
    required this.idUser,
  });
}
//   int get getID => this.id;

//   factory Account.fromMap(Map<String, dynamic> json) => new Account(
//         id: json["id"],
//         tenDNhap: json["tenDNhap"],
//         matKhau: json["matKhau"],
//       );

//   Map<String, dynamic> toMap() => {
//         "id": id,
//         "tenDNhap": tenDNhap,
//         "matKhau": matKhau,
//       };
// }

// Account accountFromJson(String str) {
//   final jsonData = json.decode(str);
//   return Account.fromMap(jsonData);
// }

// String userToJson(Account data) {
//   final dyn = data.toMap();
//   return json.encode(dyn);
// }
