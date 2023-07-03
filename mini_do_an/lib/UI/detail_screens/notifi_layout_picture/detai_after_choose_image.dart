import 'dart:io';
import 'package:flutter/material.dart';
import 'package:mini_do_an/Model/post.dart';
import 'package:mini_do_an/UI/detail_screens/notifi_detail/detail_of_item_notifi.dart';

import 'show_detail_one_image.dart';

class DetailAfterChoose extends StatefulWidget {
  DetailAfterChoose({
    super.key,
    required this.list,
    required this.index,
    required this.post,
    required this.iddUser,
  });
  List<String> list;
  final int index;
  Post post;
  int iddUser;

  @override
  State<DetailAfterChoose> createState() => _DetailAfterChooseState();
}

class _DetailAfterChooseState extends State<DetailAfterChoose> {
  final PageController _pageController = PageController(initialPage: 0);

  int currentIndex = 0;

// this function help me get into Page That I want to show
  @override
  void didChangeDependencies() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_pageController.hasClients) _pageController.jumpToPage(widget.index);
    });

    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(children: [
        PageView(
          controller: _pageController,
          onPageChanged: (value) {
            currentIndex = value;
          },
          children: widget.list
              .map(
                (item) => Container(
                  height: size.height,
                  width: size.width,
                  margin: const EdgeInsets.only(top: 120, bottom: 100),
                  child: InteractiveViewer(
                    child: RegExp('^http').hasMatch(item)
                        ? Image.network(
                            item,
                            fit: BoxFit.cover,
                          )
                        : ClipRRect(
                            // borderRadius: BorderRadius.circular(10.0),
                            child: Image.file(
                            File.fromUri(Uri.parse(item)),
                            // height: 300.0,
                            // width: double.infinity,
                            fit: BoxFit.cover,
                          )),
                  ),
                ),
              )
              .toList(),
        ),
        SizedBox(
          height: 100,
          width: size.width,
          child: Positioned(
            top: 50,
            left: 0,
            width: double.infinity,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                InkWell(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Container(
                    height: 70,
                    width: 60,
                    alignment: Alignment.centerLeft,
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    margin: const EdgeInsets.only(top: 50),
                    child: const Icon(
                      Icons.arrow_back,
                      color: Colors.white,
                      size: 35,
                    ),
                  ),
                ),
                widget.iddUser == -1 || widget.iddUser != widget.post.idUser
                    ? const SizedBox(
                        width: 5,
                      )
                    : InkWell(
                        onTap: () {
                          print('vi tri cua a ${widget.list[currentIndex]}');
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => DetailItemOfNotify(
                                    newPost: widget.post,
                                    iddUser: widget.iddUser,
                                    urlDeleteImage: widget.list[currentIndex]),
                              ));
                        },
                        child: Container(
                          height: 70,
                          width: 60,
                          alignment: Alignment.centerLeft,
                          padding: const EdgeInsets.symmetric(horizontal: 8),
                          margin: const EdgeInsets.only(top: 50),
                          child: const Icon(
                            Icons.delete_rounded,
                            color: Colors.white,
                            size: 35,
                          ),
                        ),
                      ),
              ],
            ),
          ),
        ),
      ]),
    );
  }
}
