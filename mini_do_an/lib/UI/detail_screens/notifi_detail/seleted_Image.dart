import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mini_do_an/Model/post.dart';
import 'package:permission_handler/permission_handler.dart';

import '../notifi_layout_picture/five_pictures.dart';
import '../notifi_layout_picture/four_pictures.dart';
import '../notifi_layout_picture/more_five_pictures.dart';
import '../notifi_layout_picture/one_picture.dart';
import '../notifi_layout_picture/three_pictures.dart';
import '../notifi_layout_picture/two_pictures.dart';

class SeletedImageScreen extends StatefulWidget {
  SeletedImageScreen({
    Key? key,
    required this.pathImage,
    required this.haveShowImages,
    required this.listImageDefault,
  }) : super(key: key);
  Function pathImage;
  bool haveShowImages;
  List<String> listImageDefault;

  @override
  State<SeletedImageScreen> createState() => _SeletedImageScreenState();
}

class _SeletedImageScreenState extends State<SeletedImageScreen> {
  File? imageFile;
  List<String> listImage = [];
  var lengthListImage = 0;
  Post post = Post(
      id: -1,
      idUser: -1,
      tieudePost: "",
      nguoiguiPost: "",
      datePost: "",
      noidungPost: "",
      thietBi: "");

  // late List<Widget> listLayoutPictures;

  @override
  void initState() {
    super.initState();
    if (widget.listImageDefault.isNotEmpty) {
      listImage = widget.listImageDefault;
    }
  }

  StatefulWidget directLayoutPictures(List<String> listImageFromData) {
    listImageFromData = Set<String>.from(listImageFromData).toList();
    lengthListImage = listImageFromData.length;
    return [
      OnePicture(
        link: listImageFromData,
        iddUser: -1,
        post: post,
      ),
      TwoPictures(
        link: listImageFromData,
        iddUser: -1,
        post: post,
      ),
      ThreePictures(
        link: listImageFromData,
        iddUser: -1,
        post: post,
      ),
      FourPictures(
        link: listImageFromData,
        iddUser: -1,
        post: post,
      ),
      FivePictures(
        link: listImageFromData,
        iddUser: -1,
        post: post,
      ),
      MoreFivePictures(
        link: listImageFromData,
        iddUser: -1,
        post: post,
      ),
    ][lengthListImage >= 6 ? 5 : (lengthListImage - 1)];
  }

  Widget getWidget() {
    lengthListImage = listImage.length;
    print(" list Images la : $lengthListImage");
    if (lengthListImage == 0) {
      return const SizedBox(
        height: 10,
      );
    } else if (lengthListImage < 6) {
      return (directLayoutPictures(listImage));
    }
    return (directLayoutPictures(listImage));
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          widget.haveShowImages
              ? getWidget()
              : const SizedBox(
                  height: 1,
                ),
          const SizedBox(
            height: 10.0,
          ),
          widget.haveShowImages
              ? ElevatedButton(
                  onPressed: () async {
                    Map<Permission, PermissionStatus> statuses = await [
                      Permission.storage,
                      Permission.camera,
                    ].request();
                    if (statuses[Permission.storage]!.isGranted &&
                        statuses[Permission.camera]!.isGranted) {
                      // ignore: use_build_context_synchronously
                      showImagePicker(context);
                    } else {
                      print('no permission provided');
                    }
                  },
                  child: const Text('Select Image'),
                )
              : InkWell(
                  onTap: () async {
                    Map<Permission, PermissionStatus> statuses = await [
                      Permission.storage,
                      Permission.camera,
                    ].request();
                    if (statuses[Permission.storage]!.isGranted &&
                        statuses[Permission.camera]!.isGranted) {
                      // ignore: use_build_context_synchronously
                      showImagePicker(context);
                    } else {
                      print('no permission provided');
                    }
                  },
                  child: Container(
                    height: 40,
                    width: 40,
                    decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        color: Color.fromARGB(255, 214, 211, 211)),
                    child: const Icon(
                      Icons.camera_alt_rounded,
                      color: Colors.black,
                      size: 25,
                    ),
                  ),
                ),
        ],
      ),
    );
  }

  final picker = ImagePicker();

  void showImagePicker(BuildContext context) {
    showModalBottomSheet(
        context: context,
        builder: (builder) {
          return Card(
            child: Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height / 5.2,
                margin: const EdgeInsets.only(top: 8.0),
                padding: const EdgeInsets.all(12),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                        child: InkWell(
                      child: const Column(
                        children: [
                          Icon(
                            Icons.image,
                            size: 60.0,
                          ),
                          SizedBox(height: 12.0),
                          Text(
                            "Gallery",
                            textAlign: TextAlign.center,
                            style: TextStyle(fontSize: 16, color: Colors.black),
                          )
                        ],
                      ),
                      onTap: () {
                        _imgFromGallery();
                        Navigator.pop(context);
                      },
                    )),
                    Expanded(
                        child: InkWell(
                      child: const SizedBox(
                        child: Column(
                          children: [
                            Icon(
                              Icons.camera_alt,
                              size: 60.0,
                            ),
                            SizedBox(height: 12.0),
                            Text(
                              "Camera",
                              textAlign: TextAlign.center,
                              style:
                                  TextStyle(fontSize: 16, color: Colors.black),
                            )
                          ],
                        ),
                      ),
                      onTap: () {
                        _imgFromCamera();

                        Navigator.pop(context);
                      },
                    ))
                  ],
                )),
          );
        });
  }

  _imgFromGallery() async {
    await picker
        .pickImage(source: ImageSource.gallery, imageQuality: 50)
        .then((value) {
      if (value != null) {
        _cropImage(value.path);

        ///
        setState(() {
          if (!listImage.contains(value.path)) {
            widget.pathImage(value.path);
            listImage.add(value.path); // them path vao listImage
          }

          print(
              "aaaaaaaaaaaaaaaaaaaa + ${listImage.length}   + +${value.path} ");
        });
      }
    });
  }

  _imgFromCamera() async {
    await picker
        .pickImage(source: ImageSource.camera, imageQuality: 50)
        .then((value) {
      if (value != null) {
        _cropImage(value.path);
        ////
        setState(() {
          print('link pathImage camera: ${value.path}');
          widget.pathImage(value.path);
          listImage.add(value.path); // them path vao listImage
          print(
              "bbbbbbbbbbbbbbbbbbbbbb + ${listImage.length}   + +${value.path} ");
        });
      }
    });
  }

  _cropImage(String imgFile) async {
    final croppedFile = await ImageCropper().cropImage(
        sourcePath: imgFile,
        aspectRatioPresets: Platform.isAndroid
            ? [
                CropAspectRatioPreset.square,
                CropAspectRatioPreset.ratio3x2,
                CropAspectRatioPreset.original,
                CropAspectRatioPreset.ratio4x3,
                CropAspectRatioPreset.ratio16x9
              ]
            : [
                CropAspectRatioPreset.original,
                CropAspectRatioPreset.square,
                CropAspectRatioPreset.ratio3x2,
                CropAspectRatioPreset.ratio4x3,
                CropAspectRatioPreset.ratio5x3,
                CropAspectRatioPreset.ratio5x4,
                CropAspectRatioPreset.ratio7x5,
                CropAspectRatioPreset.ratio16x9
              ],
        uiSettings: [
          AndroidUiSettings(
              toolbarTitle: "Image Cropper",
              toolbarColor: Colors.deepOrange,
              toolbarWidgetColor: Colors.white,
              initAspectRatio: CropAspectRatioPreset.original,
              lockAspectRatio: false),
          IOSUiSettings(
            title: "Image Cropper",
          )
        ]);
    if (croppedFile != null) {
      imageCache.clear();
      setState(() {
        imageFile = File(croppedFile.path);

        print(
            "lllllllllllllllllllllllllllbbbbbbbbbbbbbbbbbbbbbb + ${listImage.length}   ");
      });
      // reload();
    }
  }
}
