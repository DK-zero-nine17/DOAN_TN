import 'package:avatar_glow/avatar_glow.dart';
import 'package:date_format/date_format.dart';
import 'package:flutter/material.dart';
import 'package:speech_to_text/speech_to_text.dart';

class MicPost extends StatefulWidget {
  MicPost({super.key, required this.getInforFromMicVoice});
  Function getInforFromMicVoice;
  @override
  State<MicPost> createState() => _MicPostState();
}

class _MicPostState extends State<MicPost> {
  SpeechToText speechToText = SpeechToText();
  var text = 'Start Speaking';
  var isListening = false;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 1,
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
      ),
      body: Container(
        height: 150,
        margin: EdgeInsets.only(top: size.height * .1),
        width: size.width,
        child: Text(
          text,
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 30),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: AvatarGlow(
        glowColor: const Color.fromARGB(255, 89, 126, 90),
        curve: Curves.bounceOut,
        endRadius: 120.0,
        animate: isListening,
        showTwoGlows: true,
        duration: const Duration(
          milliseconds: 2000,
        ),
        repeatPauseDuration: const Duration(milliseconds: 100),
        repeat: true,
        child: GestureDetector(
          onTapDown: (details) async {
            if (!isListening) {
              var available = await speechToText.initialize();
              if (available) {
                setState(() {
                  isListening = true;
                  print('bat dau micccccc');
                  speechToText.listen(
                    onResult: (result) {
                      setState(() {
                        text = result.recognizedWords;
                      });
                    },
                  );
                });
              }
            }
          },
          onTapUp: (details) {
            setState(() {
              isListening = false;
              print('ket thuc mic');
              widget.getInforFromMicVoice(text);
            });
            speechToText.stop();
            Navigator.pop(context);
          },
          child: CircleAvatar(
            radius: 55,
            backgroundColor: const Color.fromARGB(255, 34, 93, 36),
            child: Icon(
              isListening ? Icons.mic : Icons.mic_none,
              size: 65,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}
