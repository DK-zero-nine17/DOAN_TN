import 'dart:io';

import 'package:flutter/material.dart';

class ShowDetailOneImage extends StatelessWidget {
  ShowDetailOneImage({
    Key? key,
    required this.item,
  }) : super(key: key);

  String item;
  @override
  Widget build(BuildContext context) {
    return Container(
      // margin: EdgeInsets.only(top: 120, bottom: 100),
      child: RegExp('^http').hasMatch(item)
          ? Image.network(
              item,
              fit: BoxFit.cover,
            )
          : ClipRRect(
              // borderRadius: BorderRadius.circular(10.0),
              child: Image.file(
              File.fromUri(Uri.parse(item)),
              // height: 300.0,
              // width: double.infinity,
              fit: BoxFit.cover,
            )),
    );
  }
}
