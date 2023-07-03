import 'package:flutter/material.dart';

class DetailRowProfileInfo extends StatefulWidget {
  DetailRowProfileInfo({
    super.key,
    required this.lableText,
    required this.textCtrl,
    required this.valueInitState,
    required this.editBool,
    required this.getChangeOfObj,
    required this.editInfor,
  });

  String lableText;
  TextEditingController textCtrl;
  String valueInitState;
  bool editBool;
  bool editInfor;
  Function getChangeOfObj;
  @override
  State<DetailRowProfileInfo> createState() => _DetailRowProfileInfoState();
}

class _DetailRowProfileInfoState extends State<DetailRowProfileInfo> {
  bool? editInfor;
  String? _name;

  @override
  void initState() {
    super.initState();
    _name = widget.valueInitState;
    editInfor = widget.editInfor;
  }

  void getInfor(BuildContext context) {
    String infor = widget.textCtrl.text;
    widget.getChangeOfObj(infor);
    setState(() {
      _name = infor;
    });
  }

  bool editCheck = false;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        editCheck
            ? Container(
                height: 50,
                width: size.width * .8,
                color: Colors.white.withOpacity(.9),
                child: TextFormField(
                  controller: widget.textCtrl,
                  // inputFormatters: [
                  //   //FilteringTextInputFormatter.allow(RegExp('[a-zA-Z]')),
                  //   FilteringTextInputFormatter.deny(RegExp('[a-zA-Z0-9!]')),
                  // ],
                  decoration: InputDecoration(
                    hintText: widget.lableText,
                    labelText: widget.lableText,
                    labelStyle: const TextStyle(
                        fontSize: 22, fontWeight: FontWeight.bold),
                    border: const OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.black),
                    ),
                  ),
                ),
              )
            : InkWell(
                onTap: () {
                  setState(() {
                    editInfor = !editInfor!;
                  });
                },
                child: Container(
                  height: 50,
                  width: size.width * .8,
                  padding: EdgeInsets.symmetric(horizontal: 8),
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Expanded(
                            flex: 1,
                            child: Container(
                                child: Text(widget.lableText,
                                    style: TextStyle(fontSize: 18)))),
                        Expanded(
                          flex: 2,
                          child: Container(
                            child: Text(
                              _name!,
                              style: TextStyle(fontSize: 18),
                            ),
                          ),
                        ),
                      ]),
                ),
              ),
        editInfor!
            ? InkWell(
                onTap: () {
                  setState(() {
                    editCheck = !editCheck;
                    print(editCheck);
                  });
                  if (editCheck == false) {
                    getInfor(context);
                  }
                },
                child: editCheck
                    ? const Icon(
                        Icons.check,
                        color: Colors.green,
                        size: 25,
                      )
                    : const Icon(
                        Icons.edit,
                        size: 25,
                        color: Colors.black,
                      ),
              )
            : const SizedBox(
                width: 10,
              )
      ],
    );
  }
}
