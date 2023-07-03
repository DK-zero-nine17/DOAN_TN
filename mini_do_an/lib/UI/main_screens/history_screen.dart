import 'package:flutter/material.dart';

import '../../Model/post.dart';
import '../detail_screens/notifi_detail/show_list_about_thing.dart';

class ScreenHiddenPost extends StatefulWidget {
  ScreenHiddenPost({
    super.key,
    required this.size,
    required this.iddUser,
    required this.listHiddenPosts,
  });
  final Size size;
  int iddUser;
  List<Post> listHiddenPosts;

  @override
  State<ScreenHiddenPost> createState() => _ScreenHiddenPostState();
}

class _ScreenHiddenPostState extends State<ScreenHiddenPost> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: Row(
            children: [
              Expanded(
                flex: 1,
                child: InkWell(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Container(
                        margin: EdgeInsets.only(right: 15),
                        height: 40,
                        width: 40,
                        child: Icon(Icons.arrow_back))),
              ),
              const Expanded(
                  flex: 8, child: Text("Danh sách các bài viết đã ẩn")),
            ],
          ),
        ),
        body: Container(
          width: double.infinity,
          height: double.infinity,
          color: Colors.grey.withOpacity(.2),
          child: showListsAboutThing(
            size: widget.size,
            iddUser: widget.iddUser,
            listNotificationSeleted: widget.listHiddenPosts,
            checkStatusOfPost: true,
          ),
        ),
      ),
    );
  }
}
