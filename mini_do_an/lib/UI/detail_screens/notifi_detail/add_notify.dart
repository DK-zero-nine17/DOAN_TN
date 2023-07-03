import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:mini_do_an/Model/post.dart';
import 'package:mini_do_an/UI/detail_screens/notifi_detail/seleted_Image.dart';
import 'package:mini_do_an/api/network_request.dart';
import '../../root.dart';
import 'Item_DropDown.dart';
import 'micVoice.dart';
import 'noti_whensend.dart';

class AddOneNotify extends StatefulWidget {
  AddOneNotify({super.key, required this.iddUser, required this.nameOfUser});
  int iddUser;
  String nameOfUser;
  @override
  State<AddOneNotify> createState() => _AddOneNotifyState();
}

class _AddOneNotifyState extends State<AddOneNotify> {
  //

  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  //

  final TextEditingController _tieudeCtrl = TextEditingController();

  // final TextEditingController _diadiemCtrl = TextEditingController();

  final TextEditingController _noidungCtrl = TextEditingController();

  final List<String> _optionsA = [
    'Nặng',
    'Bình Thường',
    'Nhẹ',
  ];
  final List<String> _optionsB = [
    'Cao',
    'Bình Thường',
    'Thấp',
  ];

  List<String> listDevices = [
    "bàn học",
    "cái ghế",
    "bảng đen",
    "máy chiếu",
    "camera",
    "máy tính",
    "chuột máy tính",
    "bàn phím máy tính",
    "máy lọc nước",
    "cửa chính lớp học",
    "máy quạt",
    "máy lạnh",
    "cửa sổ",
    "đèn học",
    "micro",
  ];
  List<String> listRooms = [
    "phòng 101C2",
    "phòng 102C2",
    "phòng 103C2",
    "phòng 104C2",
    "phòng 105C2",
    "phòng 101E2",
    "phòng 102E2",
    "phòng 103E2",
    "phòng 104E2",
    "phòng 105E2",
    "phòng 101E3",
    "phòng 102E3",
    "phòng 103E3",
    "phòng 104E3",
    "phòng 105E3",
    "phòng 101E4",
    "phòng 102CE4",
    "phòng 103CE4",
    "phòng 104E4",
    "phòng 105E4",
    "phòng 102E5",
    "phòng 202E5",
    "phòng 302E5",
    "phòng 402E5",
    "hội trường C1",
  ];

  String? _valueHuHong;
  String? _valueCanThiet;
  late String _thietbi;
  var _diachi;

  void getValueHuHong(String a) {
    _valueHuHong = a;
    print('muc do hu hong la $_valueHuHong');
  }

  void getValueCanThiet(String b) {
    _valueCanThiet = b;
    print('muc do can thiet la $_valueCanThiet');
  }

  @override
  void initState() {
    super.initState();
    Noti.initialize(flutterLocalNotificationsPlugin);

    // _noidungCtrl = TextEditingController(text: _contentMic);
  }

  final List<String> _listImageSelected = [];
  String pathImage = '';
  void getpathImage(String pathImage) {
    setState(() {
      pathImage = pathImage;
      //////////////////////////////////////////////////////
      _listImageSelected.add(pathImage);
      print('LIST ANH NHAN DUOC LA ${_listImageSelected.toString()}');
    });
  }

  bool addNewPost(BuildContext context) {
    String tieude = _tieudeCtrl.text;
    // String diadiem = _diadiemCtrl.text;
    String noidung = _noidungCtrl.text;
    if (tieude.isEmpty || _diachi == '' || _thietbi == '') {
      return true;
    }
    Post newPost = Post(
        id: 0,
        idUser: widget.iddUser,
        tieudePost: tieude,
        nguoiguiPost: widget.nameOfUser,
        datePost: DateTime.now().toString().substring(0, 19),
        noidungPost: noidung,
        diachi: _diachi,
        mdCanThiet: _valueCanThiet,
        mdHuHong: _valueHuHong,
        thietBi: _thietbi,
        trangThai: 'Chưa duyệt');

    NetworkRequest.postNewPost(newPost, _listImageSelected);

    _tieudeCtrl.clear();
    // _diadiemCtrl.clear();
    _noidungCtrl.clear();

    return false;
  }

  /////////////////////////////////////////

  String _contentMic = '';
  void getInforFromMicVoice(String content) {
    _contentMic = '$_contentMic $content';
    _noidungCtrl.text = _noidungCtrl.text + _contentMic;
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.white,
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                flex: 1,
                child: InkWell(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      width: 30,
                      alignment: Alignment.centerLeft,
                      child: const Icon(
                        Icons.arrow_back_outlined,
                        color: Colors.black,
                      ),
                    )),
              ),
              const Expanded(
                flex: 4,
                child: Text(
                  'Soạn thông báo',
                  style: TextStyle(fontSize: 20, color: Colors.black),
                ),
              ),
              Expanded(
                flex: 2,
                child: SizedBox(
                  width: size.width * .3,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      InkWell(
                        onTap: () {
                          addNewPost(context)
                              ? showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return AlertDialog(
                                      title: const Text("Thông Báo:"),
                                      content: const Text(
                                          "Vui lòng điền đầy đủ thông tin!"),
                                      actions: <Widget>[
                                        ElevatedButton(
                                            onPressed: () =>
                                                Navigator.of(context).pop(true),
                                            child: const Text("OK")),
                                      ],
                                    );
                                  },
                                )
                              : Navigator.push(context,
                                  MaterialPageRoute(builder: ((context) {
                                  Noti.showBigTextNOtification(
                                      title:
                                          'Thông báo về cơ sở vật chất của trường',
                                      body: _tieudeCtrl.text,
                                      fln: flutterLocalNotificationsPlugin);

                                  return RootScreen(
                                    iddUser: widget.iddUser,
                                    nameOfUser: widget.nameOfUser,
                                  );
                                })));
                        },
                        child: Container(
                          width: 30,
                          margin: const EdgeInsets.symmetric(horizontal: 5),
                          child: Image.asset(
                            'assets/icons/send _add.png',
                            fit: BoxFit.contain,
                          ),
                        ),
                      ),
                      // Container(
                      //   width: 20,
                      //   child: Image.asset('assets/icons/menu.png'),
                      // ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
        body: SingleChildScrollView(
            child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  const Text(
                    'Từ: ',
                    style: TextStyle(fontSize: 18),
                  ),
                  const SizedBox(
                    width: 20,
                  ),
                  SizedBox(
                      width: size.width * .7,
                      child: Text(
                        widget.nameOfUser,
                        style: const TextStyle(fontSize: 20),
                      )),
                ],
              ),
            ),
            const Divider(
              thickness: 1,
              height: 1,
            ),
            Container(
              width: size.width,
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              child: TextFormField(
                controller: _tieudeCtrl,
                decoration: const InputDecoration(
                  hintText: 'Tiêu đề',
                  border: UnderlineInputBorder(),
                ),
              ),
            ),
            const Divider(
              thickness: 1,
              height: 1,
            ),
            Container(
              width: size.width,
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              child: Autocomplete<String>(
                initialValue: const TextEditingValue(text: 'phòng'),
                optionsBuilder: (textEditingValue) {
                  if (textEditingValue.text == '') {
                    return const Iterable.empty();
                  }
                  return listRooms.where((element) {
                    return element
                        .contains(textEditingValue.text.toLowerCase());
                  });
                },
                onSelected: (option) {
                  setState(() {
                    if (listRooms.contains(option)) {
                      _diachi = option;
                    } else {
                      _diachi = ''; // Hoặc giá trị mặc định khác
                    }
                  });
                },
              ),

              // TextFormField(
              //   controller: _diadiemCtrl,
              //   decoration: const InputDecoration(
              //     hintText: 'Địa điểm',
              //     border: UnderlineInputBorder(),
              //   ),
              // ),
            ),
            const Divider(
              thickness: 1,
              height: 1,
            ),
            Container(
              width: size.width,
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              child: Row(
                children: [
                  const Expanded(
                    flex: 1,
                    child: Text(
                      'Thiết bị: ',
                      style: TextStyle(fontSize: 16),
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Expanded(
                    flex: 3,
                    child: SizedBox(
                      height: 50,
                      width: 50,
                      child: Autocomplete<String>(
                        initialValue: const TextEditingValue(text: ' '),
                        optionsBuilder: (textEditingValue) {
                          if (textEditingValue.text == '') {
                            return const Iterable.empty();
                          }
                          return listDevices.where((element) {
                            return element
                                .contains(textEditingValue.text.toLowerCase());
                          });
                        },
                        onSelected: (option) {
                          setState(() {
                            if (listDevices.contains(option)) {
                              _thietbi = option;
                            } else {
                              _thietbi = ''; // Hoặc giá trị mặc định khác
                            }
                          });
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const Divider(
              thickness: 1,
              height: 1,
            ),
            Container(
              width: size.width,
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              child: Row(
                children: [
                  const Text(
                    'Mức độ hư hỏng: ',
                    style: TextStyle(fontSize: 16),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  ItemDropDown(
                    listOptions: _optionsA,
                    getValue: getValueHuHong,
                    valueDefault: 'Bình Thường',
                  ),
                ],
              ),
            ),
            const Divider(
              thickness: 1,
              height: 1,
            ),
            Container(
              width: size.width,
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              child: Row(
                children: [
                  const Text(
                    'Mức độ cần thiết: ',
                    style: TextStyle(fontSize: 16),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  ItemDropDown(
                    listOptions: _optionsB,
                    getValue: getValueCanThiet,
                    valueDefault: 'Bình Thường',
                  ),
                ],
              ),
            ),
            const Divider(
              thickness: 1,
              height: 1,
            ),
            Container(
              width: size.width,
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    flex: 6,
                    child: TextFormField(
                      controller: _noidungCtrl,
                      decoration: const InputDecoration(
                        hintText: 'Nội dung',
                        border: UnderlineInputBorder(),
                        hintMaxLines: 3,
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: InkWell(
                      onTap: () {
                        Navigator.push(context, MaterialPageRoute(
                          builder: (context) {
                            return MicPost(
                                getInforFromMicVoice: getInforFromMicVoice);
                          },
                        ));
                      },
                      child: const Icon(
                        Icons.mic,
                        size: 30,
                      ),
                    ),
                  )
                ],
              ),
            ),
            SeletedImageScreen(
              pathImage: getpathImage,
              haveShowImages: true,
              listImageDefault: const [],
            ),
          ],
        )),
      ),
    );
  }
}
