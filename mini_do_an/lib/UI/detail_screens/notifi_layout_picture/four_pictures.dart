import 'package:flutter/material.dart';
import 'package:mini_do_an/Model/post.dart';

import 'detai_after_choose_image.dart';
import 'show_detail_one_image.dart';

class FourPictures extends StatefulWidget {
  FourPictures({
    Key? key,
    required this.link,
    required this.post,
    required this.iddUser,
  }) : super(key: key);
  List<String> link;
  Post post;
  int iddUser;

  @override
  State<FourPictures> createState() => _FourPicturesState();
}

class _FourPicturesState extends State<FourPictures> {
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
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Expanded(
            flex: 2,
            child: Container(
              height: size.height * .2 + 30,
              child: Row(
                children: [
                  Expanded(
                    flex: 1,
                    child: Padding(
                      padding: const EdgeInsets.only(right: 1),
                      child: InkWell(
                        onTap: () {
                          // goPageDetailPicture(0, widget.link);
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
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            flex: 1,
            child: Container(
              height: size.height * .2 - 30,
              padding: EdgeInsets.only(top: 2),
              child: Row(
                children: [
                  Expanded(
                    flex: 1,
                    child: Container(
                      padding: const EdgeInsets.only(right: 2),
                      height: size.height * .2 - 30,
                      child: InkWell(
                        onTap: () {
                          // goPageDetailPicture(1, widget.link);
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

                        // ),
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: Container(
                      height: size.height * .2 - 30,
                      padding: const EdgeInsets.only(right: 2),
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
                  ),
                  Expanded(
                    flex: 1,
                    child: Container(
                      height: size.height * .2 - 30,
                      child: InkWell(
                        onTap: () {
                          // goPageDetailPicture(3, widget.link);
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => DetailAfterChoose(
                                  list: widget.link,
                                  index: 3,
                                  post: widget.post,
                                  iddUser: widget.iddUser,
                                ),
                              ));
                        },
                        child: ShowDetailOneImage(item: widget.link[3]),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
