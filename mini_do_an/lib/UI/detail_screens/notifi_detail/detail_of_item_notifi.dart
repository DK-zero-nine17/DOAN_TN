import 'dart:io';
import 'package:expandable_text/expandable_text.dart';
import 'package:flutter/material.dart';
import 'package:mini_do_an/Model/post.dart';

import 'package:mini_do_an/UI/detail_screens/notifi_detail/detail_one_comment.dart';
import 'package:mini_do_an/UI/detail_screens/notifi_detail/seleted_Image.dart';
import 'package:mini_do_an/api/network_request.dart';

import '../../../Model/comment.dart';
import '../../root.dart';
import '../notifi_layout_picture/five_pictures.dart';
import '../notifi_layout_picture/four_pictures.dart';
import '../notifi_layout_picture/more_five_pictures.dart';
import '../notifi_layout_picture/one_picture.dart';
import '../notifi_layout_picture/three_pictures.dart';
import '../notifi_layout_picture/two_pictures.dart';
import 'Item_DropDown.dart';
import 'micVoice.dart';

class DetailItemOfNotify extends StatefulWidget {
  DetailItemOfNotify({
    super.key,
    required this.newPost,
    required this.iddUser,
    required this.urlDeleteImage,
  });
  Post newPost;
  int iddUser;
  String urlDeleteImage;

  @override
  State<DetailItemOfNotify> createState() => _DetailItemOfNotifyState();
}

class _DetailItemOfNotifyState extends State<DetailItemOfNotify> {
  ///////////// Section EditPost
  bool checkEditPost = true;

  late TextEditingController _tieudeCtrl;

  late TextEditingController _diadiemCtrl;

  late TextEditingController _noidungCtrl;

  final List<String> _optionsA = [
    'Nặng',
    'Bình Thường',
    'Nhẹ',
  ];
  final List<String> _optionsB = [
    'Cao',
    'Bình Thường',
    'Thấp',
  ];

  List<String> listDevices = [
    "bàn học",
    "cái ghế",
    "bảng đen",
    "máy chiếu",
    "camera",
    "máy tính",
    "chuột máy tính",
    "bàn phím máy tính",
    "máy lọc nước"
        "máy quạt"
  ];

  String? _valueHuHong;
  String? _valueCanThiet;
  late String _thietbi;
  void getValueHuHong(String a) {
    _valueHuHong = a;
    print('mmmmmmmmmmmmmmmmmmmmuc do hu hong la $_valueHuHong');
  }

  void getValueCanThiet(String b) {
    _valueCanThiet = b;
    print('mmmmmmmmmmmmmmmmmmmmmmmmuc do can thiet la $_valueCanThiet');
  }

  final List<String> _listImageSelected = [];
  List<String> listAddImageInEdit = [];
  void getpathImage(String pathImage) {
    if (pathImage.isNotEmpty) {
      print(
          'LIST ANH NHAN DUOC cung voi LIst Update LA ${listUpdateImagesOfPosts.toString()}');
      setState(() {
        listAddImageInEdit.add(pathImage);
        _listImageSelected.add(pathImage);
        listUpdateImagesOfPosts.add(pathImage);
      });
    }
  }

  String _contentMic = '';
  void getInforFromMicVoice(String content) {
    setState(() {
      _contentMic = '$_contentMic $content';
      _noidungCtrl.text = _noidungCtrl.text + _contentMic;
    });
  }

  bool editOldPost(BuildContext context) {
    String tieude = _tieudeCtrl.text;
    String diadiem = _diadiemCtrl.text;
    String noidung = _noidungCtrl.text;
    if (tieude.isEmpty || diadiem.isEmpty || _thietbi == '') {
      return true;
    }
    print(
        'gia trigthh va gtct cua thong tin duoc Update Post: $_valueHuHong va $_valueCanThiet');
    Post newPostEdit = Post(
      id: widget.newPost.id,
      avatar: widget.newPost.avatar,
      idUser: widget.iddUser,
      tieudePost: tieude,
      nguoiguiPost: widget.newPost.nguoiguiPost,
      datePost: DateTime.now().toString().substring(0, 19),
      noidungPost: noidung,
      diachi: diadiem,
      mdCanThiet: _valueCanThiet,
      mdHuHong: _valueHuHong,
      thietBi: _thietbi,
      trangThai: 'Đang duyệt',
      status: 1,
      // conm thieu list anh
    );
    print("list anh: $listUpdateImagesOfPosts");
    NetworkRequest.putPost(newPostEdit, listUpdateImagesOfPosts);
    widget.newPost = newPostEdit;
    _tieudeCtrl.clear();
    _diadiemCtrl.clear();
    _noidungCtrl.clear();

    return false;
  }

  /////////////////////////////////////////////////////////////////////////////
  List<Comment> listComments = [];
  int? numbersComments;

  String formattedDateTime(String datetime) {
    // Thời gian đăng bài viết
    DateTime displayTime = DateTime.now(); // Thời gian hiển thị
    DateTime postTime = DateTime.parse(datetime);

    Duration difference =
        displayTime.difference(postTime); // Tính khoảng thời gian chênh lệch

    if (difference.inSeconds < 60) {
      return '${difference.inSeconds} giây';
    } else if (difference.inMinutes < 60) {
      return '${difference.inMinutes} phút';
    } else if (difference.inHours < 24) {
      return '${difference.inHours} giờ';
    } else if (difference.inDays < 30) {
      return '${difference.inDays} ngày';
    } else if (difference.inDays < 365) {
      int months = (difference.inDays / 30).floor();
      return '$months tháng';
    } else {
      int years = (difference.inDays / 365).floor();
      return '$years năm';
    }
  }

  List<String> listImageFromData = [];
  // List<Widget> listLayoutPictures = [];
  List<String> listUpdateImagesOfPosts = [];

  var _lengthListImage = 0;
  String avatarUser = '';
  String nameUser = '';
  @override
  void initState() {
    super.initState();
    _valueCanThiet = widget.newPost.mdCanThiet;
    _valueHuHong = widget.newPost.mdHuHong;
    _thietbi = widget.newPost.thietBi;

    // xem lai List Picture
    NetworkRequest.fetchAllPictureWithIdPost(widget.newPost.id).then((lstP) {
      setState(() {
        listImageFromData = lstP.map((p) => p.url).toList();
        listUpdateImagesOfPosts = listImageFromData;
        _lengthListImage = listImageFromData.length;
        print(
            'aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa $listImageFromData and $_lengthListImage vaaaaaa ');
      });
    });

    NetworkRequest.fetchAllComment(widget.newPost.id).then((c) {
      setState(() {
        listComments = c;
      });
    });
    _tieudeCtrl = TextEditingController(text: widget.newPost.tieudePost);
    _diadiemCtrl = TextEditingController(text: widget.newPost.diachi);

    _noidungCtrl = TextEditingController(text: widget.newPost.noidungPost);

    NetworkRequest.fetchOneUser(widget.iddUser).then((value) {
      setState(() {
        avatarUser = value[0].avatarUser.toString();
        nameUser = value[0].nameUser.toString();
      });
    });
  }

  @override
  void didUpdateWidget(covariant DetailItemOfNotify oldWidget) {
    // TODO: implement didUpdateWidget
    super.didUpdateWidget(oldWidget);

    NetworkRequest.fetchAllComment(widget.newPost.id).then((c) {
      setState(() {
        listComments = c;
      });
    });
  }

  StatefulWidget directLayoutPictures(List<String> listImageFromData) {
    listImageFromData = Set<String>.from(listImageFromData).toList();
    _lengthListImage = listImageFromData.length;
    return [
      OnePicture(
        link: listImageFromData,
        iddUser: widget.iddUser,
        post: widget.newPost,
      ),
      TwoPictures(
        link: listImageFromData,
        iddUser: widget.iddUser,
        post: widget.newPost,
      ),
      ThreePictures(
        link: listImageFromData,
        iddUser: widget.iddUser,
        post: widget.newPost,
      ),
      FourPictures(
        link: listImageFromData,
        iddUser: widget.iddUser,
        post: widget.newPost,
      ),
      FivePictures(
        link: listImageFromData,
        iddUser: widget.iddUser,
        post: widget.newPost,
      ),
      MoreFivePictures(
        link: listImageFromData,
        iddUser: widget.iddUser,
        post: widget.newPost,
      ),
    ][_lengthListImage >= 6 ? 5 : (_lengthListImage - 1)];
  }

  bool isComment = false;

  Widget getWidget() {
    if (listUpdateImagesOfPosts.isEmpty) {
      if (widget.urlDeleteImage.isEmpty) {
        if (_lengthListImage <= 0) {
          return const SizedBox(
            height: 10,
          );
        } else if (_lengthListImage < 6) {
          return directLayoutPictures(listImageFromData);
        }
        return directLayoutPictures(listImageFromData);
      } else {
        setState(() {
          listImageFromData.remove(widget.urlDeleteImage);
        });

        if (_lengthListImage <= 0) {
          return const SizedBox(
            height: 10,
          );
        } else if (_lengthListImage < 6 - 1) {
          return directLayoutPictures(listImageFromData);
        }
        return directLayoutPictures(listImageFromData);
      }
    } else {
      if (listUpdateImagesOfPosts.isEmpty) {
        return const SizedBox(
          height: 10,
        );
      } else if (listUpdateImagesOfPosts.length < 6) {
        return directLayoutPictures(listUpdateImagesOfPosts);
      }
      return directLayoutPictures(listUpdateImagesOfPosts);
    }
  }

  /// Create a new Comment

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    void goPageDetailPostLienQuan(var newPost) {
      Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => DetailItemOfNotify(
              newPost: newPost,
              iddUser: widget.iddUser,
              urlDeleteImage: "",
            ),
          ));
    }

    void goPageShowListCommentsOfPost() {
      showModalBottomSheet<void>(
        context: context,
        isScrollControlled: true,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(10),
            topRight: Radius.circular(10),
          ),
        ),
        builder: (BuildContext context) {
          return SingleChildScrollView(
            child: SizedBox(
              height: size.height - 30,
              child: DetailOfComment(
                idPosts: widget.newPost.id,
                iddUser: widget.iddUser,
                listComments: listComments,
                avatarUser: avatarUser,
                nameUser: nameUser,
              ),
            ),
          );
        },
      );
    }

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 1,
          centerTitle: true,
          title:
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            InkWell(
              onTap: () {
                Navigator.pop(context);
              },
              splashColor: Colors.white,
              hoverColor: Colors.white,
              child: Container(
                width: size.width * .3,
                alignment: Alignment.centerLeft,
                child: const Icon(
                  Icons.arrow_back_outlined,
                  color: Colors.black,
                  size: 32,
                ),
              ),
            ),
            SizedBox(
              width: size.width * .4,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  widget.iddUser != widget.newPost.idUser
                      ? const SizedBox(
                          width: 2,
                        )
                      : InkWell(
                          onTap: () {
                            showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  title: const Text("Thông Báo:"),
                                  content: const Text(
                                      "Bạn có thật sự muốn xóa \n bài viết này không?"),
                                  actions: <Widget>[
                                    ElevatedButton(
                                        onPressed: () {
                                          ////////////////////////////////////////////////////////////////////
                                          // NetworkRequest.postNewHiddenPost(
                                          //     widget.iddUser,
                                          //     widget.newPost.id,
                                          //     0);

                                          NetworkRequest.deletePost(
                                              widget.newPost.id);
                                          //////////////////////////////////////////////////////////////////////////

                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) =>
                                                    RootScreen(
                                                        iddUser: widget.iddUser,
                                                        nameOfUser: widget
                                                            .newPost
                                                            .nguoiguiPost),
                                              ));
                                        },
                                        child: const Text("Có")),
                                    ElevatedButton(
                                      onPressed: () =>
                                          Navigator.of(context).pop(false),
                                      child: const Text("Không"),
                                    ),
                                  ],
                                );
                              },
                            );
                          },
                          child: Container(
                            width: 50,
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            child: const Center(
                              child: Icon(
                                Icons.delete_rounded,
                                color: Colors.black,
                                size: 28,
                              ),
                            ),
                          ),
                        ),
                  const SizedBox(
                    width: 20,
                  ),
                  widget.iddUser != widget.newPost.idUser
                      ? const SizedBox(
                          width: 2,
                        )
                      : InkWell(
                          onTap: () {
                            setState(() {
                              checkEditPost = !checkEditPost;
                            });
                          },
                          child: checkEditPost
                              ? const Icon(
                                  Icons.edit,
                                  color: Colors.black,
                                  size: 28,
                                )
                              : InkWell(
                                  onTap: () {
                                    editOldPost(context)
                                        ? showDialog(
                                            context: context,
                                            builder: (BuildContext context) {
                                              return AlertDialog(
                                                title: const Text("Thông Báo:"),
                                                content: const Text(
                                                    "Vui lòng điền đầy đủ thông tin trước khi cập nhật."),
                                                actions: <Widget>[
                                                  ElevatedButton(
                                                      onPressed: () =>
                                                          Navigator.of(context)
                                                              .pop(true),
                                                      child: const Text("OK")),
                                                ],
                                              );
                                            },
                                          )
                                        : showDialog(
                                            context: context,
                                            builder: (BuildContext context) {
                                              return AlertDialog(
                                                title: const Text("Thông Báo:"),
                                                content: const Text(
                                                    "Cập nhật thông tin thành công"),
                                                actions: <Widget>[
                                                  ElevatedButton(
                                                      onPressed: () {
                                                        setState(() {
                                                          checkEditPost = true;
                                                        });
                                                        Navigator.pop(context);
                                                      },
                                                      child: const Text("OK")),
                                                ],
                                              );
                                            },
                                          );
                                  },
                                  child: Container(
                                    width: 55,
                                    alignment: Alignment.center,
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 20),
                                    child: const Icon(
                                      Icons.check,
                                      color: Colors.green,
                                      size: 28,
                                    ),
                                  ),
                                ),
                        ),
                ],
              ),
            )
          ]),
        ),
        body: checkEditPost
            ? Stack(
                children: [
                  SingleChildScrollView(
                    scrollDirection: Axis.vertical,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 10,
                      ),
                      margin: isComment
                          ? const EdgeInsets.only(bottom: 60)
                          : const EdgeInsets.only(bottom: 5),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 15),
                            child: Text(
                              widget.newPost.tieudePost,
                              style: const TextStyle(
                                fontSize: 22,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          ListTile(
                            title: Container(
                              padding: const EdgeInsets.only(top: 10),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Text(
                                    //'Khanh Herry', // tac gia cua bai viet
                                    widget.newPost.nguoiguiPost,
                                    style: const TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black),
                                  ),
                                  Container(
                                    child: Text(
                                      formattedDateTime(
                                          widget.newPost.datePost),
                                      style: TextStyle(
                                        fontSize: 15,
                                        color: const Color.fromARGB(
                                                255, 57, 55, 55)
                                            .withOpacity(.8),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            subtitle: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "${widget.newPost.trangThai}",
                                ),
                                widget.newPost.status == 1
                                    ? const Icon(Icons.star,
                                        color: Colors.yellow)
                                    : const Icon(
                                        Icons.star,
                                        color: Colors.grey,
                                      ),
                              ],
                            ),
                            leading: Container(
                                width: size.width * .1,
                                height: 50,
                                decoration:
                                    const BoxDecoration(shape: BoxShape.circle),
                                child: widget.newPost.nguoiguiPost ==
                                            'Ẩn Danh' ||
                                        widget.newPost.avatar == ''
                                    ? const CircleAvatar(
                                        backgroundColor: Colors.grey,
                                        backgroundImage:
                                            AssetImage('assets/images/avt.png'),
                                        radius: 25,
                                      )
                                    : Container(
                                        height: 70,
                                        width: 70,
                                        decoration: const BoxDecoration(
                                            shape: BoxShape.circle,
                                            color: Colors.white),
                                        child: CircleAvatar(
                                          backgroundImage: NetworkImage(
                                            widget.newPost.avatar ??
                                                'https://res.cloudinary.com/dkjd3g6t3/image/upload/v1687353508/DACN/Assets/avt-df_ztd19q.jpg',
                                          ),
                                          radius: 50,
                                        ),
                                      )),
                          ),
                          const SizedBox(
                            height: 15,
                          ),
                          ExpandableText(
                            widget.newPost.noidungPost,
                            expandText: 'Xem thêm',
                            expandOnTextTap: true,
                            collapseOnTextTap: true,
                            animation: true,
                            maxLines: 4,
                            linkColor: Colors.black,
                            style: TextStyle(
                                fontSize: 18,
                                color: Colors.black.withOpacity(.8)),
                            textAlign: TextAlign.justify,
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Text(
                            'Mức độ hư hỏng: ${widget.newPost.mdHuHong}',
                            style: TextStyle(
                                fontSize: 16,
                                color: Colors.black.withOpacity(.8)),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Text(
                            'Mức độ cần thiết: ${widget.newPost.mdCanThiet}',
                            style: TextStyle(
                                fontSize: 16,
                                color: Colors.black.withOpacity(.8)),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Text(
                            'Thiết Bị: ${widget.newPost.thietBi}',
                            style: TextStyle(
                                fontSize: 16,
                                color: Colors.black.withOpacity(.8)),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Text(
                            'Địa chỉ: ${widget.newPost.diachi}',
                            style: TextStyle(
                                fontSize: 16,
                                color: Colors.black.withOpacity(.8)),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          getWidget(),
                          const Divider(
                            height: 1,
                            thickness: 1,
                          ),
                          InkWell(
                            onTap: () {
                              goPageShowListCommentsOfPost();
                            },
                            child: Container(
                              height: 60,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  const Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Icon(Icons.comment_rounded),
                                        Text(
                                          'Comment',
                                          style: TextStyle(fontSize: 18),
                                        )
                                      ]),
                                  Text(
                                    '${listComments.length} bình luận',
                                    style: const TextStyle(fontSize: 18),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          const Divider(
                            height: 2,
                            thickness: 2,
                          ),
                          const Text(
                            'Danh sách các bài viết tương tự: ',
                            style: TextStyle(fontSize: 18),
                          ),
                          SizedBox(
                            height: 200,
                            width: size.width,
                            child: FutureBuilder(
                                future: NetworkRequest.fetchPostLienQuan(
                                    widget.newPost.id,
                                    widget.newPost.thietBi,
                                    widget.newPost.diachi!),
                                builder: ((context, snapshot) {
                                  if (snapshot.hasData) {
                                    return ListView.builder(
                                        itemCount: snapshot.data!.length,
                                        itemBuilder: ((context, index) {
                                          var item = snapshot.data![index];
                                          return InkWell(
                                            onTap: () {
                                              //Post _newPost = snapshot.data![index];
                                              // snapshot.data!.isNotEmpty
                                              goPageDetailPostLienQuan(item);
                                              // : const SizedBox(
                                              //     height: 2,
                                              //   );goPageDetailPostLienQuan
                                            },
                                            child: Card(
                                              child: ListTile(
                                                title: Container(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          top: 10),
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .center,
                                                    children: [
                                                      Text(
                                                        item.nguoiguiPost, // tac gia cua bai viet
                                                        style: const TextStyle(
                                                            fontSize: 18,
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            color:
                                                                Colors.black),
                                                      ),
                                                      Text(
                                                        formattedDateTime(
                                                            item.datePost),
                                                        style: TextStyle(
                                                          fontSize: 15,
                                                          color: const Color
                                                                      .fromARGB(
                                                                  255,
                                                                  57,
                                                                  55,
                                                                  55)
                                                              .withOpacity(.8),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                subtitle: Row(
                                                  children: [
                                                    Expanded(
                                                      flex: 7,
                                                      child: Column(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .start,
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: [
                                                          ExpandableText(
                                                            item.tieudePost
                                                            // 'Title of Notification. In there, i have a lot of things.'
                                                            ,
                                                            expandText: '',
                                                            expandOnTextTap:
                                                                false,
                                                            collapseOnTextTap:
                                                                false,
                                                            animation: false,
                                                            maxLines: 1,
                                                            linkColor:
                                                                Colors.black,
                                                            style: const TextStyle(
                                                                fontSize: 17,
                                                                color: Colors
                                                                    .black,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold),
                                                            textAlign: TextAlign
                                                                .justify,
                                                          ),
                                                          ExpandableText(
                                                            item.noidungPost,
                                                            expandText: '',
                                                            expandOnTextTap:
                                                                false,
                                                            collapseOnTextTap:
                                                                false,
                                                            animation: false,
                                                            maxLines: 1,
                                                            linkColor:
                                                                Colors.black,
                                                            style:
                                                                const TextStyle(
                                                                    fontSize:
                                                                        16,
                                                                    color: Colors
                                                                        .black),
                                                            // textAlign: TextAlign.justify,
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                    Expanded(
                                                      flex: 1,
                                                      child: Icon(Icons.star,
                                                          color: item.status ==
                                                                  1
                                                              ? Colors.yellow
                                                              : Colors.grey),
                                                    ),
                                                  ],
                                                ),
                                                leading: Container(
                                                    width: size.width * .1,
                                                    height: 50,
                                                    decoration:
                                                        const BoxDecoration(
                                                            shape: BoxShape
                                                                .circle),
                                                    child: item.nguoiguiPost ==
                                                                'Ẩn Danh' ||
                                                            item.avatar == ''
                                                        ? const CircleAvatar(
                                                            backgroundColor:
                                                                Colors.grey,
                                                            backgroundImage:
                                                                AssetImage(
                                                                    'assets/images/avt.png'),
                                                            radius: 25,
                                                          )
                                                        : Container(
                                                            height: 70,
                                                            width: 70,
                                                            decoration:
                                                                const BoxDecoration(
                                                                    shape: BoxShape
                                                                        .circle,
                                                                    color: Colors
                                                                        .white),
                                                            child: CircleAvatar(
                                                              backgroundImage:
                                                                  NetworkImage(
                                                                item.avatar ??
                                                                    'https://res.cloudinary.com/dkjd3g6t3/image/upload/v1687353508/DACN/Assets/avt-df_ztd19q.jpg',
                                                              ),
                                                              radius: 50,
                                                            ),
                                                          )),
                                              ),
                                            ),
                                          );
                                        }));
                                  } else {
                                    return const Center(
                                        child: SizedBox(
                                      height: 2,
                                    ));
                                  }
                                })),
                          ),
                        ],
                      ),
                    ),
                  ),
                  // Container(
                  //   height: 20,
                  //   margin: const EdgeInsets.only(top: 5),
                  //   child: FutureBuilder(
                  //     future: NetworkRequest.fetchAllComment(widget.newPost.id),
                  //     builder: (BuildContext context,
                  //         AsyncSnapshot<List<Comment>> snapshot) {
                  //       if (snapshot.hasData) {
                  //         return ListView.builder(
                  //             itemCount: snapshot.data?.length,
                  //             itemBuilder: (context, index) {
                  //               var comment = snapshot.data![index];

                  //               if (listComments.length <
                  //                   snapshot.data!.length) {
                  //                 listComments.add(comment);
                  //               }

                  //               return const SizedBox(
                  //                 height: 0,
                  //               );
                  //             });
                  //       } else {
                  //         return const Center(
                  //             child: SizedBox(
                  //           height: 2,
                  //         ));
                  //       }
                  //     },
                  //   ),
                  // ),
                ],
              )
            : SingleChildScrollView(
                child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 10, vertical: 10),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        const Text(
                          'Từ: ',
                          style: TextStyle(fontSize: 18),
                        ),
                        const SizedBox(
                          width: 20,
                        ),
                        SizedBox(
                            width: size.width * .7,
                            child: Text(
                              widget.newPost.nguoiguiPost,
                              style: const TextStyle(fontSize: 20),
                            )),
                      ],
                    ),
                  ),
                  const Divider(
                    thickness: 1,
                    height: 1,
                  ),
                  Container(
                    width: size.width,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 10, vertical: 10),
                    child: TextFormField(
                      controller: _tieudeCtrl,
                      decoration: const InputDecoration(
                        hintText: 'Tiêu đề',
                        border: UnderlineInputBorder(),
                      ),
                    ),
                  ),
                  const Divider(
                    thickness: 1,
                    height: 1,
                  ),
                  Container(
                    width: size.width,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 10, vertical: 10),
                    child: TextFormField(
                      controller: _diadiemCtrl,
                      decoration: const InputDecoration(
                        hintText: 'Địa điểm',
                        border: UnderlineInputBorder(),
                      ),
                    ),
                  ),
                  const Divider(
                    thickness: 1,
                    height: 1,
                  ),
                  Container(
                    width: size.width,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 10, vertical: 10),
                    child: Row(
                      children: [
                        const Expanded(
                          flex: 1,
                          child: Text(
                            'Thiết bị: ',
                            style: TextStyle(fontSize: 16),
                          ),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Expanded(
                          flex: 3,
                          child: SizedBox(
                            height: 50,
                            width: 50,
                            child: Autocomplete<String>(
                              initialValue: TextEditingValue(
                                  text: widget.newPost.thietBi),
                              optionsBuilder: (textEditingValue) {
                                if (textEditingValue.text == '') {
                                  return const Iterable.empty();
                                }
                                return listDevices.where((element) {
                                  return element.contains(
                                      textEditingValue.text.toLowerCase());
                                });
                              },
                              onSelected: (option) {
                                print('the $option was selected');
                                if (option.isEmpty) {
                                  setState(() {
                                    _thietbi = 'Thiết bị chưa được chọn';
                                  });
                                } else {
                                  setState(() {
                                    _thietbi = option;
                                  });
                                }
                              },
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const Divider(
                    thickness: 1,
                    height: 1,
                  ),
                  Container(
                    width: size.width,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 10, vertical: 10),
                    child: Row(
                      children: [
                        const Text(
                          'Mức độ hư hỏng: ',
                          style: TextStyle(fontSize: 16),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        ItemDropDown(
                          listOptions: _optionsA,
                          getValue: getValueHuHong,
                          valueDefault: widget.newPost.mdHuHong,
                        ),
                      ],
                    ),
                  ),
                  const Divider(
                    thickness: 1,
                    height: 1,
                  ),
                  Container(
                    width: size.width,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 10, vertical: 10),
                    child: Row(
                      children: [
                        const Text(
                          'Mức độ cần thiết: ',
                          style: TextStyle(fontSize: 16),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        ItemDropDown(
                          listOptions: _optionsB,
                          getValue: getValueCanThiet,
                          valueDefault: widget.newPost.mdCanThiet,
                        ),
                      ],
                    ),
                  ),
                  const Divider(
                    thickness: 1,
                    height: 1,
                  ),
                  Container(
                    width: size.width,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 10, vertical: 10),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Expanded(
                          flex: 6,
                          child: TextFormField(
                            controller: _noidungCtrl,
                            decoration: const InputDecoration(
                              hintText: 'Nội dung',
                              border: UnderlineInputBorder(),
                              hintMaxLines: 3,
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: InkWell(
                            onTap: () {
                              Navigator.push(context, MaterialPageRoute(
                                builder: (context) {
                                  return MicPost(
                                      getInforFromMicVoice:
                                          getInforFromMicVoice);
                                },
                              ));
                            },
                            child: const Icon(
                              Icons.mic,
                              size: 30,
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  SeletedImageScreen(
                    pathImage: getpathImage,
                    haveShowImages: true,
                    listImageDefault: listImageFromData,
                  ),
                ],
              )),
      ),
    );
  }
}
