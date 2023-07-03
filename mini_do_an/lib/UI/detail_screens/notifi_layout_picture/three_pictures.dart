import 'package:flutter/material.dart';
import 'package:mini_do_an/Model/post.dart';
import 'package:mini_do_an/UI/detail_screens/notifi_layout_picture/show_detail_one_image.dart';

import 'detai_after_choose_image.dart';

class ThreePictures extends StatefulWidget {
  ThreePictures({
    Key? key,
    required this.link,
    required this.post,
    required this.iddUser,
  }) : super(key: key);
  List<String> link;
  Post post;
  int iddUser;

  @override
  State<ThreePictures> createState() => _ThreePicturesState();
}

class _ThreePicturesState extends State<ThreePictures> {
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
    return Container(
      height: size.height * .4,
      width: size.width,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: size.height * .4,
            width: size.width * .6 - 20,
            padding: const EdgeInsets.only(right: 1),
            child: InkWell(
              onTap: () {
                //   goPageDetailPicture(0, widget.link);
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
              child: ShowDetailOneImage(item: widget.link[0]),
            ),
          ),
          Container(
            height: size.height * .4,
            width: size.width * .4,
            padding: const EdgeInsets.only(left: 1),
            child: Column(
              children: [
                Container(
                  height: size.height * .2,
                  width: size.width * .4,
                  padding: const EdgeInsets.only(bottom: 1),
                  child: InkWell(
                    onTap: () {
                      //  goPageDetailPicture(1, widget.link);
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => DetailAfterChoose(
                              list: widget.link,
                              index: 1,
                              post: widget.post,
                              iddUser: widget.iddUser,
                            ),
                          ));
                    },
                    child: ShowDetailOneImage(item: widget.link[1]),
                  ),
                ),
                Container(
                  height: size.height * .2,
                  width: size.width * .4,
                  padding: const EdgeInsets.only(top: 1),
                  child: InkWell(
                    onTap: () {
                      // goPageDetailPicture(2, widget.link);
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => DetailAfterChoose(
                              list: widget.link,
                              index: 2,
                              post: widget.post,
                              iddUser: widget.iddUser,
                            ),
                          ));
                    },
                    child: ShowDetailOneImage(item: widget.link[2]),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
