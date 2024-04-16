import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:notely/Screens/BottomNavBar/view/custom_bottom_nav_bar.dart';
import 'package:notely/Screens/Notes/controller/note_modal_controller.dart';

// ignore: must_be_immutable
class NoteModalSheet extends StatefulWidget {
  bool isFav = false;

  NoteModalSheet({Key? key, required this.isFav}) : super(key: key);

  @override
  State<NoteModalSheet> createState() => _NoteModalSheetState();
}

class _NoteModalSheetState extends State<NoteModalSheet> {
  TextEditingController noteController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  NoteModalController noteModalController = Get.put(NoteModalController());

  FirebaseAuth auth = FirebaseAuth.instance;
  final db = FirebaseFirestore.instance;
  User? user;
  late String docID;

  @override
  Widget build(BuildContext context) {
    void sendNotesData(
        BuildContext context,
        TextEditingController controllerOne,
        TextEditingController controllerTwo) async {
      if (user != null) {
        final uerdata = <String, dynamic>{
          "Uid": noteModalController.uid.value,
          "Note_Title": controllerOne.text.toString().trim(),
          "Note_Description": controllerTwo.text.toString().trim(),
          "TimeStamp": Timestamp.now(),
          "isFav": widget.isFav,
        };
        DocumentReference docRef = await db
            .collection('Notes Data for uid ${noteModalController.uid.value}')
            .add(uerdata);
        docID = docRef.id;
        await docRef.update({"docID": docID});
        if (context.mounted) {
          Navigator.pop(context);
        }
      } else {
        if (kDebugMode) {
          print("Uploading Data Failed");
        }
      }
    }

    ThemeData theme = Theme.of(context);
    DateTime currentDate = DateTime.now();
    TimeOfDay currentTime = TimeOfDay.now();
    String formatDate(DateTime date) {
      final dayFormat = DateFormat('d');
      final monthFormat = DateFormat.MMMM();
      final dayOfWeekFormat = DateFormat.E();
      final day = dayFormat.format(date);
      final month = monthFormat.format(date);
      final dayOfWeek = dayOfWeekFormat.format(date);

      String suffix = 'th';
      if (day.endsWith('1') && day != '11') {
        suffix = 'st';
      } else if (day.endsWith('2') && day != '12') {
        suffix = 'nd';
      } else if (day.endsWith('3') && day != '13') {
        suffix = 'rd';
      }

      return '$dayOfWeek $day$suffix $month';
    }

    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.98,
      width: double.infinity,
      child: Padding(
        padding: const EdgeInsets.only(top: 30),
        child: SafeArea(
          child: SizedBox(
            height: MediaQuery.of(context).size.height / 7,
            child: Padding(
              padding: const EdgeInsets.all(24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      GestureDetector(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: Icon(
                          Icons.arrow_back,
                          size: 26,
                          color: theme.brightness == Brightness.dark
                              ? const Color(0xFFFDEADE)
                              : const Color(0xFF000000),
                        ),
                      ),
                      const Spacer(),
                      GestureDetector(
                        onTap: () async {
                          UserCredential userCred =
                              await auth.signInAnonymously();
                          user = userCred.user;
                          noteModalController.uid.value = user!.uid;
                          if (context.mounted) {
                            sendNotesData(
                                context, noteController, descriptionController);
                            Navigator.pushAndRemoveUntil(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        const CustomBottomNavBar(
                                            selectedIndex: 0)),
                                (route) => false);
                          }
                        },
                        child: Icon(
                          Icons.check,
                          size: 25,
                          color: theme.brightness == Brightness.dark
                              ? const Color(0xFFFDEADE)
                              : const Color(0xFF000000),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Row(
                    children: [
                      Text(
                        "${formatDate(currentDate)},",
                        style: Theme.of(context).textTheme.titleSmall,
                      ),
                      const SizedBox(
                        width: 5,
                      ),
                      Text(
                        currentTime.format(context),
                        style: Theme.of(context).textTheme.titleSmall,
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 4,
                  ),
                  const Divider(
                    height: 4,
                    color: Color(0xFFA2ADB8),
                  ),
                  TextFormField(
                      controller: noteController,
                      keyboardType: TextInputType.multiline,
                      cursorColor: theme.brightness == Brightness.dark
                          ? const Color(0XFFFFFFFF)
                          : const Color(0XFF000000),
                      style: TextStyle(
                        fontFamily: 'Alata',
                        fontSize: 38,
                        fontWeight: FontWeight.w500,
                        fontStyle: FontStyle.normal,
                        decoration: TextDecoration.none,
                        color: theme.brightness == Brightness.dark
                            ? const Color(0xFFFDEADE)
                            : const Color(0xFF282E34),
                      ),
                      decoration: InputDecoration(
                        hintText: 'Heading',
                        hintStyle: TextStyle(
                          fontFamily: 'Alata',
                          fontSize: 38,
                          fontWeight: FontWeight.w500,
                          fontStyle: FontStyle.normal,
                          decoration: TextDecoration.none,
                          color: theme.brightness == Brightness.dark
                              ? const Color(0xFFFDEADE)
                              : const Color(0xFF4F5B67),
                        ),
                        contentPadding: const EdgeInsets.all(20.0),
                        enabledBorder: const OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.transparent,
                          ),
                        ),
                        focusedBorder: const OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.transparent,
                          ),
                        ),
                      )),
                  TextFormField(
                    controller: descriptionController,
                    keyboardType: TextInputType.multiline,
                    maxLines: 10,
                    cursorColor: theme.brightness == Brightness.dark
                        ? const Color(0XFFFFFFFF)
                        : const Color(0XFF000000),
                    // autofocus: true,
                    style: TextStyle(
                      fontFamily: 'Alata',
                      fontSize: 26,
                      fontWeight: FontWeight.w500,
                      fontStyle: FontStyle.normal,
                      decoration: TextDecoration.none,
                      color: theme.brightness == Brightness.dark
                          ? const Color(0xFFFDEADE)
                          : const Color(0xFF282E34),
                    ),
                    decoration: const InputDecoration(
                      contentPadding: EdgeInsets.all(20.0),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.transparent,
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.transparent,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
