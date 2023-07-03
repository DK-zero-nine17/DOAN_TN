import 'dart:io';

import 'package:flutter/material.dart';
import 'package:mini_do_an/Model/post.dart';

import 'detai_after_choose_image.dart';

class OnePicture extends StatefulWidget {
  OnePicture({
    Key? key,
    required this.link,
    required this.post,
    required this.iddUser,
  }) : super(key: key);
  List<String> link;
  Post post;
  int iddUser;

  @override
  State<OnePicture> createState() => _OnePictureState();
}

class _OnePictureState extends State<OnePicture> {
  // void goPageDetailPicture(int index, List<String> _listImage) {
  //   showModalBottomSheet<void>(
  //     context: context,
  //     isScrollControlled: true,
  //     shape: const RoundedRectangleBorder(
  //         borderRadius: BorderRadius.only(
  //             topLeft: Radius.circular(30), topRight: Radius.circular(30))),
  //     builder: (BuildContext context) {
  //       return SizedBox(
  //         height: double.infinity,
  //         child: Center(
  //           child: DetailAfterChoose(
  //             list: _listImage,
  //             index: index,
  //           ),
  //         ),
  //       );
  //     },
  //   );
  // }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return InkWell(
      onTap: () {
        //goPageDetailPicture(0, widget.link);
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => DetailAfterChoose(
                list: widget.link,
                index: 0,
                post: widget.post,
                iddUser: widget.iddUser,
              ),
            ));
      },
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 10),
        height: size.height * .3,
        width: size.width,
        child: RegExp('^http').hasMatch(widget.link[0])
            ? Image.network(
                widget.link[0],
                fit: BoxFit.cover,
              )
            : ClipRRect(
                borderRadius: BorderRadius.circular(1.0),
                child: Image.file(
                  File.fromUri(Uri.parse(widget.link[0])),
                  // height: size.height * .3,
                  // width: double.infinity,
                  fit: BoxFit.cover,
                )),
      ),
    );
  }
}
