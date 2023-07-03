import 'dart:convert';
import 'dart:typed_data';
import 'package:shelf/shelf.dart' as shelf;
import 'package:shelf_multipart/form_data.dart';
import 'package:shelf_multipart/multipart.dart';
import 'package:write_api/Database/query_data.dart';
import 'package:write_api/Model/comment.dart';
import 'package:write_api/Model/picture.dart';
import 'package:write_api/Model/post.dart';
import 'package:write_api/Model/user.dart';
import 'package:write_api/utils/CloundinaryService.dart';

class Api {
/////////////////////// COMMENT//////////////////////////////\
  Future<shelf.Response> handleGetComment(shelf.Request request) async {
    final queryParams = request.url.queryParameters;
    return shelf.Response.ok(jsonEncode(toListCmtJson(await DBProvider.db
        .getAllComment(int.parse(queryParams["postId"] ?? "0")))));
  }

  Future<shelf.Response> handlePostNewComment(shelf.Request request) async {
    // Đọc nội dung body dưới dạng byte array (Uint8List)
    var body = await request.readAsString();
    Comment cmt = await DBProvider.db.newComment(commentFromJson(body));
    return shelf.Response.ok(jsonEncode(cmt));
  }

  Future<shelf.Response> handlePutComment(shelf.Request request) async {
    var body = await request.readAsString();
    Comment? cmt = await DBProvider.db.updateComment(commentFromJson(body));
    return shelf.Response.ok(jsonEncode(cmt));
  }

  Future<shelf.Response> handleDeleteComment(
      shelf.Request request, int idCmt) async {
    final responseBody = jsonEncode(await DBProvider.db.deleteComment(idCmt));
    return shelf.Response.ok(responseBody);
  }

// //////////////////// POST ////////////////////////////////\

  Future<shelf.Response> handleGetPost(shelf.Request request) async {
    return shelf.Response.ok(
        jsonEncode(toListJsonWithAdmin(await DBProvider.db.getAllPost())));
  }

  Future<shelf.Response> handleGetPostLienQuan(shelf.Request request) async {
    final queryParams = request.url.queryParameters;
    return shelf.Response.ok(jsonEncode(toListJson(await DBProvider.db
        .getInforListLienQuanPost(int.parse(queryParams["idCurrent"] ?? '0'),
            queryParams["thietBi"] ?? '', queryParams["diachi"] ?? ''))));
  }

  Future<shelf.Response> handleGetPostWithStatus(shelf.Request request) async {
    final queryParams = request.url.queryParameters;
    return shelf.Response.ok(jsonEncode(toListJsonWithAdmin(
        await DBProvider.db.getPostsStatusDuyet(queryParams["status"] ?? ''))));
  }

  Future<shelf.Response> handleGetPostsWithMucDoHuHong(
      shelf.Request request) async {
    final queryParams = request.url.queryParameters;
    return shelf.Response.ok(jsonEncode(toListJsonWithAdmin(await DBProvider.db
        .getPostsWithMucDoHuHong(queryParams["mucdo"] ?? ''))));
  }

  Future<shelf.Response> handleGetPostsWithMucDoCanThiet(
      shelf.Request request) async {
    final queryParams = request.url.queryParameters;
    return shelf.Response.ok(jsonEncode(toListJsonWithAdmin(await DBProvider.db
        .getPostsWithMucDoCanThiet(queryParams["mucdo"] ?? ''))));
  }

  Future<shelf.Response> handleGetPostsSearchBar(shelf.Request request) async {
    final queryParams = request.url.queryParameters;
    return shelf.Response.ok(jsonEncode(toListJson(
        await DBProvider.db.getPostsSearchBar(queryParams["keyword"] ?? ''))));
  }

  Future<shelf.Response> handleGetAllPostOFSelected(
      shelf.Request request) async {
    final queryParams = request.url.queryParameters;
    return shelf.Response.ok(jsonEncode(toListJson(await DBProvider.db
        .getAllPostOFSelected(int.parse(queryParams['idUser'] ?? '0')))));
  }

  Future<shelf.Response> handlePostNewPost(shelf.Request request) async {
    Post post = Post(
        id: -1,
        idUser: 0,
        tieudePost: '',
        nguoiguiPost: '',
        datePost: '',
        noidungPost: '',
        thietBi: '');
    List<Uint8List> pictures = [];
    if (request.isMultipart && request.isMultipartForm) {
      await for (final formData in request.multipartFormData) {
        if (formData.name == "post") {
          post = postFromJson(await formData.part.readString());
        } else if (formData.name == "pictures") {
          pictures.add(await formData.part.readBytes());
        }
      }
      if (post.id == -1) throw Exception("Missing data Post input.");
      final responseBody = await DBProvider.db.newPost(post, pictures);
      return shelf.Response.ok(responseBody);
    }
    return shelf.Response.ok('Not a multipart request');
  }

  Future<shelf.Response> handlePutPost(shelf.Request request) async {
    Post post = Post(
        id: 0,
        idUser: 0,
        tieudePost: '',
        nguoiguiPost: '',
        datePost: '',
        noidungPost: '',
        thietBi: '');
    List<Uint8List> pictures = [];
    List<dynamic> listOld = [];
    if (request.isMultipart && request.isMultipartForm) {
      await for (final formData in request.multipartFormData) {
        if (formData.name == "post") {
          post = postFromJson(await formData.part.readString());
        } else if (formData.name == "listOld") {
          listOld = jsonDecode(await formData.part.readString());
        } else if (formData.name == "pictures") {
          pictures.add(await formData.part.readBytes());
        }
      }
      if (post.id == 0) throw Exception("Missing data Post input.");
      print('------------------------${pictures.length}');
      final responseBody =
          await DBProvider.db.updatePost(post, listOld, pictures);
      return shelf.Response.ok(responseBody);
    }
    return shelf.Response.ok('Not a multipart request');
  }

  Future<shelf.Response> handlePutPostStatus(shelf.Request request) async {
    final responseBody = jsonEncode(await DBProvider.db
        .updatePostStatus(jsonDecode(await request.readAsString())));
    return shelf.Response.ok(responseBody);
  }

  Future<shelf.Response> handleDeletePost(
      shelf.Request request, int idPost) async {
    final responseBody = jsonEncode(await DBProvider.db.deletePost(idPost));
    await deleteFolderCloudinary(idPost);
    return shelf.Response.ok(responseBody);
  }

// //////////////////// LIKE/HIDDEN POST ////////////////////////////////
  Future<shelf.Response> handleGetAllWithPostStatus(
      shelf.Request request) async {
    var responseBody = "{}";
    final queryParams = request.url.queryParameters;
    List<Post> lstPost = await DBProvider.db.showAllWithPostStatus(
        int.parse(queryParams["idUser"] ?? "0"),
        int.parse(queryParams["status"] ?? "-1"));

    responseBody = jsonEncode(toListJson(lstPost));

    return shelf.Response.ok(responseBody);
  }

  Future<shelf.Response> handlePostHiddenPost(shelf.Request request) async {
    final formData = jsonDecode(await request.readAsString());
    print(formData);
    final responseBody = jsonEncode(await DBProvider.db.newPostWithPostStatus(
        formData["idUser"] ?? 0,
        formData["idPost"] ?? 0,
        formData["status"] ?? -1));

    return shelf.Response.ok(responseBody);
  }

  Future<shelf.Response> handleDeleteHiddenPost(shelf.Request request) async {
    final params = request.url.queryParameters;
    final responseBody = jsonEncode(
      await DBProvider.db.deleteStatusPostWith(
          int.parse(params["idUser"] ?? '0'),
          int.parse(params["idPost"] ?? '0')),
    );

    return shelf.Response.ok(responseBody);
  }

// //////////////////// USER ////////////////////////////////
  Future<shelf.Response> handleGetALLUser(shelf.Request request) async {
    var responseBody = "{}";
    // final queryParams = request.url.queryParameters;
    List<User> listUser = await DBProvider.db.getAllUser();
    responseBody = jsonEncode(toListJsonUser(listUser));
    return shelf.Response.ok(responseBody);
  }

  Future<shelf.Response> handleGetOneUser(shelf.Request request, int id) async {
    var responseBody = "{}";
    User user = await DBProvider.db.getUserID(id);
    List<User> listUser = [user];
    responseBody = jsonEncode(listUser.isEmpty ? [] : toListJsonUser(listUser));
    return shelf.Response.ok(responseBody);
  }

  Future<shelf.Response> handlePostNewUser(shelf.Request request) async {
    final body = await request.readAsString();
    // Do something with the request data
    final responseBody =
        jsonEncode((await DBProvider.db.newUser(userFromJson(body))).toJson());
    return shelf.Response.ok(responseBody);
  }

  Future<shelf.Response> handlePutUser(shelf.Request request) async {
    try {
      User user = User(
          id: -1,
          mssvUser: '',
          nameUser: '',
          emailUser: '',
          passwordUser: '',
          status: 0,
          rule: 0);
      Uint8List avatar = Uint8List(6564);
      bool checkAvatar = false;
      if (request.isMultipart && request.isMultipartForm) {
        await for (final formData in request.multipartFormData) {
          if (formData.name == "user") {
            user = userFromJson(await formData.part.readString());
          } else if (formData.name == "avatar") {
            avatar = await formData.part.readBytes();
            checkAvatar = true;
          }
        }
        print(jsonEncode((user.toJson())));
        if (user.id == -1) throw Exception("Missing data Post input.");
        final responseBody = jsonEncode(
            (await DBProvider.db.updateUser(user, avatar, checkAvatar))
                .toJson());

        return shelf.Response.ok(responseBody);
      }
    } catch (ex) {
      return shelf.Response.badRequest();
    }
    return shelf.Response.ok("");
  }

  Future<shelf.Response> handlePutUserByAdmin(shelf.Request request) async {
    final body = jsonDecode(await request.readAsString());
    final responseBody = jsonEncode(
        await DBProvider.db.updateUserByAdmin(User.fromMap(jsonDecode(body))));
    return shelf.Response.ok(responseBody);
  }

  Future<shelf.Response> handleDeleteUser(shelf.Request request, int id) async {
    final responseBody = jsonEncode(await DBProvider.db.changeStatusUser(id));

    // Do something with the request data

    return shelf.Response.ok(responseBody);
  }

/////////////////////////// AUTH ////////////////////////////
  Future<shelf.Response> login(shelf.Request request) async {
    final body = jsonDecode(await request.readAsString());
    final responseBody = jsonEncode(
        await DBProvider.db.login(body["username"], body["password"]));
    return shelf.Response.ok(responseBody);
  }

  Future<shelf.Response> register(shelf.Request request) async {
    final body = await request.readAsString();
    final responseBody =
        jsonEncode(await DBProvider.db.register(userFromJson(body)));
    return shelf.Response.ok(responseBody);
  } ////////////////////////// PICTURE ////////////////////////////

  Future<shelf.Response> handleGetAllPictureWithIdPost(
      shelf.Request request) async {
    final queryParams = request.url.queryParameters;
    final responseBody = jsonEncode(toListJsonPicture(
        await DBProvider.db.getAllPicture(int.parse(queryParams['idPost']!))));
    return shelf.Response.ok(responseBody);
  }
}
