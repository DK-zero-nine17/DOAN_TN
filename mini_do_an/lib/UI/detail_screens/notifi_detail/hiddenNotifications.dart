import 'package:flutter/material.dart';

class HiddenNotifications extends StatelessWidget {
  HiddenNotifications({super.key, required this.iddUser});
  int iddUser;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(title: const Text('Những thông báo đã xóa')),
      // body: showListsAboutThing(
      //     size: size,
      //     iddUser: iddUser,
      //     queryGetList:
      //         DBProvider.db.showAllWithPostStatus(int.parse('${iddUser}'), 0)),
    );
  }
}
