import 'dart:io';
import 'package:flutter/material.dart';
import 'package:mini_do_an/api/network_request.dart';
import '../../Model/post.dart';
import '../../Model/user.dart';
import '../detail_screens/notifi_detail/hiddenNotifications.dart';
import '../detail_screens/notifi_detail/profileOfMe.dart';
import '../detail_screens/notifi_detail/show_list_about_thing.dart';
import '../login_screen.dart';
import 'history_screen.dart';

class UserScreen extends StatefulWidget {
  UserScreen({super.key, required this.iddUser});
  int iddUser;

  @override
  State<UserScreen> createState() => _UserScreenState();
}

class _UserScreenState extends State<UserScreen> {
  List<String> listImageFromData = [];
  List<Post> listHiddenPosts = [];
//
  String? _pathAvatarUser;
  String? _nameUser;
  String? _mssvUser;
  String? _lopUser;
  String? _sdtUser;

  void getInforFromProfile(
      String path, String name, String mssv, String lop, String sdt) {
    setState(() {
      itemUser.avatarUser = path;
      itemUser.nameUser = name;
      itemUser.mssvUser = mssv;
      itemUser.lopUser = lop;
      itemUser.sdtUser = sdt;
    });

    print(
        'aaaaaaaaaaaaaacac thong tin lay duoc tu trang profile: $_pathAvatarUser, $_lopUser, $_mssvUser, $_sdtUser, $_nameUser');
  }

  User itemUser = User(
      id: 0,
      mssvUser: '',
      nameUser: '',
      emailUser: '',
      passwordUser: '',
      status: 1,
      rule: 3);
  @override
  void initState() {
    super.initState();
    NetworkRequest.fetchOneUser(widget.iddUser).then((value) {
      itemUser = value[0];
      print('aaaaaaaaaaa--------------${value[0]}');
    });

    NetworkRequest.fetchAllStatusOfPost(widget.iddUser, 0).then((value) {
      setState(() {
        listHiddenPosts = value;
        print('jaskjhfkjaskjhfb $listHiddenPosts');
      });
    });
  }

  @override
  void didUpdateWidget(covariant UserScreen oldWidget) {
    // TODO: implement didUpdateWidget
    super.didUpdateWidget(oldWidget);
    NetworkRequest.fetchAllStatusOfPost(widget.iddUser, 0).then((value) {
      setState(() {
        listHiddenPosts = value;
        print('jaskjhfkjaskjhfb $listHiddenPosts');
      });
    });
  }

//
  //final bool _showDetailInforOfMy = false;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 231, 238, 244),
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 6, 53, 92),
        elevation: 0,
        leading: null,
        automaticallyImplyLeading: false,
        title: const Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Trang cá nhân',
              style: TextStyle(fontSize: 20, color: Colors.white),
            ),
            Icon(
              Icons.thunderstorm_rounded,
              color: Colors.white,
            )
          ],
        ),
      ),
      body:
          // User? itemUser = snapshot.data;
          // listImageFromData = itemUser!.avatarUser!.split(',');
          // return
          Stack(children: [
        Positioned(
          top: 0,
          right: 0,
          left: 0,
          child: Container(
            height: size.height * .3 + 50,
            width: size.width,
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(20),
                  bottomRight: Radius.circular(20)),
              color: Color.fromARGB(255, 6, 53, 92),
            ),
          ),
        ),
        // Avatar
        Positioned(
          top: size.height * .1 - 60,
          left: size.width * .1,
          right: size.width * .1,
          child: itemUser.avatarUser != null
              ? Container(
                  height: size.height * .3 - 10,
                  width: size.width * .4 - 10,
                  alignment: Alignment.center,
                  padding: const EdgeInsets.all(5),
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.white,
                  ),
                  child: RegExp('^http').hasMatch('${itemUser.avatarUser}')
                      ? CircleAvatar(
                          backgroundImage:
                              NetworkImage('${itemUser.avatarUser}'),
                          radius: 100,
                        )
                      : ClipRRect(
                          borderRadius: BorderRadius.circular(100),
                          child: Image.file(
                            File.fromUri(Uri.parse('${itemUser.avatarUser}')),
                            height: 200,
                            width: 200,
                            fit: BoxFit.cover,
                          )))
              : Container(
                  width: size.width * .5,
                  padding: const EdgeInsets.all(5),
                  decoration: const BoxDecoration(
                      shape: BoxShape.circle, color: Colors.white),
                  //height: size.height * .5,
                  // margin: EdgeInsets.only(right: 8, left: 4),
                  child: const CircleAvatar(
                    backgroundImage:
                        ExactAssetImage('assets/images/profile2.png'),
                    radius: 100,
                  ),
                ),
        ),
        //Card Information
        Positioned(
          top: size.height * .2 + 50,
          left: 20,
          right: 20,
          child: Card(
              child: Container(
            height: size.height * .2,
            width: size.width,
            padding: const EdgeInsets.only(
              top: 10,
              left: 15,
            ),
            child: Column(children: [
              Row(
                children: [
                  const Icon(Icons.person),
                  Text(
                    itemUser.nameUser,
                    style: const TextStyle(fontSize: 27),
                  )
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              CardInDetailSpecalsInfor('MSSV:', itemUser.mssvUser),
              CardInDetailSpecalsInfor('Lớp:', '${itemUser.lopUser}'),
              CardInDetailSpecalsInfor('SDT:', '${itemUser.sdtUser}'),
            ]),
          )),
        ),
        Positioned(
          top: size.height * .5,
          right: 20,
          left: 20,
          child: InkWell(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => MyProfile(
                        itemUser: itemUser,
                        giveInforToUser: getInforFromProfile),
                  ));
            },
            child: Card(
              child: Container(
                height: 50,
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Icon(Icons.person_outline_outlined),
                        SizedBox(
                          width: 8,
                        ),
                        Text(
                          'Thông tin cá nhân',
                          style: TextStyle(fontSize: 20),
                        ),
                      ],
                    ),
                    Icon(Icons.arrow_forward_ios)
                  ],
                ),
              ),
            ),
          ),
        ),
        Positioned(
          top: size.height * .5 + 70,
          right: 20,
          left: 20,
          child: InkWell(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ScreenHiddenPost(
                      size: size,
                      iddUser: widget.iddUser,
                      listHiddenPosts: listHiddenPosts,
                    ),
                  ));
            },
            child: Card(
              child: Container(
                height: 50,
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Icon(Icons.hide_image_rounded),
                        SizedBox(
                          width: 8,
                        ),
                        Text(
                          'Bài viết đã ẩn',
                          style: TextStyle(fontSize: 20),
                        ),
                      ],
                    ),
                    Icon(Icons.arrow_forward_ios)
                  ],
                ),
              ),
            ),
          ),
        ),
        Positioned(
          top: size.height * .5 + 140,
          right: 20,
          left: 20,
          child: InkWell(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const MyScaffold(),
                  ));
            },
            child: Card(
              child: Container(
                height: 50,
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Icon(Icons.logout_outlined),
                        SizedBox(
                          width: 8,
                        ),
                        Text(
                          'Đăng xuất',
                          style: TextStyle(fontSize: 20),
                        ),
                      ],
                    ),
                    Icon(Icons.arrow_forward_ios)
                  ],
                ),
              ),
            ),
          ),
        )
      ]),

      // FutureBuilder(
      //   future: NetworkRequest.fetchOneUser(widget.iddUser)

      //   builder: (context, AsyncSnapshot<List<User>> snapshot) {
      //     if (snapshot.hasData) {

      //     } else {
      //       return Center(child: CircularProgressIndicator());
      //     }
      //   },
      // ),
    );
  }

  Row CardInDetailSpecalsInfor(String _nameText, String _detailName) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          flex: 1,
          child: Container(
            height: 25,
            child: Text(
              _nameText,
              style: TextStyle(fontSize: 20),
            ),
          ),
        ),
        Expanded(
          flex: 3,
          child: SizedBox(
            height: 25,
            child: Text(
              _detailName,
              style: const TextStyle(fontSize: 20),
            ),
          ),
        ),
      ],
    );
  }
}
