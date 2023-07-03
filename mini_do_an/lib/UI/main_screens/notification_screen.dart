import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import 'package:mini_do_an/UI/detail_screens/notifi_detail/search_bar.dart';
import 'package:mini_do_an/api/network_request.dart';

import '../../Model/post.dart';
import '../detail_screens/notifi_detail/add_notify.dart';
import '../detail_screens/notifi_detail/carouse_slider.dart';
import '../detail_screens/notifi_detail/item_of_notifi.dart';
import '../detail_screens/notifi_detail/show_list_about_thing.dart';

class NotificationScreen extends StatefulWidget {
  NotificationScreen(
      {super.key, required this.iddUser, required this.nameOfUser, re});
  int iddUser;
  String nameOfUser;

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  String title = 'Thông báo:';
  String item1 = 'Thông báo';
  String item2 = 'Thông báo được yêu thích';
  List<Post> listFavoritePosts = [];
  List<Post> listAllThePosts = [];

  @override
  void initState() {
    super.initState();

    NetworkRequest.fetchAllStatusOfPost(widget.iddUser, 1).then((value) {
      setState(() {
        listFavoritePosts = value;
        print('bbbbbbbbbbbbbbbbbbbbbbbb $listFavoritePosts');
      });
    });

    NetworkRequest.fetchAllPostOfSelected(widget.iddUser).then((value) {
      setState(() {
        listAllThePosts = value;
      });
    });
  }

  @override
  void didUpdateWidget(NotificationScreen oldWidget) {
    super.didUpdateWidget(oldWidget);

    NetworkRequest.fetchAllStatusOfPost(widget.iddUser, 1).then((value) {
      setState(() {
        listFavoritePosts = value;
      });
    });

    NetworkRequest.fetchAllPostOfSelected(widget.iddUser).then((value) {
      if (value.isNotEmpty) {
        setState(() {
          listAllThePosts = value;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        toolbarHeight: 0,
        backgroundColor: Colors.white70,
      ),
      body: RefreshIndicator(
        onRefresh: () {
          setState(() {});
          NetworkRequest.fetchAllPostOfSelected(widget.iddUser).then((value) {
            if (value.isNotEmpty) {
              setState(() {
                listAllThePosts = value;
              });
            }
          });
          return Future<void>.delayed(const Duration(seconds: 2));
        },
        child: CustomScrollView(
          physics: const ClampingScrollPhysics(),
          shrinkWrap: true,
          slivers: [
            SliverAppBar(
              backgroundColor: Colors.white,
              // brightness: Brightness.light,
              title: const SizedBox(height: 80),
              floating: true,
              pinned: false,
              snap: false,
              bottom: PreferredSize(
                preferredSize: const Size.fromHeight(0),
                child: SizedBox(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        flex: 1,
                        child: Container(
                          width: size.width * .1,
                          height: 50,
                          margin: const EdgeInsets.only(right: 8, left: 4),
                          decoration:
                              const BoxDecoration(shape: BoxShape.circle),
                          child: const CircleAvatar(
                            backgroundImage:
                                ExactAssetImage('assets/icons/utc2.png'),
                            radius: 50,
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 6,
                        child: InkWell(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      SearchBarPost(iddUser: widget.iddUser),
                                ));
                          },
                          child: Container(
                            height: 40,
                            width: size.width * .6 + 20,
                            padding: const EdgeInsets.symmetric(horizontal: 8),
                            decoration: BoxDecoration(
                                color: Colors.grey.withOpacity(.2),
                                borderRadius: BorderRadius.circular(20)),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                  flex: 5,
                                  child: SizedBox(
                                    height: 35,
                                    width: size.width * .4,
                                    child: TextFormField(
                                        enabled: false,
                                        readOnly: true,
                                        decoration: const InputDecoration(
                                            hintText: 'Tìm kiếm thông tin',
                                            icon: Icon(Icons.search))),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 1,
                        child: SizedBox(
                          width: size.width * .1,
                          child: IconButton(
                            onPressed: (() {}),
                            icon: Icon(
                              Icons.notifications_none_outlined,
                              size: 28,
                              color: Colors.black.withOpacity(.7),
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
            const SliverToBoxAdapter(
              child: Carouse_Slider(),
            ),
            SliverToBoxAdapter(
              child: ListTile(
                title: Text(title),
                trailing: PopupMenuButton(
                  itemBuilder: (context) => [
                    PopupMenuItem(
                      value: item1,
                      child: Text(item1),
                    ),
                    PopupMenuItem(
                      value: item2,
                      child: Text(item2),
                    ),
                  ],
                  onSelected: (value) {
                    setState(() {
                      NetworkRequest.fetchAllPostOfSelected(widget.iddUser)
                          .then((value) {
                        setState(() {
                          listAllThePosts = value;
                        });
                      });

                      NetworkRequest.fetchAllStatusOfPost(widget.iddUser, 1)
                          .then((value) {
                        setState(() {
                          listFavoritePosts = value;
                          print('bbbbbbbbbbbbbbbbbbbbbbbb $listFavoritePosts');
                        });
                      });
                      title = value;
                    });
                  },
                ),
              ),
            ),
            listAllThePosts.isEmpty
                ? SliverToBoxAdapter(
                    child: Center(
                      child: SpinKitCircle(
                        color: Colors.black.withOpacity(.6),
                        size: 50.0,
                      ),
                    ),
                  )
                : SliverToBoxAdapter(
                    child: title != item2
                        ? ItemOfNotifi(
                            iddUser: widget.iddUser,
                            listAllThePosts: listAllThePosts,
                          )
                        : showListsAboutThing(
                            size: size,
                            iddUser: widget.iddUser,
                            listNotificationSeleted: listFavoritePosts,
                            checkStatusOfPost: false,
                          ),
                  ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: ((context) => AddOneNotify(
                      iddUser: widget.iddUser,
                      nameOfUser: widget.nameOfUser))));
        },
        splashColor: Colors.grey,
        elevation: 1,
        hoverColor: Colors.yellow,
        tooltip: 'Add Notification',
        child: const Icon(
          Icons.add,
          size: 30,
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
    );
  }
}
