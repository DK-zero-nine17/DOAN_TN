import 'dart:io';
import 'package:flutter/material.dart';
import 'package:mini_do_an/api/network_request.dart';
import '../../../Model/user.dart';
import 'my_profile_detail.dart';
import 'seleted_Image.dart';

class MyProfile extends StatefulWidget {
  MyProfile({super.key, required this.itemUser, required this.giveInforToUser});
  User itemUser;
  Function giveInforToUser;
  @override
  State<MyProfile> createState() => _MyProfileState();
}

class _MyProfileState extends State<MyProfile> {
  final List<String> _listImageSelected = [];
  String pathImage = '';
  void getpathImage(String pathImage1) {
    setState(() {
      pathImage = pathImage1;
      //////////////////////////////////////////////////////
      _listImageSelected.add(pathImage);
      print('LIST ANH NHAN DUOC LA ${_listImageSelected.toString()}');
    });
  }

  late TextEditingController _nameCtrl;
  late TextEditingController _emailCtrl;
  late TextEditingController _lopCtrl;
  late TextEditingController _sdtCtrl;
  late TextEditingController _dateCtrl;
  late TextEditingController _diachiCtrl;
  late TextEditingController _mssvCtrl;

  late String upName;
  late String upMSSV;
  late String upEmail;
  late String upLop;
  late String upSDT;
  late String upDate;
  late String upDiaChi;
  @override
  void initState() {
    super.initState();
    _nameCtrl = TextEditingController(text: widget.itemUser.nameUser);
    _mssvCtrl = TextEditingController(text: widget.itemUser.mssvUser);
    _emailCtrl = TextEditingController(text: widget.itemUser.emailUser);
    _lopCtrl = TextEditingController(text: '${widget.itemUser.lopUser}');
    _sdtCtrl = TextEditingController(text: '${widget.itemUser.sdtUser}');
    _dateCtrl = TextEditingController(text: '${widget.itemUser..dateUser}');
    _diachiCtrl = TextEditingController(text: '${widget.itemUser.diachiUser}');
    pathImage = '${widget.itemUser.avatarUser}';

    upName = widget.itemUser.nameUser;
    upMSSV = widget.itemUser.mssvUser;
    upEmail = widget.itemUser.emailUser;
    upLop = '${widget.itemUser.lopUser}';
    upSDT = '${widget.itemUser.sdtUser}';
    upDate = '${widget.itemUser.dateUser}';
    upDiaChi = '${widget.itemUser.diachiUser}';
  }

  bool _editName = false;
  bool _editMSSV = false;
  bool _editEmail = false;
  bool _editLop = false;
  bool _editSDT = false;
  bool _editDate = false;
  bool _editDiaChi = false;

  void getpathImageAvatar(String pathImage1) {
    print('link anh update Avatar User la $pathImage1');
    setState(() {
      pathImage = pathImage1;
    });
  }

  String getChangeOfName(String upName1) {
    upName = upName1;
    return upName;
  }

  String getChangeOfMSSV(String upMSSV1) {
    upMSSV = upMSSV1;
    return upMSSV;
  }

  String getChangeOfEmail(String upEmail1) {
    upEmail = upEmail1;
    return upEmail;
  }

  String getChangeOfLop(String upLop1) {
    upLop = upLop1;
    return upLop;
  }

  String getChangeOfSDT(String upSDT1) {
    upSDT = upSDT1;
    return upSDT;
  }

  String getChangeOfDate(String upDate1) {
    upDate = upDate1;
    return upDate;
  }

  String getChangeOfDiaChi(String upDiaChi1) {
    upDiaChi = upDiaChi1;
    return upDiaChi;
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
          title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Text(
            'Trang cá nhân',
            style: TextStyle(fontSize: 20),
          ),
          InkWell(
              onTap: () {
                User newUser = User(
                    id: widget.itemUser.id,
                    mssvUser: upMSSV,
                    nameUser: upName,
                    emailUser: widget.itemUser.emailUser,
                    lopUser: upLop,
                    sdtUser: upSDT,
                    dateUser: upDate,
                    diachiUser: upDiaChi,
                    avatarUser: pathImage,
                    passwordUser: widget.itemUser.passwordUser,
                    status: 1,
                    rule: 3);

                print(
                    "${newUser.id} + ${newUser.emailUser} + ${newUser.dateUser}");

                NetworkRequest.putUser(newUser);

                widget.giveInforToUser(pathImage, upName, upMSSV, upLop, upSDT);

                setState(() {
                  _editName = false;
                  _editMSSV = false;
                  _editEmail = false;
                  _editLop = false;
                  _editSDT = false;
                  _editDate = false;
                  _editDiaChi = false;
                });
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: const Text("Thông Báo:"),
                      content: const Text("Đã cập nhật thông tin thành công"),
                      actions: <Widget>[
                        ElevatedButton(
                            onPressed: () => Navigator.of(context).pop(true),
                            child: const Text("OK")),
                      ],
                    );
                  },
                );
              },
              child: const Text('Lưu', style: TextStyle(fontSize: 20)))
        ],
      )),
      backgroundColor: const Color.fromARGB(255, 239, 242, 244),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              pathImage != ''
                  ? Stack(
                      alignment: AlignmentDirectional.center,
                      children: [
                        Container(
                          width: size.width * .5,
                          padding: const EdgeInsets.all(5),
                          decoration: const BoxDecoration(
                              shape: BoxShape.circle, color: Colors.white),
                          child: Container(
                            margin: const EdgeInsets.symmetric(vertical: 10),
                            height: 168,
                            width: 176,
                            decoration:
                                const BoxDecoration(shape: BoxShape.circle),
                            child: RegExp('^http').hasMatch(pathImage)
                                ? CircleAvatar(
                                    backgroundImage: NetworkImage(pathImage),
                                    radius: 100,
                                  )
                                : ClipRRect(
                                    borderRadius: BorderRadius.circular(80),
                                    child: Image.file(
                                      File.fromUri(Uri.parse(pathImage)),
                                      // height: size.height * .3,
                                      // width: double.infinity,
                                      fit: BoxFit.cover,
                                    )),
                          ),
                        ),
                        Positioned(
                          right: 0,
                          bottom: 30,
                          child: SeletedImageScreen(
                            pathImage: getpathImageAvatar,
                            haveShowImages: false,
                            listImageDefault: const [],
                          ),
                        ),
                      ],
                    )
                  : Stack(
                      alignment: AlignmentDirectional.center,
                      children: [
                        Container(
                          width: size.width * .5,
                          padding: const EdgeInsets.all(5),
                          decoration: const BoxDecoration(
                              shape: BoxShape.circle, color: Colors.white),
                          child: CircleAvatar(
                            // backgroundImage:
                            //     ExactAssetImage('assets/images/person12.png'),
                            radius: 100,
                            backgroundColor: Colors.grey,
                            // backgroundImage:
                            //     ExactAssetImage('assets/images/person12.png'),
                            child: Image.asset(
                              'assets/images/person12.png',
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        Positioned(
                          right: 0,
                          bottom: 30,
                          child: SeletedImageScreen(
                            pathImage: getpathImageAvatar,
                            haveShowImages: false,
                            listImageDefault: const [],
                          ),
                        ),
                      ],
                    ),
              DetailRowProfileInfo(
                lableText: 'Họ Tên:',
                textCtrl: _nameCtrl,
                valueInitState: widget.itemUser.nameUser,
                editBool: _editName,
                getChangeOfObj: getChangeOfName,
                editInfor: false,
              ),
              const Divider(
                height: 2,
                thickness: 1,
              ),
              DetailRowProfileInfo(
                lableText: 'MSSV:',
                textCtrl: _mssvCtrl,
                valueInitState: widget.itemUser.mssvUser,
                editBool: _editMSSV,
                getChangeOfObj: getChangeOfMSSV,
                editInfor: false, //// nghi cach bo cay but sau khi luu
              ),
              const Divider(
                height: 2,
                thickness: 1,
              ),
              DetailRowProfileInfo(
                lableText: 'Lớp:',
                textCtrl: _lopCtrl,
                valueInitState: '${widget.itemUser.lopUser}',
                editBool: _editLop,
                getChangeOfObj: getChangeOfLop,
                editInfor: false,
              ),
              const Divider(
                height: 2,
                thickness: 1,
              ),
              DetailRowProfileInfo(
                lableText: 'Email:',
                textCtrl: _emailCtrl,
                valueInitState: widget.itemUser.emailUser,
                editBool: _editEmail,
                getChangeOfObj: getChangeOfEmail,
                editInfor: false,
              ),
              const Divider(
                height: 2,
                thickness: 1,
              ),
              DetailRowProfileInfo(
                lableText: 'SĐT:',
                textCtrl: _sdtCtrl,
                valueInitState: '${widget.itemUser.sdtUser}',
                editBool: _editSDT,
                getChangeOfObj: getChangeOfSDT,
                editInfor: false,
              ),
              const Divider(
                height: 2,
                thickness: 1,
              ),
              DetailRowProfileInfo(
                lableText: 'Ngày sinh:',
                textCtrl: _dateCtrl,
                valueInitState: '${widget.itemUser.dateUser}',
                editBool: _editDate,
                getChangeOfObj: getChangeOfDate,
                editInfor: false,
              ),
              const Divider(
                height: 2,
                thickness: 1,
              ),
              DetailRowProfileInfo(
                lableText: 'Địa chỉ:',
                textCtrl: _diachiCtrl,
                valueInitState: '${widget.itemUser.diachiUser}',
                editBool: _editDiaChi,
                getChangeOfObj: getChangeOfDiaChi,
                editInfor: false,
              ),
              const Divider(
                height: 2,
                thickness: 1,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
