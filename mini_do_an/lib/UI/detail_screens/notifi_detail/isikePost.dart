import 'package:flutter/material.dart';

class IsLikePost extends StatefulWidget {
  IsLikePost({
    super.key,
    required this.id,
    required this.isStatusPost,
    required this.getIsLikePost,
    required this.isCheckPostNotification,
    required this.iddUser,
    required this.index,
  });
  int id;
  int index;
  int? isStatusPost;
  Function getIsLikePost;
  bool isCheckPostNotification;
  int iddUser;
  @override
  State<IsLikePost> createState() => _IsLikePostState();
}

class _IsLikePostState extends State<IsLikePost> {
  late bool isLike;
  @override
  void initState() {
    super.initState();
    print(
        'File islikePost co status cua bai Post ${widget.id} la ${widget.isStatusPost}');
    if (widget.isStatusPost == 1) {
      isLike = true;
    } else {
      isLike = false;
    }
  }

  void ThucHienPostNotify() {
    setState(() {
      isLike = !isLike;
    });
    widget.getIsLikePost(widget.id, isLike, widget.id);
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        widget.isCheckPostNotification
            ? showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    title: const Text("Thông Báo:"),
                    content: const Text(
                        "Bạn có thực sự muốn xóa bài đăng này khỏi thư mục?"),
                    actions: <Widget>[
                      ElevatedButton(
                          onPressed: () {
                            widget.getIsLikePost(
                                widget.index, isLike, widget.id);

                            return Navigator.of(context).pop(true);
                          },
                          child: const Text("OK")),
                      ElevatedButton(
                          onPressed: () {
                            return Navigator.of(context).pop(true);
                          },
                          child: const Text("Cancel")),
                    ],
                  );
                },
              )
            : ThucHienPostNotify();
      },
      child: SizedBox(
        height: 50,
        width: 80,
        child: Icon(
          Icons.star,
          color: isLike ? Colors.yellow : Colors.grey,
        ),
      ),
    );
  }
}
