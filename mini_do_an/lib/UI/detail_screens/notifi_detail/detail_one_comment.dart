import 'package:expandable_text/expandable_text.dart';
import 'package:flutter/material.dart';
import 'package:mini_do_an/Model/comment.dart';
import 'package:mini_do_an/api/network_request.dart';

class DetailOfComment extends StatefulWidget {
  DetailOfComment({
    super.key,
    required this.idPosts,
    required this.iddUser,
    required this.listComments,
    required this.avatarUser,
    required this.nameUser,
  });
  int idPosts;
  int iddUser;
  List<Comment> listComments;
  String avatarUser;
  String nameUser;

  @override
  State<DetailOfComment> createState() => _DetailOfCommentState();
}

class _DetailOfCommentState extends State<DetailOfComment> {
  final TextEditingController _commentCtrl = TextEditingController();
  late final FocusNode _focusNode = FocusNode();
  bool checkUserSend = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  void addComment(BuildContext context) {
    String dataComment = _commentCtrl.text;

    if (dataComment.isEmpty) {
      return;
    }

    Comment newComment = Comment(
      id: 0,
      idPost: widget.idPosts,
      idUser: widget.iddUser,
      dateComment: DateTime.now().toString().substring(0, 19),
      noidungComment: dataComment,
      nguoiComment: widget.nameUser,
      avatar: widget.avatarUser,
      isAnDanh: checkUserSend ? 1 : 0,
    );
    widget.listComments.add(newComment);
    //////////////////////////////////////////////////////////////////////////////////
    NetworkRequest.postNewComment(newComment);
    ////////////////////////////////////////////////////////////////////////////////////
    _commentCtrl.clear();
    _focusNode.unfocus();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

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

    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: SizedBox(
        height: size.height,
        width: size.width,
        child: Stack(
          children: [
            Positioned(
              top: 0,
              left: 0,
              right: 0,
              child: SizedBox(
                height: size.height,
                width: size.width,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    InkWell(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Container(
                        height: 40,
                        width: size.width,
                        alignment: Alignment.centerLeft,
                        padding: const EdgeInsets.symmetric(horizontal: 8),
                        child: const Icon(
                          Icons.arrow_back,
                          size: 35,
                        ),
                      ),
                    ),
                    const Divider(
                      height: 1,
                      thickness: 2,
                    ),
                    Container(
                      height: size.height * .9,
                      width: size.width,
                      padding: const EdgeInsets.only(bottom: 50),
                      child: ListView.builder(
                        itemCount: widget.listComments.length,
                        itemBuilder: (context, index) {
                          var comment = widget.listComments[index];

                          return ListTile(
                            title: Card(
                              color: const Color.fromARGB(236, 241, 240, 240),
                              child: Container(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 10, vertical: 10),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Text(
                                          comment.isAnDanh == 1
                                              ? "Ẩn danh"
                                              : comment
                                                  .nguoiComment!, // tac gia cua bai viet
                                          style: const TextStyle(
                                              fontSize: 17,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.black),
                                        ),
                                        Text(
                                          formattedDateTime(
                                              comment.dateComment),
                                          style: TextStyle(
                                            fontSize: 15,
                                            color: const Color.fromARGB(
                                                    255, 57, 55, 55)
                                                .withOpacity(.8),
                                          ),
                                        ),
                                      ],
                                    ),
                                    ExpandableText(
                                      comment.noidungComment,
                                      expandText: '',
                                      expandOnTextTap: true,
                                      collapseOnTextTap: true,
                                      animation: true,
                                      maxLines: 2,
                                      linkColor: Colors.black,
                                      style: const TextStyle(
                                          fontSize: 16, color: Colors.black),
                                      //textAlign: TextAlign.justify,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            leading: comment.isAnDanh == 1
                                ? const CircleAvatar(
                                    backgroundColor: Colors.grey,
                                    backgroundImage:
                                        AssetImage('assets/images/avt.png'),
                                    radius: 24,
                                  )
                                : Container(
                                    height: 45,
                                    width: 45,
                                    decoration: const BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: Colors.amber),
                                    child: CircleAvatar(
                                      backgroundImage: NetworkImage(
                                        comment.avatar!,
                                      ),
                                      radius: 50,
                                    ),
                                  ),
                          );
                        },
                      ),
                    )
                  ],
                ),
              ),
            ),
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Container(
                height: 50,
                width: size.width - 10,
                color: Colors.white,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Expanded(
                      flex: 1,
                      child: InkWell(
                          onTap: () {
                            setState(() {
                              checkUserSend = !checkUserSend;
                            });
                            print('object');
                          },
                          child: checkUserSend
                              ? Container(
                                  width: size.width * .1,
                                  height: 50,
                                  margin:
                                      const EdgeInsets.only(right: 8, left: 8),
                                  child: Stack(
                                    children: [
                                      const CircleAvatar(
                                        backgroundImage: ExactAssetImage(
                                            'assets/images/avt.png',
                                            scale: 1),
                                        radius: 40,
                                      ),
                                      Positioned(
                                        bottom: 0,
                                        right: 1,
                                        child: Container(
                                          height: 15,
                                          width: 15,
                                          alignment: Alignment.topLeft,
                                          decoration: const BoxDecoration(
                                              shape: BoxShape.circle,
                                              color: Colors.grey),
                                          child: const Icon(
                                            Icons
                                                .arrow_drop_down_circle_outlined,
                                            color: Colors.black,
                                            size: 15,
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                )
                              : Container(
                                  width: size.width * .1,
                                  height: 50,
                                  margin:
                                      const EdgeInsets.only(right: 8, left: 8),
                                  child: Stack(
                                    children: [
                                      CircleAvatar(
                                        backgroundImage: NetworkImage(
                                          widget.avatarUser ??
                                              'https://res.cloudinary.com/dkjd3g6t3/image/upload/v1687353508/DACN/Assets/avt-df_ztd19q.jpg',
                                        ),
                                        radius: 50,
                                      ),
                                      Positioned(
                                        bottom: 0,
                                        right: 2,
                                        child: Container(
                                          //  padding: EdgeInsets.only(bottom: 8),
                                          height: 15,
                                          width: 15,
                                          alignment: Alignment.topLeft,
                                          decoration: const BoxDecoration(
                                              shape: BoxShape.circle,
                                              color: Colors.grey),
                                          child: const Icon(
                                            Icons
                                                .arrow_drop_down_circle_outlined,
                                            color: Colors.black,
                                            size: 15,
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                )),
                    ),
                    Expanded(
                      flex: 5,
                      child: Container(
                        height: 40,
                        width: size.width * .7,
                        padding: const EdgeInsets.symmetric(horizontal: 5),
                        decoration: BoxDecoration(
                          color: Colors.grey.withOpacity(.2),
                          borderRadius: BorderRadius.circular(25),
                        ),
                        child: TextFormField(
                            controller: _commentCtrl,
                            //  focusNode: _focusNode,
                            decoration: checkUserSend
                                ? const InputDecoration(
                                    hintText: 'Bình luận dưới dạng ẩn danh...',
                                  )
                                : const InputDecoration(
                                    hintText: 'Nhập bình luận...',
                                  )),
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: IconButton(
                          onPressed: (() {
                            setState(() {
                              // add Comment
                              addComment(context);
                            });
                          }),
                          icon: Image.asset('assets/icons/right-arrow.png')),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
