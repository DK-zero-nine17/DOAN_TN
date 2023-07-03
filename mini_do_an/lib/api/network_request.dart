import 'dart:convert';
import 'dart:core';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:mini_do_an/Model/comment.dart';
import 'package:mini_do_an/Model/picture.dart';

import '../Model/post.dart';
import '../Model/user.dart';

class NetworkRequest {
  static const String urlAPI = 'http://172.16.2.184:8080/';
  ///////////////////////////////User//////////////////////////////////
  static const String urlGetAllUser = '${urlAPI}getAllUser';
  static const String urlGetOneUser = '${urlAPI}getOneUser/';
  static const String urlDeleteUser = '${urlAPI}deleteUser/';
  static const String urlPostNewUser = '${urlAPI}postNewUser';
  static const String urlPutUser = '${urlAPI}putUser';
  ///////////////////////////////Comment//////////////////////////////////
  static const String urlGetAllComment = '${urlAPI}getAllComment?postId=';
  static const String urlPostNewComment = '${urlAPI}postNewComment';
  static const String urlDeleteComment = '${urlAPI}deleteComment/';
  static const String urlPutComment = '${urlAPI}putComment';

  ////////////////////////////////Post///////////////////////////////////
  static const String urlGetAllPost = '${urlAPI}getAllPost';
  static const String urlGetAllPostLienQuan = '${urlAPI}getPostLienQuan?';
  static const String urlGetFavoriteAllPost =
      '${urlAPI}getRecordInHiddenPostWithStatus?';
  static const String urlGetAllPostWithTrangThai =
      '${urlAPI}getPostWithStatus?';
  static const String urlGetAllPostWithMDHuHong =
      '${urlAPI}getPostWithMDHuHong?';
  static const String urlGetAllPostWithMDCanThiet =
      '${urlAPI}getPostWithMDCanThiet?';
  static const String urlGetAllPostsSearchBar = '${urlAPI}getPostSearchBar?';
  static const String urlGetAllPostOfSelected = '${urlAPI}getAllPostOFSelected';
  static const String urlDeletePost = '${urlAPI}deletePost/';
  static const String urlPostNewHiddenPost = '${urlAPI}postNewHiddenPost';
  static const String urlPutPost = '${urlAPI}putPost';
  static const String urlPostNewPost = '${urlAPI}postNewPost';
  static const String urlDeleteHiddenPost = '${urlAPI}deleteHiddenPost';

  static const String urlGetAllPictureWithIdPost = '${urlAPI}getAllPicture';
  //////////////////AUTH////////////////////////
  static const String urlLogin = '${urlAPI}login';
  static const String urlRegister = '${urlAPI}register';
  ///////////// User/////////////////////////////
  static List<User> parseUser(String responseBody) {
    var list = jsonDecode(responseBody) as List;
    print(responseBody);
    List<User> users = list.map((e) => User.fromMap(e)).toList();

    return users;
  }

  static Future<List<User>> fetchAllUsers({int page = 1}) async {
    final response = await http.get(Uri.parse(urlGetAllUser));
    if (response.statusCode == 200) {
      return parseUser(response.body);
    } else if (response.statusCode == 404) {
      throw Exception('Not Found');
    } else {
      throw Exception('can not get Users');
    }
  }

  static Future<List<User>> fetchOneUser(int idUser, {int page = 1}) async {
    final response = await http.get(Uri.parse('$urlGetOneUser$idUser'));
    if (response.statusCode == 200) {
      return parseUser(response.body);
    } else if (response.statusCode == 404) {
      throw Exception('Not Found');
    } else {
      throw Exception('can not get Users');
    }
  }

  static Future<void> deleteUser(String idUser) async {
    final response = await http.delete(Uri.parse(urlDeleteUser + idUser));
    if (response.statusCode == 200) {
      print('Xóa dữ liệu thành công!');
    } else {
      print('Xóa dữ liệu thất bại. Mã lỗi: ${response.statusCode}');
    }
  }

  static Future<User> postUser(User newUser) async {
    final response = await http.post(Uri.parse(urlPostNewUser), body: {
      "id": 0,
      "mssvUser": newUser.mssvUser,
      "nameUser": newUser.nameUser,
      "emailUser": newUser.emailUser,
      "lopUser": newUser.lopUser,
      "passwordUser": newUser.passwordUser
    });
    if (response.statusCode == 200) {
      print('Them dữ liệu thành công!');
    } else {
      print('Them dữ liệu thất bại. Mã lỗi: ${response.statusCode}');
    }
    return json.decode(response.body);
  }

  static Future<void> putUser(User editUser) async {
    final request = http.MultipartRequest('PUT', Uri.parse(urlPutUser));
    print(jsonEncode(editUser.toJson()));
    request.fields['user'] = jsonEncode(editUser.toJson()); //
    if (!RegExp('^http').hasMatch(editUser.avatarUser!)) {
      request.files.add(
          await http.MultipartFile.fromPath('avatar', editUser.avatarUser!));
    }
    final response = await request.send();
    if (response.statusCode == 200) {
      print('Cập nhật dữ liệu thành công!');
    } else {
      print('Cập nhật dữ liệu thất bại. Mã lỗi: ${response.statusCode}');
    }
    // return json.decode(User.fromMap(response.body));
  }

  ////////////////////Comment////////////////////////
  static List<Comment> parseComment(String responseBody) {
    var list = json.decode(responseBody) as List;
    List<Comment> comments = list.map((e) => Comment.fromMap(e)).toList();
    return comments;
  }

  static Future<List<Comment>> fetchAllComment(int idPost,
      {int page = 1}) async {
    Uri url = Uri.parse('$urlGetAllComment$idPost');
    print('--------------------------$url');
    final response = await http.get(url);
    if (response.statusCode == 200) {
      return compute(parseComment, response.body);
    } else if (response.statusCode == 404) {
      throw Exception('Not Found');
    } else {
      throw Exception('Can not get Comments');
    }
  }

  static Future<Comment> postNewComment(Comment cmt) async {
    // List<Comment> listData = [];
    final response = await http.post(Uri.parse(urlPostNewComment),
        body: jsonEncode(cmt.toJson()));
    print(
        'mmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmm');
    if (response.statusCode == 200) {
      print('Them dữ liệu thành công!');
    } else {
      print('Them dữ liệu thất bại. Mã lỗi: ${response.statusCode}');
    }
    return Comment.fromMap(jsonDecode(response.body));
  }

  static Future<void> deleteComment(String idComment) async {
    final response = await http.delete(Uri.parse(urlDeleteComment + idComment));
    if (response.statusCode == 200) {
      print('Xóa dữ liệu thành công!');
    } else {
      print('Xóa dữ liệu thất bại. Mã lỗi: ${response.statusCode}');
    }
  }

  static Future<Comment> putComment(
      int idPostCmt, int idUserCmt, String dateCmt, String contentCmt) async {
    // List<Comment> listData = [];
    final response = await http.put(Uri.parse(urlPutComment), body: {
      "idCmt": 0,
      "idPostCmt": idPostCmt,
      "idUserCmt": idUserCmt,
      "dateCmt": dateCmt,
      "contentCmt": contentCmt
    });
    if (response.statusCode == 200) {
      print('Cập nhật dữ liệu thành công!');
    } else {
      print('Cập nhật dữ liệu thất bại. Mã lỗi: ${response.statusCode}');
    }
    return json.decode(response.body);
  }

  ///////////////////Post//////////////////////
  static List<Post> parsePost(String responseBody) {
    var list = jsonDecode(responseBody) as List;
    print(responseBody);
    List<Post> posts = list.map((e) => Post.fromMap(e)).toList();
    return posts;
  }

  static Future<List<Post>> fetchAllPosts({int page = 1}) async {
    final response = await http.get(Uri.parse(urlGetAllPost));
    if (response.statusCode == 200) {
      return parsePost(response.body);
    } else if (response.statusCode == 404) {
      throw Exception('Not Found');
    } else {
      throw Exception('Can not get Posts');
    }
  }

  static Future<List<Post>> fetchAllStatusOfPost(int idUser, int status) async {
    final response = await http.get(
        Uri.parse("${urlGetFavoriteAllPost}idUser= $idUser&status=$status"));
    if (response.statusCode == 200) {
      return parsePost(response.body);
    } else if (response.statusCode == 404) {
      throw Exception('Not Found');
    } else {
      throw Exception('Can not get Posts');
    }
  }

  static Future<List<Post>> fetchPostLienQuan(
      int idCurrent, String thietbi, String diachi,
      {int page = 1}) async {
    Uri url = Uri.parse(
        '${urlGetAllPostLienQuan}idCurrent=${Uri.encodeComponent('$idCurrent')}&thietBi=${Uri.encodeComponent(thietbi)}&diachi=${Uri.encodeComponent(diachi)}');
    print(url);
    final response = await http.get(url);
    if (response.statusCode == 200) {
      return parsePost(response.body);
    } else if (response.statusCode == 404) {
      throw Exception('Not Found');
    } else {
      throw Exception('Can not get Posts');
    }
  }

  static Future<List<Post>> fetchAllPostWithTrangThai(String trangthai,
      {int page = 1}) async {
    final response = await http
        .get(Uri.parse('${urlGetAllPostWithTrangThai}status=$trangthai'));
    if (response.statusCode == 200) {
      return parsePost(response.body);
    } else if (response.statusCode == 404) {
      throw Exception('Not Found');
    } else {
      throw Exception('Can not get Posts');
    }
  }

  static Future<List<Post>> fetchAllPostWithMdHuHong(String mucdo,
      {int page = 1}) async {
    final response =
        await http.get(Uri.parse('${urlGetAllPostWithMDHuHong}mucdo=$mucdo'));
    if (response.statusCode == 200) {
      return parsePost(response.body);
    } else if (response.statusCode == 404) {
      throw Exception('Not Found');
    } else {
      throw Exception('Can not get Posts');
    }
  }

  static Future<List<Post>> fetchAllPostWithMDCanThiet(String mucdo,
      {int page = 1}) async {
    final response =
        await http.get(Uri.parse('${urlGetAllPostWithMDCanThiet}mucdo=$mucdo'));
    if (response.statusCode == 200) {
      return parsePost(response.body);
    } else if (response.statusCode == 404) {
      throw Exception('Not Found');
    } else {
      throw Exception('Can not get Posts');
    }
  }

  static Future<List<Post>> fetchAllPostSearchBar(String keyword,
      {int page = 1}) async {
    final response =
        await http.get(Uri.parse('${urlGetAllPostsSearchBar}keyword=$keyword'));
    if (response.statusCode == 200) {
      return parsePost(response.body);
    } else if (response.statusCode == 404) {
      throw Exception('Not Found');
    } else {
      throw Exception('Can not get Posts');
    }
  }

  static Future<List<Post>> fetchAllPostOfSelected(int idUser) async {
    final response =
        await http.get(Uri.parse('$urlGetAllPostOfSelected?idUser=$idUser'));
    if (response.statusCode == 200) {
      return parsePost(response.body);
    } else if (response.statusCode == 404) {
      throw Exception('Not Found');
    } else {
      throw Exception('Can not get Posts');
    }
  }

  static Future<void> deletePost(int idPost) async {
    final response = await http.delete(Uri.parse("$urlDeletePost$idPost"));
    print('1111111111111111111111111111111111111111111111111111111111111111');
    if (response.statusCode == 200) {
      print('Xóa dữ liệu thành công!');
    } else {
      print('Xóa dữ liệu thất bại. Mã lỗi: ${response.statusCode}');
    }
  }

  static Future<void> postNewHiddenPost(
      int idUser, int idPost, int status) async {
    final response = await http.post(Uri.parse(urlPostNewHiddenPost),
        body: '{"idUser": $idUser, "idPost": $idPost, "status": $status}');
    if (response.statusCode == 200) {
      print('Cập nhật dữ liệu thành công!');
    } else {
      print('Cập nhật dữ liệu thất bại. Mã lỗi: ${response.statusCode}');
    }
  }

  static void deleteHiddenPost(int idUser, int idPost) async {
    final response = await http.delete(
        Uri.parse('$urlDeleteHiddenPost?idUser=$idUser&idPost=$idPost'));
    if (response.statusCode == 200) {
      print('Cập nhật dữ liệu thành công!');
    } else {
      print('Cập nhật dữ liệu thất bại. Mã lỗi: ${response.statusCode}');
    }
  }

  static Future<Post> postNewPost(Post newPost, List<String> files) async {
    final request = http.MultipartRequest('POST', Uri.parse(urlPostNewPost));
    request.fields['post'] = jsonEncode(
        newPost.toJson()); // Thêm các trường và giá trị của form data

    for (String f in files) {
      request.files.add(await http.MultipartFile.fromPath('pictures', f));
    }

    final response = await request.send();
    if (response.statusCode == 200) {
      print('Cập nhật dữ liệu thành công!');
    } else {
      print('Cập nhật dữ liệu thất bại. Mã lỗi: ${response.statusCode}');
    }
    return Post.fromMap(json.decode(await response.stream.bytesToString()));
  }

  static Future<void> putPost(Post editPost, List<String> files) async {
    final request = http.MultipartRequest('PUT', Uri.parse(urlPutPost));
    request.fields['post'] = jsonEncode(
        editPost.toJson()); // Thêm các trường và giá trị của form data
    List<String> pathOld = [];
    for (String f in Set<String>.from(files).toList()) {
      if (RegExp('^http').hasMatch(f)) {
        pathOld.add(f);
      } else {
        request.files.add(await http.MultipartFile.fromPath('pictures', f));
      }
    }
    request.fields['listOld'] = jsonEncode(pathOld);
    // print(jsonEncode(pathOld) + "aaaaaaaaaaaaaaa");
    // files.forEach((f) async {});
    // request.files.addAll(files.map(
    //         (f) async => (await http.MultipartFile.fromPath('pictures', f)))
    //     as MappedListIterable<String, Future<http.MultipartFile>>);

    final response = await request.send();
    if (response.statusCode == 200) {
      print('Cập nhật dữ liệu thành công!');
    } else {
      print('Cập nhật dữ liệu thất bại. Mã lỗi: ${response.statusCode}');
    }
  }

  static Future<List<Picture>> fetchAllPictureWithIdPost(dynamic idPost) async {
    final response =
        await http.get(Uri.parse('$urlGetAllPictureWithIdPost?idPost=$idPost'));
    print(response.body);
    if (response.statusCode == 200) {
      List<dynamic> jsonList = jsonDecode(response.body);
      return jsonList.map((p) => Picture.fromMap(p)).toList();
    } else if (response.statusCode == 404) {
      throw Exception('Not Found');
    } else {
      throw Exception('Can not get Pictures');
    }
  }

  static Future<User> login(String username, String password) async {
    final response = await http.post(Uri.parse(urlLogin),
        body: '{"username": "$username", "password": "$password"}');
    if (response.statusCode == 200) {
      print('Cập nhật dữ liệu thành công!');
      return User.fromMap(jsonDecode(response.body));
    } else {
      print('Cập nhật dữ liệu thất bại. Mã lỗi: ${response.statusCode}');
      return User(
          id: -1, mssvUser: '', nameUser: '', emailUser: '', passwordUser: '');
    }
  }

  static Future<int> register(User user) async {
    final response = await http.post(Uri.parse(urlRegister),
        body: jsonEncode(user.toJson()));
    if (response.statusCode == 200) {
      print('Đăng ký thành công!');
    } else {
      print('Cập nhật dữ liệu thất bại. Mã lỗi: ${response.statusCode}');
    }
    return jsonDecode(response.body);
  }
}
