import 'package:flutter/material.dart';
import 'package:mini_do_an/UI/detail_screens/notifi_detail/search_screen.dart';
import 'package:mini_do_an/api/network_request.dart';
import 'package:speech_to_text/speech_to_text.dart';

class SearchBarPost extends StatefulWidget {
  SearchBarPost({
    super.key,
    required this.iddUser,
  });
  int iddUser;
  @override
  State<SearchBarPost> createState() => _SearchBarPostState();
}

class _SearchBarPostState extends State<SearchBarPost> {
  bool checkOpenMic = false;
  SpeechToText speechToText = SpeechToText();
  String _textInfor = '';
  var text = 'Start Speaking';
  var isListening = false;
  var listSearch = [];
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
          backgroundColor: Colors.white,
          leading: IconButton(
            icon: const Icon(
              Icons.arrow_back,
              size: 30,
            ),
            onPressed: () {
              Navigator.pop(context);
            },
            color: Colors.black,
          ),
          title: Container(
            height: 40,
            width: size.width,
            padding: const EdgeInsets.symmetric(horizontal: 8),
            decoration: BoxDecoration(
                color: Colors.grey.withOpacity(.2),
                borderRadius: BorderRadius.circular(20)),
            child: SizedBox(
              height: 45,
              width: size.width * .4,
              child: TextFormField(
                decoration: const InputDecoration(
                    hintText: 'Tìm kiếm thông tin', icon: Icon(Icons.search)),
                onChanged: (value) {
                  setState(() {
                    _textInfor = value.toLowerCase();
                  });
                },
              ),
            ),
          )),
      body: Stack(
        children: [
          _textInfor == ''
              ? const SizedBox(
                  height: 1,
                )
              : SearchScreen(
                  size: size,
                  iddUser: widget.iddUser,
                  queryGetList:
                      NetworkRequest.fetchAllPostSearchBar(_textInfor),
                ),
        ],
      ),
    );
  }
}
