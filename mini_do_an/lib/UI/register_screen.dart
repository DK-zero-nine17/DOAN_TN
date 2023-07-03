import 'package:encrypt/encrypt.dart' as enc;
import 'package:flutter/material.dart';
import 'package:mini_do_an/Model/user.dart';
import 'package:mini_do_an/api/network_request.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final TextEditingController _msvCtrl = TextEditingController();
  final TextEditingController _hoCtrl = TextEditingController();
  final TextEditingController _tenCtrl = TextEditingController();
  final TextEditingController _lopCtrl = TextEditingController();
  final TextEditingController _emailCtrl = TextEditingController();
  final TextEditingController _matkhauCtrl = TextEditingController();
  final TextEditingController _mkAgainCtrl = TextEditingController();
  final List<String> _listPassword = [];

  void getValueOfText(BuildContext context) {
    String mssv = _msvCtrl.text;
    String ho = _hoCtrl.text;
    String ten = _tenCtrl.text;
    String lop = _lopCtrl.text;
    String email = _emailCtrl.text;
    String matkhau = _matkhauCtrl.text;
    String confirmPassword = _mkAgainCtrl.text;

    User newUser = User(
        id: 0,
        mssvUser: mssv,
        nameUser: "$ho $ten",
        emailUser: email,
        passwordUser: matkhau,
        lopUser: lop,
        status: 1,
        rule: 3);

    NetworkRequest.register(newUser);
  }

////////////////////////
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      // resizeToAvoidBottomInset: false,
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: SafeArea(
            child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Padding(
                padding: EdgeInsets.only(top: 45, bottom: 20),
                child: Text(
                  'Đăng kí',
                  style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                ),
              ),
              FormSetInfor(size, 'Mã sinh viên', _msvCtrl),
              SizedBox(
                width: size.width * .9,
                child: Row(
                  children: [
                    Expanded(
                      flex: 3,
                      child: Container(
                        height: 50,
                        margin: const EdgeInsets.symmetric(vertical: 10),
                        color: Colors.white.withOpacity(.9),
                        child: TextFormField(
                            controller: _hoCtrl,
                            decoration: const InputDecoration(
                                hintText: 'Họ',
                                labelText: 'Họ',
                                border: OutlineInputBorder())),
                      ),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Expanded(
                      flex: 2,
                      child: Container(
                        height: 50,
                        width: size.width * .3,
                        margin: const EdgeInsets.symmetric(vertical: 10),
                        color: Colors.white.withOpacity(.9),
                        child: TextFormField(
                            controller: _tenCtrl,
                            decoration: const InputDecoration(
                                hintText: 'Tên ',
                                labelText: 'Tên',
                                border: OutlineInputBorder())),
                      ),
                    )
                  ],
                ),
              ),
              FormSetInfor(size, 'Lớp', _lopCtrl),
              FormSetInfor(size, 'Email(Cũng là tên đăng nhập)', _emailCtrl),
              FormSetInfor(size, 'Mật khẩu', _matkhauCtrl),
              FormSetInfor(size, 'Xác nhận lại Mật khẩu', _mkAgainCtrl),
              Container(
                  height: 50,
                  width: size.width * .9,
                  margin: const EdgeInsets.only(top: 20),
                  child: ElevatedButton(
                    onPressed: () {
                      setState(() {
                        getValueOfText(context);
                      });
                      Navigator.pop(context);
                    },
                    style: ElevatedButton.styleFrom(primary: Colors.black),
                    child: const Text(
                      'Đăng kí',
                      style: TextStyle(fontSize: 18),
                    ),
                  )),
              const SizedBox(
                height: 50,
              ),
              Center(
                child: InkWell(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Container(
                    height: 40,
                    width: size.width * .6,
                    color: Colors.transparent,
                    child: const Center(
                      child: Text(
                        'Bạn đã có tài khoản ư?',
                        style: TextStyle(
                            decoration: TextDecoration.underline,
                            color: Colors.blue),
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
        )),
      ),
    );
  }

  Container FormSetInfor(
      Size size, String option, TextEditingController textCtrl) {
    return Container(
      height: 50,
      width: size.width * .9,
      margin: const EdgeInsets.symmetric(vertical: 10),
      color: Colors.white.withOpacity(.9),
      child: TextFormField(
        controller: textCtrl,
        decoration: InputDecoration(
          hintText: option,
          labelText: option,
          border: const OutlineInputBorder(
            borderSide: BorderSide(color: Colors.black),
          ),
        ),
      ),
    );
  }
}
