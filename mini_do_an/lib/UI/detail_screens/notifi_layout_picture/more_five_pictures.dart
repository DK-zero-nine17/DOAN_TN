import 'dart:io';

import 'package:flutter/material.dart';
import 'package:mini_do_an/Model/post.dart';

import 'detai_after_choose_image.dart';
import 'show_detail_one_image.dart';

class MoreFivePictures extends StatefulWidget {
  MoreFivePictures({
    Key? key,
    required this.link,
    required this.post,
    required this.iddUser,
  }) : super(key: key);
  List<String> link;
  Post post;
  int iddUser;

  @override
  State<MoreFivePictures> createState() => _MoreFivePicturesState();
}

class _MoreFivePicturesState extends State<MoreFivePictures> {
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
  void didUpdateWidget(covariant MoreFivePictures oldWidget) {
    // TODO: implement didUpdateWidget
    super.didUpdateWidget(oldWidget);
    setState(() {
      // Link = link;
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    print("daiiiiiiiiiiiiiiiiiiiii ${widget.link.length}");
    return Container(
      height: size.height * .4,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Expanded(
            flex: 2,
            child: SizedBox(
              height: size.height * .2 + 40,
              child: Row(
                children: [
                  Expanded(
                    flex: 1,
                    child: Container(
                      padding: const EdgeInsets.only(right: 1),
                      height: size.height * .2 + 50,
                      child: InkWell(
                        onTap: () {
                          //  goPageDetailPicture(0, widget.link);
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
                  Expanded(
                    flex: 1,
                    child: Container(
                      padding: const EdgeInsets.only(left: 1),
                      height: size.height * .2 + 50,
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
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          const Divider(
            height: 2,
          ),
          Expanded(
            flex: 1,
            child: SizedBox(
              height: size.height * .2 - 10,
              // padding: EdgeInsets.only(top: 2),
              child: Row(
                children: [
                  Expanded(
                    flex: 1,
                    child: Container(
                      height: size.height * .2 - 10,
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

                        // ),
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: Container(
                      height: size.height * .2 - 10,
                      padding: const EdgeInsets.only(right: 2),
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
                  Expanded(
                    flex: 1,
                    child: InkWell(
                      onTap: () {
                        // goPageDetailPicture(4, widget.link);
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => DetailAfterChoose(
                                list: widget.link,
                                index: 4,
                                post: widget.post,
                                iddUser: widget.iddUser,
                              ),
                            ));
                      },
                      child: Container(
                        child: Stack(
                          children: [
                            Container(
                              height: size.height * .2 - 10,
                              width: 200,
                              child: ShowDetailOneImage(item: widget.link[4]),
                            ),
                            Center(
                              child: Text(
                                '+ ${widget.link.length - 4}',
                                style: const TextStyle(
                                    fontSize: 30,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white),
                              ),
                            )
                          ],
                        ),
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
