import 'dart:io';

import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import 'controller/profile_image_controller.dart';

class ProfileImageModal extends StatefulWidget {
  const ProfileImageModal({super.key});

  @override
  State<ProfileImageModal> createState() => _ProfileImageModalState();
}

class _ProfileImageModalState extends State<ProfileImageModal> {
  ProfileImageController profileImageController =
      Get.put(ProfileImageController());

  Future _pickimage(ImageSource source, BuildContext context) async {
    try {
      final imgpath = await ImagePicker().pickImage(source: source);
      if (imgpath == null) return;
      profileImageController.img.value = File(imgpath.path);
      if (kDebugMode) {
        print(
            'FilePath------------------------------${profileImageController.img.value}');
      }
    } on PlatformException catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);

    return SizedBox(
      height: MediaQuery.of(context).size.height / 3,
      child: DraggableScrollableSheet(
        initialChildSize: 0.8,
        minChildSize: 0.8,
        maxChildSize: 0.9,
        builder: (_, controller) => Container(
          padding: const EdgeInsets.fromLTRB(24, 24, 24, 24),
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
          ),
          child: Padding(
            padding: const EdgeInsets.only(left: 18, right: 18),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                  onTap: () {
                    Navigator.of(context).pop();
                    _pickimage(ImageSource.camera, context);
                  },
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 15),
                    child: DottedBorder(
                      color: theme.brightness == Brightness.dark
                          ? const Color(0XFFFFFFFF)
                          : const Color(0xFF414A4C),
                      strokeWidth: 2,
                      dashPattern: const [10, 10],
                      borderType: BorderType.RRect,
                      radius: const Radius.circular(15),
                      child: const SizedBox(
                        height: 400,
                        width: 150,
                        child: Card(
                          color: Color(0XFFDBFCFF),
                          child: Center(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Padding(
                                  padding: EdgeInsets.only(top: 34),
                                  child: Icon(
                                    Icons.add_a_photo_rounded,
                                    size: 39,
                                    fill: 0.6,
                                    color: Color(0XFF111111),
                                  ),
                                ),
                                SizedBox(
                                  height: 20,
                                ),
                                Text(
                                  "Capture from",
                                  style: TextStyle(
                                    fontFamily: 'Alata',
                                    fontSize: 18,
                                    fontWeight: FontWeight.w500,
                                    fontStyle: FontStyle.normal,
                                    decoration: TextDecoration.none,
                                    color: Color(0xFF000000),
                                  ),
                                  overflow: TextOverflow.ellipsis,
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                Text(
                                  "Camera",
                                  style: TextStyle(
                                    fontFamily: 'Alata',
                                    fontSize: 18,
                                    fontWeight: FontWeight.w500,
                                    fontStyle: FontStyle.normal,
                                    decoration: TextDecoration.none,
                                    color: Color(0xFF000000),
                                  ),
                                  overflow: TextOverflow.ellipsis,
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                const Spacer(),
                GestureDetector(
                  onTap: () {
                    Navigator.of(context).pop();
                    _pickimage(ImageSource.gallery, context);
                  },
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 15),
                    child: DottedBorder(
                      color: theme.brightness == Brightness.dark
                          ? const Color(0XFFFFFFFF)
                          : const Color(0xFF414A4C),
                      strokeWidth: 2,
                      dashPattern: const [10, 10],
                      borderType: BorderType.RRect,
                      radius: const Radius.circular(15),
                      child: const SizedBox(
                        height: 400,
                        width: 150,
                        child: Card(
                          color: Color(0XFFDBFCFF),
                          child: Center(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Padding(
                                  padding: EdgeInsets.only(top: 34),
                                  child: Icon(
                                    Icons.add_photo_alternate_rounded,
                                    size: 41,
                                    fill: 0.6,
                                    color: Color(0XFF111111),
                                  ),
                                ),
                                SizedBox(
                                  height: 20,
                                ),
                                Text(
                                  "Select from",
                                  style: TextStyle(
                                    fontFamily: 'Alata',
                                    fontSize: 18,
                                    fontWeight: FontWeight.w500,
                                    fontStyle: FontStyle.normal,
                                    decoration: TextDecoration.none,
                                    color: Color(0xFF000000),
                                  ),
                                  overflow: TextOverflow.ellipsis,
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                Text(
                                  "Photos",
                                  style: TextStyle(
                                    fontFamily: 'Alata',
                                    fontSize: 18,
                                    fontWeight: FontWeight.w500,
                                    fontStyle: FontStyle.normal,
                                    decoration: TextDecoration.none,
                                    color: Color(0xFF000000),
                                  ),
                                  overflow: TextOverflow.ellipsis,
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
