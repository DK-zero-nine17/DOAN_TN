import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'UI/login_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "App DATN",
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: ChangeAnnotatedRegion(),
    );
  }
}

class ChangeAnnotatedRegion extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion(
      value: SystemUiOverlayStyle(
          statusBarBrightness: Brightness.dark,
          statusBarIconBrightness: Brightness.dark,
          statusBarColor: Color.fromARGB(255, 243, 239, 239).withOpacity(.2)),
      child: MyScaffold(),
    );
  }
}
