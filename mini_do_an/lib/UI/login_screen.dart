import 'package:flutter/material.dart';
import 'package:mini_do_an/UI/register_screen.dart';
import 'package:mini_do_an/UI/root.dart';
import 'package:mini_do_an/api/network_request.dart';

class MyScaffold extends StatefulWidget {
  const MyScaffold({
    Key? key,
  }) : super(key: key);

  @override
  State<MyScaffold> createState() => _MyScaffoldState();
}

class _MyScaffoldState extends State<MyScaffold> {
  List<String> textList = [
    '/data/user/0/com.example.mini_do_an/cache/scaled_0d8f6ca2-8f6c-4c69-8f82-4a07e2090ee22703743945831963982.jpg',
    '/data/user/0/com.example.mini_do_an/cache/scaled_196eb375-a77d-4f18-8287-3a7ddb12dbe54779655889803623962.jpg',
  ];

  ///

  ///

  final TextEditingController _userNameCtrl = TextEditingController();
  final TextEditingController _passWordCtrl = TextEditingController();
  bool _showPass = true;
  bool _invalidUser = false;
  bool _innvalidPass = false;

  bool getValueUserPass(BuildContext context) {
    String _valueUser = _userNameCtrl.text;
    String _valuePass = _passWordCtrl.text;
    bool check = true;
    setState(() {
      if (_valueUser.length > 6 && _valueUser.contains('@')) {
        _invalidUser = false;
      } else {
        _invalidUser = true;
        check = false;
      }
      if (_valuePass.length >= 6) {
        _innvalidPass = false;
      } else {
        _innvalidPass = true;
        check = false;
      }
    });
    return check;
  }

  void chageShowPassword() {
    setState(() {
      _showPass = !_showPass;
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.white.withOpacity(.9),
      //resizeToAvoidBottomInset: false,
      body: SingleChildScrollView(
        child: SafeArea(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  margin: const EdgeInsets.only(top: 60, bottom: 15),
                  child: Image.asset(
                    'assets/icons/logoUtc2.png',
                    fit: BoxFit.scaleDown,
                    width: 150,
                  ),
                ),
                const Text(
                  'Welcome back ',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                const SizedBox(
                  height: 25,
                ),
                Container(
                  height: 50,
                  width: size.width * .9,
                  color: Colors.white.withOpacity(.9),
                  child: TextField(
                      controller: _userNameCtrl,
                      decoration: const InputDecoration(
                        labelText: "Email",
                        hintText: 'Email',
                        border: OutlineInputBorder(),
                      )),
                ),
                !_invalidUser
                    ? const SizedBox(height: 10)
                    : const Text(
                        '"Tên đăng nhập không hợp lệ, vui lòng kiểm tra lại."',
                        style: TextStyle(color: Colors.red),
                      ),
                Stack(
                  alignment: AlignmentDirectional.centerEnd,
                  children: [
                    Container(
                      height: 50,
                      width: size.width * .9,
                      margin: const EdgeInsets.symmetric(vertical: 10),
                      color: Colors.white.withOpacity(.9),
                      child: TextFormField(
                        controller: _passWordCtrl,
                        obscureText: _showPass,
                        decoration: const InputDecoration(
                          labelText: 'Mật khẩu',
                          hintText: 'Mật khẩu',
                          border: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.black),
                          ),
                        ),
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(right: 10),
                      child: GestureDetector(
                          onTap: (() => chageShowPassword()),
                          child: _showPass
                              ? Image.asset('assets/icons/private.png',
                                  color: Colors.grey.withOpacity(.6), width: 25)
                              : Icon(
                                  Icons.remove_red_eye_outlined,
                                  color: Colors.black.withOpacity(.6),
                                  size: 25,
                                )),
                    ),
                  ],
                ),
                !_innvalidPass
                    ? const SizedBox(height: 10)
                    : const Text(
                        '"Mật khẩu không hợp lệ, vui lòng kiểm tra lại."',
                        style: TextStyle(color: Colors.red),
                      ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    InkWell(
                      onTap: () {},
                      child: const Padding(
                        padding: EdgeInsets.only(right: 20),
                        child: Text(
                          'Quên mật khẩu?',
                          style:
                              TextStyle(decoration: TextDecoration.underline),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 30,
                ),
                Container(
                    height: 50,
                    width: size.width * .9,
                    child: ElevatedButton(
                      onPressed: (() {
                        /////////////////////////////
                        // Navigator.push(context,
                        //     MaterialPageRoute(builder: ((context) {
                        //   return RootScreen(
                        //     iddUser: 3,
                        //     nameOfUser: "Rom",
                        //   );
                        // })));
                        if (getValueUserPass(context)) {
                          NetworkRequest.login(
                                  _userNameCtrl.text, _passWordCtrl.text)
                              .then((value) => {
                                    if (value.id != -1)
                                      {
                                        Navigator.push(context,
                                            MaterialPageRoute(
                                                builder: ((context) {
                                          return RootScreen(
                                            iddUser: value.id,
                                            nameOfUser: value.nameUser,
                                          );
                                        })))
                                      }
                                    else if (value.emailUser.isEmpty)
                                      {
                                        showDialog(
                                          context: context,
                                          builder: (BuildContext context) {
                                            return AlertDialog(
                                              title: Text("Thông báo:"),
                                              content: Container(
                                                height: size.height * .1 - 20,
                                                width: size.width,
                                                child: const Text(
                                                  "Tên đăng nhập không tồn tại.\nVui lòng nhập kiểm tra lại!",
                                                  style:
                                                      TextStyle(fontSize: 15),
                                                ),
                                              ),
                                              actions: [
                                                ElevatedButton(
                                                  child: Text('OK'),
                                                  onPressed: () {
                                                    Navigator.pop(context);
                                                  },
                                                ),
                                              ],
                                            );
                                          },
                                        )
                                      }
                                    else if (value.status == 0)
                                      {
                                        showDialog(
                                          context: context,
                                          builder: (BuildContext context) {
                                            return AlertDialog(
                                              title: Text("Thông báo:"),
                                              content: Container(
                                                height: size.height * .1 - 20,
                                                width: size.width,
                                                child: const Text(
                                                  "Tài khoản đã bị khóa.\nVui lòng liên hệ với Admin để biết thêm chi tiết!",
                                                  style:
                                                      TextStyle(fontSize: 15),
                                                ),
                                              ),
                                              actions: [
                                                ElevatedButton(
                                                  child: Text('OK'),
                                                  onPressed: () {
                                                    Navigator.pop(context);
                                                  },
                                                ),
                                              ],
                                            );
                                          },
                                        )
                                      }
                                    else
                                      {
                                        showDialog(
                                          context: context,
                                          builder: (BuildContext context) {
                                            return AlertDialog(
                                              title: Text("Thông báo:"),
                                              content: Container(
                                                height: size.height * .1 - 20,
                                                width: size.width,
                                                child: const Text(
                                                  "Mật khẩu không chính xác.\nVui lòng kiểm tra lại thông tin!",
                                                  style:
                                                      TextStyle(fontSize: 15),
                                                ),
                                              ),
                                              actions: [
                                                ElevatedButton(
                                                  child: Text('OK'),
                                                  onPressed: () {
                                                    Navigator.pop(context);
                                                  },
                                                ),
                                              ],
                                            );
                                          },
                                        )
                                      }
                                  });
                        }
                      }),
                      style: ElevatedButton.styleFrom(primary: Colors.black),
                      child: const Text(
                        'Đăng nhập',
                        style: TextStyle(fontSize: 18),
                      ),
                    )),
                const SizedBox(
                  height: 40,
                ),

                // Row(
                //   mainAxisAlignment: MainAxisAlignment.center,
                //   children: [
                //     Container(
                //       width: size.width * .3,
                //       child: Divider(
                //         height: 1,
                //         thickness: 1,
                //       ),
                //     ),
                //     Text(
                //       'Or continue with',
                //       style: TextStyle(color: Colors.black.withOpacity(.6)),
                //     ),
                //     Container(
                //       width: size.width * .3,
                //       child: Divider(
                //         height: 1,
                //         thickness: 1,
                //       ),
                //     ),
                //   ],
                // ),
                // SizedBox(
                //   height: 30,
                // ),
                // Row(
                //   mainAxisAlignment: MainAxisAlignment.center,
                //   children: [
                //     Container(
                //       height: 60,
                //       child: Image.asset(
                //         'assets/icons/google.png',
                //         fit: BoxFit.cover,
                //       ),
                //       decoration: BoxDecoration(
                //           borderRadius: BorderRadius.circular(10),
                //           color: Colors.white),
                //       padding: EdgeInsets.all(10),
                //     ),
                //     SizedBox(
                //       width: 20,
                //     ),
                //     Container(
                //       height: 60,
                //       child: Image.asset('assets/icons/apple-logo.png'),
                //       decoration: BoxDecoration(
                //           borderRadius: BorderRadius.circular(10),
                //           color: Colors.white),
                //       padding: EdgeInsets.all(10),
                //     ),
//   ],
                // ),

                const SizedBox(
                  height: 65,
                ),
                Center(
                  child: InkWell(
                    onTap: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: ((context) {
                        return const RegisterScreen();
                      })));
                    },
                    child: Container(
                      height: 50,
                      width: size.width * .6,
                      decoration: BoxDecoration(
                        color: Colors.transparent,
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: const Center(
                        child: Text(
                          'Tạo tài khoản mới',
                          style: TextStyle(
                              color: Colors.black,
                              decoration: TextDecoration.underline),
                        ),
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
