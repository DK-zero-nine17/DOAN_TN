import 'dart:async' show Future;
import 'dart:convert';
import 'dart:io';

import 'package:shelf/shelf.dart';
import 'package:shelf/shelf_io.dart' as shelf_io;
import 'package:shelf_cors_headers/shelf_cors_headers.dart';
import 'package:shelf_router/shelf_router.dart';
import 'package:write_api/Database/query_data.dart';
import 'package:write_api/api/Api.dart';

class Service {
  Handler get handler {
    final router = Router();
    final Api api = Api();
    DBProvider.db.getConn();
    router.get('/getAllPost', (Request request) async {
      return api.handleGetPost(request);
    });
    router.get('/getPostLienQuan', (Request request) async {
      return api.handleGetPostLienQuan(request);
    });
    router.get('/getPostWithStatus', (Request request) async {
      return api.handleGetPostWithStatus(request);
    });
    router.get('/getPostWithMDCanThiet', (Request request) async {
      return api.handleGetPostsWithMucDoCanThiet(request);
    });
    router.get('/getPostWithMdHuHong', (Request request) async {
      return api.handleGetPostsWithMucDoHuHong(request);
    });
    router.get('/getPostSearchBar', (Request request) async {
      return api.handleGetPostsSearchBar(request);
    });
    router.get('/getAllPostOFSelected', (Request request) async {
      return api.handleGetAllPostOFSelected(request);
    });
    router.get('/getAllComment', (Request request) async {
      return api.handleGetComment(request);
    });
    router.get('/getRecordInHiddenPostWithStatus', (Request request) async {
      return api.handleGetAllWithPostStatus(request);
    });
    router.get('/getOneUser/<id>', (Request request, String id) async {
      return api.handleGetOneUser(request, int.parse(id));
    });
    router.get('/getAllUser', (Request request) async {
      return api.handleGetALLUser(request);
    });
    router.get('/getAllPicture', (Request request) async {
      return api.handleGetAllPictureWithIdPost(request);
    });
    router.post('/postNewPost', (Request request) async {
      return api.handlePostNewPost(request);
    });
    router.post('/postNewHiddenPost', (Request request) async {
      return api.handlePostHiddenPost(request);
    });
    router.post('/postNewComment', (Request request) async {
      return api.handlePostNewComment(request);
    });
    router.post('/postNewUser', (Request request) async {
      return api.handlePostNewUser(request);
    });
    router.post('/login', (Request request) async {
      return api.login(request);
    });
    router.post('/register', (Request request) async {
      return api.register(request);
    });
    router.put('/putPost', (Request request) async {
      return api.handlePutPost(request);
    });
    router.put('/putPostStatus', (Request request) async {
      return api.handlePutPostStatus(request);
    });
    router.put('/putComment', (Request request) async {
      return api.handlePutComment(request);
    });
    router.put('/putUser', (Request request) async {
      return api.handlePutUser(request);
    });
    router.put('/putUserByAdmin', (Request request) async {
      return api.handlePutUserByAdmin(request);
    });
    router.delete('/deletePost/<id>', (Request request, String id) async {
      return api.handleDeletePost(request, int.parse(id));
    });
    router.delete('/deleteHiddenPost', (Request request) async {
      return api.handleDeleteHiddenPost(request);
    });
    router.delete('/deleteComment/<id>', (Request request, String id) async {
      return api.handleDeleteComment(request, int.parse(id));
    });
    router.delete('/deleteUser/<id>', (Request request, String id) async {
      return api.handleDeleteUser(request, int.parse(id));
    });
    router.all('/<ignored|.*>', (Request request) {
      return Response.notFound('Page not found');
    });
    return router;
  }
}

// Run shelf server and host a [Service] instance on port 8080.
void main() async {
  // optionally override default headers
  final overrideHeaders = {
    ACCESS_CONTROL_ALLOW_ORIGIN: '*',
    'Content-Type': 'application/json;charset=utf-8',
    ACCESS_CONTROL_ALLOW_METHODS: 'GET,POST,PUT,DELETE',
    ACCESS_CONTROL_ALLOW_HEADERS: 'Origin, Content-Type',
    ACCESS_CONTROL_ALLOW_CREDENTIALS: 'true',
  };

  var handler = const Pipeline()
      // Just add corsHeaders() middleware and pass your header overrides.
      .addMiddleware(
          // corsHeaders()
          corsHeaders(headers: overrideHeaders))
      // .addMiddleware(multipartMiddleware()) // Middleware để xử lý form-data

      .addHandler(Service().handler);

  var server = await shelf_io.serve(handler, '172.16.2.184', 8080);
  print('Server running on ${server.address} - Post: ${server.port}');
}

Response _requestHandler(Request request) {
  return Response.ok('Request for "${request.url}"');
}
