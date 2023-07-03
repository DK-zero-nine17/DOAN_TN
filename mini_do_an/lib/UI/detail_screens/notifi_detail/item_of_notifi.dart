import 'dart:io';

import 'package:expandable_text/expandable_text.dart';
import 'package:flutter/material.dart';
import 'package:mini_do_an/Model/post.dart';
import 'package:mini_do_an/Model/user.dart';
import 'package:mini_do_an/api/network_request.dart';

import 'detail_of_item_notifi.dart';
import 'isikePost.dart';

class ItemOfNotifi extends StatefulWidget {
  ItemOfNotifi({
    super.key,
    required this.iddUser,
    required this.listAllThePosts,
  });
  int iddUser;
  List listAllThePosts;

  @override
  State<ItemOfNotifi> createState() => _ItemOfNotifiState();
}

class _ItemOfNotifiState extends State<ItemOfNotifi> {
  bool isLikePost = false;
  late List<int> indexchangeStatusPost = [];
  late List<bool> valuechangeStatusPost = [];

  void getIsLikePost(int index, bool status, int id) {
    if (status) {
      ///////////////////////////////////////////////////////////////////////////////////
      NetworkRequest.postNewHiddenPost(widget.iddUser, id, 1);
      print('thuc hien them Like trong ItemPost');
    } else {
      NetworkRequest.deleteHiddenPost(widget.iddUser, id);
      print('thuc hien xoa Like  trong ItemPost');
    }
  }

  String avatarUser = '';

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    void goPageDetailPicture(var newPost) {
      showModalBottomSheet<void>(
        context: context,
        isScrollControlled: true,
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(10), topRight: Radius.circular(10))),
        builder: (BuildContext context) {
          return Scaffold(
            body: SafeArea(
              child: DetailItemOfNotify(
                newPost: newPost,
                iddUser: widget.iddUser,
                urlDeleteImage: "",
              ),
            ),
          );
        },
      );
    }

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

    return Container(
      height: widget.listAllThePosts.length * 97.0,
      color: Colors.grey.withOpacity(.2),
      padding: const EdgeInsets.only(bottom: 5, top: 5),
      child: ListView.builder(
        physics: const NeverScrollableScrollPhysics(),
        itemCount: widget.listAllThePosts.length,
        itemBuilder: (BuildContext context, int index) {
          Post item = widget.listAllThePosts[index];
          int? statuOfPostNow = item.status;
          print(
              'FIle ItemPost co bien statusPostNow cua Item ${item.id} co gia tri la:  $statuOfPostNow');

          return Dismissible(
            key: UniqueKey(),

            confirmDismiss: (DismissDirection direction) async {
              return await showDialog(
                context: context,
                builder: (BuildContext context) {
                  print(
                      'id cua bai post dang chon dung de xoaaaa: ${item.id} va status: ${item.status}');

                  return AlertDialog(
                    title: const Text("Thông Báo:"),
                    content:
                        const Text("Bạn có thật sự muốn xóa tin này không?"),
                    actions: <Widget>[
                      ElevatedButton(
                          onPressed: () => Navigator.of(context).pop(true),
                          child: const Text("Có")),
                      ElevatedButton(
                        onPressed: () => Navigator.of(context).pop(false),
                        child: const Text("Không"),
                      ),
                    ],
                  );
                },
              );
            },
            //

            background: Container(
              color: Colors.black,
              alignment: Alignment.centerLeft,
              child: const Center(
                child: Icon(
                  Icons.delete,
                  color: Colors.amber,
                  size: 35,
                ),
              ),
            ),
            onDismissed: (direction) {
              // DBProvider.db.deletePost(item.id);
              statuOfPostNow = 0;
              //////////////////////////////////////////////////////////////////////////////////
              NetworkRequest.postNewHiddenPost(widget.iddUser, item.id, 0);
              print(
                  'id cua bai post dang chon dung de an bai viet: ${item.id} va tra${item.status}');
            },
            child: InkWell(
              onTap: () {
                // print('anhaaaaaaaaaaaaaaaaa ${item}');
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => DetailItemOfNotify(
                        newPost: item,
                        iddUser: widget.iddUser,
                        urlDeleteImage: "",
                      ),
                    ));
              },
              child: statuOfPostNow == 0
                  ? const SizedBox(
                      height: 1,
                    )
                  : Card(
                      margin: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 1),
                      child: ListTile(
                        title: Container(
                          padding: const EdgeInsets.only(top: 10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                '${item.nguoiguiPost}', // tac gia cua bai viet
                                style: const TextStyle(
                                    fontSize: 22,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black),
                              ),
                              Text(
                                formattedDateTime("${item.datePost}"),
                                style: TextStyle(
                                  fontSize: 15,
                                  color: const Color.fromARGB(255, 57, 55, 55)
                                      .withOpacity(.8),
                                ),
                              ),
                            ],
                          ),
                        ),
                        subtitle: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Expanded(
                              flex: 7,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  ExpandableText(
                                    '${item.tieudePost}'
                                    // 'Title of Notification. In there, i have a lot of things.'
                                    ,
                                    expandText: '',
                                    expandOnTextTap: false,
                                    collapseOnTextTap: false,
                                    animation: false,
                                    maxLines: 1,
                                    linkColor: Colors.black,
                                    style: const TextStyle(
                                        fontSize: 18,
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold),
                                    textAlign: TextAlign.justify,
                                  ),
                                  const SizedBox(
                                    height: 1,
                                  ),
                                  ExpandableText(
                                    "${item.noidungPost}",
                                    expandText: '',
                                    expandOnTextTap: false,
                                    collapseOnTextTap: false,
                                    animation: false,
                                    maxLines: 1,
                                    linkColor: Colors.black,
                                    style: const TextStyle(
                                        fontSize: 16, color: Colors.black),
                                    // textAlign: TextAlign.justify,
                                  ),
                                ],
                              ),
                            ),
                            Expanded(
                              flex: 1,
                              child: IsLikePost(
                                id: item.id,
                                isStatusPost: statuOfPostNow,
                                getIsLikePost: getIsLikePost,
                                isCheckPostNotification: false,
                                iddUser: widget.iddUser,
                                index: item.id,
                              ),
                            ),
                          ],
                        ),
                        leading: Container(
                            width: size.width * .1 + 15,
                            height: 40,
                            margin: const EdgeInsets.only(top: 5),
                            child: item.nguoiguiPost == 'Ẩn Danh' ||
                                    item.avatar == ''
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
                                        item.avatar ??
                                            'https://res.cloudinary.com/dkjd3g6t3/image/upload/v1687353508/DACN/Assets/avt-df_ztd19q.jpg',
                                      ),
                                      radius: 50,
                                    ),
                                  )
                            // decoration:
                            //     BoxDecoration(shape: BoxShape.circle),
                            ),
                      ),
                    ),
            ),
          );
        },
      ),
    );

    //  FutureBuilder<List<Post>>(
    //   future: DBProvider.db.getAllPostOFSelected(),
    //   builder: (BuildContext context, AsyncSnapshot<List<Post>> snapshot) {
    //     if (snapshot.hasData) {
    //       return

    //     } else {
    //       return Center(child: CircularProgressIndicator());
    //     }
    //  },
    // );
  }
}
