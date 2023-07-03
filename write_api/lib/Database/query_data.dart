import 'dart:convert';
import 'dart:typed_data';

import 'package:bcrypt/bcrypt.dart';
import 'package:mysql1/mysql1.dart';
import 'package:uuid/uuid.dart';
import 'package:write_api/Model/picture.dart';
import 'package:write_api/utils/CloundinaryService.dart';

import '../Model/comment.dart';
import '../Model/post.dart';
import '../Model/user.dart';
import 'component_data.dart';

class DBProvider {
  DBProvider._();
  static final DBProvider db = DBProvider._();
  static MySqlConnection? _conn;

  Future<MySqlConnection?> getConn() async {
    if (_conn != null) return _conn;

    // if _database is null we instantiate it
    _conn = await initDB();
    return _conn;
  }

  Future<MySqlConnection> initDB() async {
    final settings = ConnectionSettings(
      host: 'localhost',
      port: 3306,
      user: 'root',
      password: '123456',
      db: 'DACN',
    );
    final settingsAdmin = ConnectionSettings(
      host: 'localhost',
      port: 3306,
      user: 'root',
      password: '123456',
    );

    MySqlConnection conn;
    try {
      conn = await MySqlConnection.connect(settings);
      print('Connected to MSSQL database');
    } catch (ex) {
      conn = await MySqlConnection.connect(settingsAdmin);
      // Create the database if it doesn't exist
      await conn.query('''
        CREATE DATABASE DACN''');
      conn = await MySqlConnection.connect(settings);
      await conn.query('''
        CREATE TABLE `theuser` (
          `id` int NOT NULL AUTO_INCREMENT,
          `passwordUser` varchar(500) NOT NULL,
          `mssvUser` varchar(15) NOT NULL,
          `nameUser` varchar(50) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
          `emailUser` varchar(100) NOT NULL,
          `lopUser` varchar(100) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT NULL,
          `sdtUser` varchar(15) DEFAULT NULL,
          `dateUser` varchar(20) DEFAULT NULL,
          `diachiUser` varchar(100) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT NULL,
          `avatarUser` varchar(500) DEFAULT NULL,
          `status` int NOT NULL DEFAULT '1',
          `rule` int NOT NULL DEFAULT '3',
          PRIMARY KEY (`id`),
          UNIQUE KEY `emailUser_UNIQUE` (`emailUser`)
        ) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=utf8mb3
      ''');
      await conn.query('''
        CREATE TABLE `post` (
          `id` int NOT NULL AUTO_INCREMENT,
          `idUser` int NOT NULL,
          `tieudePost` varchar(100) DEFAULT NULL,
          `nguoiguiPost` varchar(50) DEFAULT NULL,
          `datePost` varchar(20) DEFAULT NULL,
          `noidungPost` varchar(200) DEFAULT NULL,
          `trangThai` varchar(50) DEFAULT 'Chưa duyệt',
          `mdHuHong` varchar(50) DEFAULT NULL,
          `mdCanThiet` varchar(50) DEFAULT NULL,
          `thietBi` varchar(50) DEFAULT NULL,
          `diachi` varchar(100) DEFAULT NULL,
          `thoiHan` varchar(20) DEFAULT NULL,
          `ghiChu` varchar(500) DEFAULT NULL,
          PRIMARY KEY (`id`),
          KEY `idUser` (`idUser`),
          CONSTRAINT `post_ibfk_1` FOREIGN KEY (`idUser`) REFERENCES `theuser` (`id`)
        ) ENGINE=InnoDB AUTO_INCREMENT=33 DEFAULT CHARSET=utf8mb3;
      ''');
      await conn.query('''
        CREATE TABLE `picture` (
          `id` varchar(50) NOT NULL,
          `url` varchar(200) NOT NULL,
          `contentType` varchar(20) NOT NULL,
          `idPost` int NOT NULL,
          PRIMARY KEY (`id`),
          UNIQUE KEY `id_UNIQUE` (`id`),
          KEY `idPost` (`idPost`),
          CONSTRAINT `picture_ibfk_1` FOREIGN KEY (`idPost`) REFERENCES `post` (`id`)
        ) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3
      ''');
      await conn.query('''
        CREATE TABLE `hiddenpost` (
          `idUser` int NOT NULL,
          `idPost` int NOT NULL,
          `favorite` int DEFAULT NULL,
          PRIMARY KEY (`idUser`,`idPost`),
          KEY `hiddenpost_ibfk_2` (`idPost`),
          CONSTRAINT `hiddenpost_ibfk_1` FOREIGN KEY (`idUser`) REFERENCES `theuser` (`id`),
          CONSTRAINT `hiddenpost_ibfk_2` FOREIGN KEY (`idPost`) REFERENCES `post` (`id`)
        ) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3
      ''');
      await conn.query('''
        CREATE TABLE `comment` (
          `id` int NOT NULL AUTO_INCREMENT,
          `idPost` int DEFAULT NULL,
          `idUser` int DEFAULT NULL,
          `dateComment` varchar(20) DEFAULT NULL,
          `noidungComment` varchar(200) DEFAULT NULL,
          `isAnDanh` int DEFAULT '1',
          PRIMARY KEY (`id`),
          KEY `idUserCmt` (`idUser`),
          KEY `idPostCmt` (`idPost`),
          CONSTRAINT `idPost_post_key` FOREIGN KEY (`idPost`) REFERENCES `post` (`id`),
          CONSTRAINT `idUser_theuser_key` FOREIGN KEY (`idUser`) REFERENCES `theuser` (`id`)
        ) ENGINE=InnoDB AUTO_INCREMENT=27 DEFAULT CHARSET=utf8mb3
      ''');
      await conn.query('''
        SET GLOBAL sql_mode=(SELECT REPLACE(@@sql_mode,'ONLY_FULL_GROUP_BY',''));
      ''');
      print('Connected to MSSQL database with ADMIN');
    }
    return conn;
  }

  //COMMENT

  Future<Comment> newComment(Comment newComment) async {
    final connection = await getConn();
    // Insert vao bang Comment su dung id moi
    var resultInsert = await connection!.query(
      'INSERT INTO Comment (idPost, idUser, dateComment, noidungComment, isAnDanh) VALUES (?, ?, ?, ?, ?)',
      [
        newComment.idPost,
        newComment.idUser,
        DateTime.now().toUtc().toString().substring(0, 19),
        newComment.noidungComment,
        newComment.isAnDanh
      ],
    );
    newComment.id = resultInsert.insertId ?? 0;
    return newComment;
  }

  // get data all of Comment on  IDPost

  Future<List<Comment>> getAllComment(int _idPost) async {
    final connection = await getConn();
    return (await connection!.query(
      '''
        SELECT c.*, u.avatarUser AS avatar, u.nameUser AS nguoiComment
        FROM Comment c 
        INNER JOIN theUser u
        ON c.idUser = u.id
        WHERE idPost = ?
      ''',
      [_idPost],
    ))
        .map((row) => Comment.fromMap(row.fields))
        .toList();
  }

  // delete a Comment in DB
  Future<int?> deleteComment(int id) async {
    final connection = await getConn();
    return (await connection!.query(
      'DELETE FROM ${WriteData.TBL_NAME_CMT} WHERE id = ?',
      [id],
    ))
        .affectedRows;
  }

  // update a Account in DB

  Future<Comment> updateComment(Comment updatedComment) async {
    final connection = await getConn();

    await connection!.query(
      'UPDATE ${WriteData.TBL_NAME_CMT} SET '
      'idPost = ?, '
      'idUser = ?, '
      'dateComment = ?, '
      'noidungComment = ? '
      // 'picturesCmt = ? '
      'WHERE id = ?',
      [
        updatedComment.idPost,
        updatedComment.idUser,
        updatedComment.dateComment,
        updatedComment.noidungComment,
        // updatedComment.pictures,
        updatedComment.id,
      ],
    );
    return updatedComment;
  }

  //////////////////////////////POST

  Future<List<Post>> getAllPost() async {
    final connection = await getConn();
    return (await connection!.query('''
            SELECT p.*, u.avatarUser AS avatar
            FROM Post p 
            INNER JOIN TheUser u 
            ON p.idUser = u.id 
            order by datePost desc
        ''')) //group by thietBi,diachi
        .map((row) => Post.fromMap(row.fields))
        .toList();
  }

  // lay nhuwng bai Post lien quanm
  Future<List<Post>> getInforListLienQuanPost(
      int idCurrent, String thietBi, String diachi) async {
    final connection = await getConn();
    return (await connection!.query("""
      SELECT p.*, u.avatarUser AS avatar 
      FROM Post p INNER JOIN TheUser u 
      ON p.idUser = u.id 
      where p.thietBi = '$thietBi' and p.diachi = '$diachi' and p.id != $idCurrent 
      order by p.datePost desc
      """)).map((row) => Post.fromMap(row.fields)).toList();
    //order by soluongLike desc
  }

  //lay all post dang duoc duyet hoac chua duoc duyet
  Future<List<Post>> getPostsStatusDuyet(String kiemduyet) async {
    final connection = await getConn();

    final result = await connection!.query('''
      SELECT p.*, hp.favorite AS status, u.avatarUser AS avatar
      FROM Post p
      LEFT JOIN HiddenPost hp ON p.id = hp.idPost
      INNER JOIN THEUSER u ON p.idUser = u.id 
      WHERE p.trangThai = ?
      GROUP BY p.thietBi, p.diachi
      ORDER BY p.datePost DESC
    ''', [kiemduyet]);

    final list = result.map((row) => Post.fromMap(row.fields)).toList();

    return list;
  }

  //lay all post theo muc do hu hong
  Future<List<Post>> getPostsWithMucDoHuHong(String mucdo) async {
    final connection = await getConn();

    final result = await connection!.query('''
      SELECT p.*, hp.favorite AS status, u.avatarUser AS avatar
      FROM Post p
      LEFT JOIN HiddenPost hp ON p.id = hp.idPost
      INNER JOIN THEUSER u ON p.idUser = u.id 
      WHERE p.mdHuHong = ?
      GROUP BY p.thietBi, p.diachi
      ORDER BY p.datePost DESC
    ''', [mucdo]);

    final list = result.map((row) => Post.fromMap(row.fields)).toList();

    return list;
  }

  //lay all post theo muc do can thiet
  Future<List<Post>> getPostsWithMucDoCanThiet(String mucdo) async {
    final connection = await getConn();

    final result = await connection!.query('''
      SELECT p.*, hp.favorite AS status, u.avatarUser AS avatar
      FROM Post p
      LEFT JOIN HiddenPost hp ON p.id = hp.idPost
      INNER JOIN THEUSER u ON p.idUser = u.id 
      WHERE p.mdCanThiet = ?
      GROUP BY p.thietBi, p.diachi
      ORDER BY p.datePost DESC
    ''', [mucdo]);

    final list = result.map((row) => Post.fromMap(row.fields)).toList();

    return list;
  }

  //// lay all Post theo tieu de: SearchBar
  ///
  Future<List<Post>> getPostsSearchBar(String? _textSearch) async {
    final connection = await getConn();

    final result = await connection!.query('''
      SELECT p.*, u.avatarUser AS avatar 
      FROM Post p 
      INNER JOIN TheUser u ON p.idUser = u.id
      WHERE p.tieudePost LIKE ?
      GROUP BY p.thietBi, p.diachi
      ORDER BY p.datePost DESC
    ''', ['%$_textSearch%']);

    final list = result.map((row) => Post.fromMap(row.fields)).toList();

    return list;
  }

  // get data all of Post in DB theo ID
  Future<List<Post>> getAllPostOFSelected(int idUser) async {
    final connection = await getConn();

    final result = await connection!.query('''
      SELECT p.*, hp.favorite AS status, u.avatarUser AS avatar
      FROM Post p
      LEFT JOIN HiddenPost hp ON p.id = hp.idPost AND hp.idUser = $idUser
      INNER JOIN THEUSER u ON p.idUser = u.id 
      WHERE hp.favorite = 1 OR hp.favorite IS NULL
      GROUP BY p.thietBi, p.diachi
      ORDER BY p.datePost DESC
    ''');

    final list = result.map((row) => Post.fromMap(row.fields)).toList();

    return list;
  }

  Future<String> newPost(Post newPost, List<Uint8List> files) async {
    final connection = await getConn();
    var result = await connection!.query(
      'INSERT INTO Post '
      '(idUser, tieudePost, nguoiguiPost, datePost, noidungPost, trangThai, mdCanThiet, mdHuHong, thietBi, diachi) '
      'VALUES ( ?, ?, ?, ?, ?,  ?, ?, ?, ?, ?)',
      [
        newPost.idUser,
        newPost.tieudePost,
        newPost.nguoiguiPost,
        newPost.datePost,
        newPost.noidungPost,
        newPost.trangThai,
        newPost.mdCanThiet,
        newPost.mdHuHong,
        newPost.thietBi,
        newPost.diachi,
      ],
    );
    newPost.id = result.insertId!;
    List<Picture> lstPics = [];
    for (var f in files) {
      String idPic = const Uuid().v4();
      Picture pictures = await uploadFileCloudinary(f, idPic, newPost.id);
      await newPictures(pictures);
      lstPics.add(pictures);
    }
    newPost.lstPicture = lstPics;
    return jsonEncode(newPost.toJson());
  }

  // update a Account in DB
  Future<String> updatePost(
      Post newPost, List<dynamic> listOld, List<Uint8List> files) async {
    String dk = listOld.isEmpty
        ? ""
        : "AND url NOT IN (${(listOld).map((str) => "'$str'").join(',')})";

    final connection = await getConn();
    try {
      final result = await connection!.query('''
      UPDATE ${WriteData.TBL_NAME_POST}
      SET ${WriteData.COl_ID_USER_POST} = ?,
          ${WriteData.COL_TITLE_POST} = ?,
          ${WriteData.COl_NAME_SEND_POST} = ?,
          ${WriteData.COL_DATE_POST} = ?,
          ${WriteData.COL_CONTENT_POST} = ?,
          ${WriteData.COL_DIACHI_POST} = ?,
          ${WriteData.COL_MDCANTHIET_POST} = ?,
          ${WriteData.COL_MDHUHONG_POST} = ?,
          ${WriteData.COL_THIETBI_POST} = ?
      WHERE id = ?;
    ''', [
        newPost.idUser,
        newPost.tieudePost,
        newPost.nguoiguiPost,
        newPost.datePost,
        newPost.noidungPost,
        newPost.diachi,
        newPost.mdCanThiet,
        newPost.mdHuHong,
        newPost.thietBi,
        newPost.id,
      ]);
    } catch (ex) {
      print(ex);
      throw Exception("Post not found with id = ${newPost.id}");
    }
    List<Picture> lstPics = [];

    ///Lấy danh sách ảnh cũ
    (await connection
            .query("SELECT * FROM Picture WHERE idPost = ${newPost.id} $dk"))
        .map((e) => deleteFileCloudinary(Picture.fromMap(e.fields).id));
    ////Xóa danh sách ảnh cũ
    (await connection
        .query("DELETE FROM Picture WHERE idPost = ${newPost.id} $dk"));
    ////Thêm ảnh mới được update
    for (var f in files) {
      Picture pictures =
          await uploadFileCloudinary(f, const Uuid().v4(), newPost.id);
      await newPictures(pictures);
      lstPics.add(pictures);
    }
    newPost.lstPicture = lstPics;
    return jsonEncode(newPost.toJson());
  }

  updatePostStatus(Map<String, dynamic> infoUpdate) async {
    print(jsonEncode(infoUpdate));
    final connection = await getConn();
    try {
      final result = await connection!.query('''
      UPDATE ${WriteData.TBL_NAME_POST}
      SET trangThai = ?,
          thoiHan = ?,
          ghiChu = ?
      WHERE id = ?;
    ''', [
        infoUpdate['trangThai'],
        infoUpdate['thoiHan'],
        infoUpdate['ghiChu'],
        infoUpdate['idPost'],
      ]);
      return result.affectedRows;
    } catch (ex) {
      print(ex);
      throw Exception("Post not found with id = ${infoUpdate['id']}");
    }
  }

  // delete a pOST in DB
  Future<int> deletePost(int id) async {
    final connection = await getConn();
    await connection!.query('''
    DELETE FROM comment
    WHERE idPost = ?
    ''', [id]);
    await connection.query('''
    DELETE FROM hiddenPost
    WHERE idPost = ?
    ''', [id]);
    await connection.query('''
    DELETE FROM Picture
    WHERE idPost = ?
    ''', [id]);
    final result = await connection.query('''
    DELETE FROM ${WriteData.TBL_NAME_POST}
    WHERE id = ?
    ''', [id]);
    return result.affectedRows!;
  }

// Hidden Post
  //show all the Hidden Or Favorite Post
  Future<List<Post>> showAllWithPostStatus(int idUser, int status) async {
    final connection = await getConn();
    final result = await connection!.query('''
    SELECT p.*, hp.favorite AS status, u.avatarUser as avatar
    FROM Post p
    LEFT JOIN HiddenPost hp ON p.id = hp.idPost
    INNER JOIN THEUSER u ON p.idUser = u.id 
    WHERE hp.favorite = ? AND hp.idUser = ?
    GROUP BY p.thietBi, p.diachi
    ORDER BY p.datePost DESC
  ''', [status, idUser]);

    final list = result.map((row) => Post.fromMap(row.fields)).toList();

    return list;
  }

  //set favorite or Hidden for Post
  Future<int> newPostWithPostStatus(int idUser, int idPost, int status) async {
    if (idUser != 0 && idPost != 0 && status != -1) {
      final connection = await getConn();

      final result = await connection!.query('''
      INSERT INTO HiddenPost (idUser, idPost, favorite) 
      VALUES (?, ?, ?)
      ON DUPLICATE KEY UPDATE favorite = IF(favorite = ?, favorite, ?)
      ''', [idUser, idPost, status, status, status]);

      return status;
    }
    return 0;
  }

  //Cancel The Favorite or Hidden Of Post
  Future<int> deleteStatusPostWith(int idUser, int idPost) async {
    final connection = await getConn();
    final result = await connection!.query('''
    DELETE FROM HiddenPost
    WHERE idUser = ? AND idPost = ?
  ''', [idUser, idPost]);

    return result.affectedRows!;
  }
  //get Avatar of User in DB
  // Future<List<String>> getAvatarUser(int id) async {
  //   final connection = await getConn();
  //   final result = await connection!.query('''
  //   SELECT avatarUser
  //   FROM ${WriteData.TBL_NAME_USER}
  //   WHERE id = ?
  // ''', [id]);

  //   final list =
  //       result.map((row) => row['avatarUser'] as String? ?? '').toList();

  //   return list;
  // }

  //get Password of User in DB
  // Future<List<String>> getPasswords() async {
  //   final connection = await getConn();
  //   final result = await connection!
  //       .query('SELECT passwordUser FROM ${WriteData.TBL_NAME_USER}');

  //   final list = result.map((row) => row['passwordUser'] as String).toList();

  //   return list;
  // }

  // get data of a User in DB from ID

  //////////////////////////User
//get One User
  Future<User> getUserID(int id) async {
    final connection = await getConn();
    final result = await connection!.query('''
    SELECT *
    FROM ${WriteData.TBL_NAME_USER}
    WHERE id = ?
  ''', [id]);

    return User.fromMap(result.first.fields);
  }

  // get data all of USER in DB
  Future<List<User>> getAllUser() async {
    final connection = await getConn();
    final result =
        await connection!.query('SELECT * FROM ${WriteData.TBL_NAME_USER}');

    final list = result.map((row) => User.fromMap(row.fields)).toList();
    return list;
  }

  Future<User> newUser(User newUser) async {
    final connection = await getConn();
    final result = await connection!.query('''
    INSERT INTO TheUser (mssvUser, nameUser, passwordUser, emailUser, lopUser, sdtUser, dateUser, diachiUser, avatarUser, status, rule)
    VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?);
  ''', [
      newUser.mssvUser,
      newUser.nameUser,
      BCrypt.hashpw(newUser.passwordUser, BCrypt.gensalt()),
      newUser.emailUser,
      newUser.lopUser,
      newUser.sdtUser,
      DateTime.now().toUtc().toString().substring(0, 19),
      newUser.diachiUser,
      newUser.avatarUser,
      newUser.status,
      newUser.rule
    ]);
    newUser.id = result.insertId!;
    return newUser;
  }

  // update a User in DB
  Future<User> updateUser(User newUser, Uint8List avatar, bool check) async {
    print(newUser.toJson());
    final connection = await getConn();

    String now = DateTime.now().toUtc().toString().substring(0, 19);
    List<User> lstUser = (await connection!
            .query("SELECT * FROM TheUser WHERE id = ${newUser.id}"))
        .toList()
        .map((e) => User.fromMap(e.fields))
        .toList();
    if (lstUser.length == 0) throw new Exception("Not found User.");
    if (check) {
      newUser.avatarUser =
          await uploadAvatarCloudinary(avatar, const Uuid().v4());
    } else
      newUser.avatarUser = lstUser[0].avatarUser;
    newUser.rule = lstUser.first.rule;
    await connection.query('''
    UPDATE TheUser
    SET mssvUser = ?, nameUser = ?, lopUser = ?, sdtUser = ?, dateUser = ?, diachiUser = ?, avatarUser = ?, status = ?, rule = ?
    WHERE id = ?
  ''', [
      newUser.mssvUser,
      newUser.nameUser,
      newUser.lopUser,
      newUser.sdtUser,
      now,
      newUser.diachiUser,
      newUser.avatarUser,
      newUser.status,
      newUser.rule,
      newUser.id,
    ]);
    newUser.dateUser = now.toString();
    return newUser;
  }

  Future<User> updateUserByAdmin(User newUser) async {
    print(newUser.toJson());
    final connection = await getConn();
    String now = DateTime.now().toUtc().toString().substring(0, 19);

    await connection!.query('''
    UPDATE TheUser
    SET mssvUser = ?, nameUser = ?, lopUser = ?, sdtUser = ?, dateUser = ?, diachiUser = ?, avatarUser = ?, status = ?, rule = ?
    WHERE id = ?
  ''', [
      newUser.mssvUser,
      newUser.nameUser,
      newUser.lopUser,
      newUser.sdtUser,
      now,
      newUser.diachiUser,
      newUser.avatarUser,
      newUser.status,
      newUser.rule,
      newUser.id,
    ]);
    newUser.dateUser = now.toString();
    return newUser;
  }

  // delete a User in DB
  Future<int> changeStatusUser(int id) async {
    final connection = await getConn();
    Results rs = await connection!.query(
      '''UPDATE ${WriteData.TBL_NAME_USER}
        SET status = !status
        WHERE id = ?''',
      [id],
    );
    return rs.affectedRows!;
  }

  /////////////////////AUTH///////////////////////////
  Future<User> login(String email, String password) async {
    final connection = await getConn();
    final result = (await connection!.query('''
    SELECT *
    FROM TheUser
    WHERE emailUser = ?
  ''', [email])).toList();
    var user = User(
        id: -1,
        mssvUser: "",
        nameUser: "",
        emailUser: "",
        passwordUser: "",
        status: -1,
        rule: 0);
    if (result.isEmpty) {
      return user;
    }
    final existUser = User.fromMap(result.first.fields);
    user.emailUser = email;
    user.status = existUser.status;
    if (user.status == 0) return user;
    if (BCrypt.checkpw(password, existUser.passwordUser)) return existUser;

    return user;
  }

  Future<int> register(User newUser) async {
    final connection = await getConn();
    final result = await connection!.query('''
    INSERT INTO TheUser (mssvUser, nameUser, passwordUser, emailUser, lopUser, status, rule)
    VALUES (?, ?, ?, ?, ?, ?, ?);
  ''', [
      newUser.mssvUser,
      newUser.nameUser,
      BCrypt.hashpw(newUser.passwordUser, BCrypt.gensalt()),
      newUser.emailUser,
      newUser.lopUser,
      1,
      3
    ]);
    return result.affectedRows!;
  }

  //get Password of User in DB
  Future<List<String>> get() async {
    final connection = await getConn();
    final result = await connection!.query('SELECT h.* FROM hiddenpost h');

    final list = result.map((row) => jsonEncode(row)).toList();

    return list;
  }

  /////////////////////// PICTURES /////////////////////
  // get data all of USER in DB
  Future<List<Picture>> getAllPicture(int idPost) async {
    final connection = await getConn();
    final result =
        await connection!.query('SELECT * FROM Picture WHERE idPost = $idPost');

    final list = result.map((row) => Picture.fromMap(row.fields)).toList();
    return list;
  }

  Future<int?> newPictures(Picture picture) async {
    final connection = await getConn();

    final result = await connection!.query('''
      INSERT INTO Picture (id, url, contentType, idPost) 
      VALUES (?, ?, ?, ?)
      ''', [picture.id, picture.url, picture.contentType, picture.idPost]);
    return result.insertId!;
  }

  // delete a User in DB
  Future<int> deletePicture(int id) async {
    final connection = await getConn();
    Results rs = await connection!.query(
      '''UPDATE ${WriteData.TBL_NAME_USER}
        SET status = 0
        WHERE id = ?''',
      [id],
    );
    return rs.affectedRows!;
  }
}
