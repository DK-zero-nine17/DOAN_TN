import 'package:expandable_text/expandable_text.dart';
import 'package:flutter/material.dart';

import '../../../Model/post.dart';
import '../../../api/network_request.dart';
import 'detail_of_item_notifi.dart';
import 'isikePost.dart';

class SearchScreen extends StatefulWidget {
  SearchScreen({
    super.key,
    required this.size,
    required this.iddUser,
    required this.queryGetList,
  });

  Future<List<Post>>? queryGetList;
  final Size size;
  int iddUser;
  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  bool isLikePost = false;
  late List<int> index_changeStatusPost = [];
  late List<bool> value_changeStatusPost = [];

  void getIsLikePost(int index, bool status, int id) {
    NetworkRequest.deleteHiddenPost(widget.iddUser, id);
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    void goPageDetailPicture(Post newPost) {
      showModalBottomSheet<void>(
        context: context,
        isScrollControlled: true,
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(10), topRight: Radius.circular(10))),
        builder: (BuildContext context) {
          return SizedBox(
            height: size.height,
            child: Center(
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

    return FutureBuilder<List<Post>>(
      future: widget.queryGetList,
      builder: (BuildContext context, AsyncSnapshot<List<Post>> snapshot) {
        if (snapshot.hasData) {
          return Container(
            height: snapshot.data!.length * 97.0,
            color: Colors.grey.withOpacity(.2),
            padding: const EdgeInsets.only(bottom: 5, top: 5),
            child: ListView.builder(
                physics: const NeverScrollableScrollPhysics(),
                itemCount: snapshot.data!.length,
                itemBuilder: ((context, index) {
                  Post item = snapshot.data![index];
                  //////////////////////////////////////////
                  int? statuOfPostNow = item.status;

                  return InkWell(
                    onTap: () {
                      //Post _newPost = snapshot.data![index];
                      // goPageDetailPicture(item);
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
                    child: Card(
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
                                    fontSize: 18,
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
                                        fontSize: 17,
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold),
                                    textAlign: TextAlign.justify,
                                  ),
                                  ExpandableText(
                                    // 'Content: I would say that my parents managed to spend a good amount of time with me during my childhood, especially my mother who was a housewife and stayed at home all the time.',
                                    item.noidungPost,
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
                                isCheckPostNotification: true,
                                iddUser: widget.iddUser,
                                index: index,
                              ),
                            ),
                          ],
                        ),
                        leading: Container(
                            width: widget.size.width * .1,
                            height: 50,
                            decoration:
                                const BoxDecoration(shape: BoxShape.circle),
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
                                  )),
                      ),
                    ),
                  );
                })),
          );
        } else {
          return const Center(child: CircularProgressIndicator());
        }
      },
    );
  }
}
