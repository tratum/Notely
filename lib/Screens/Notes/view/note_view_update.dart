import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../Welcome Page/controller/welcome_page_controller.dart';

class UpdatedNoteView extends StatefulWidget {
  final String? noteTitle;
  final String? noteDescription;
  final String? docID;

  const UpdatedNoteView({
    super.key,
    required this.noteTitle,
    required this.noteDescription,
    required this.docID,
  });

  @override
  State<UpdatedNoteView> createState() => _UpdatedNoteViewState();
}

class _UpdatedNoteViewState extends State<UpdatedNoteView> {
  WelcomePageController welcomePageController =
      Get.put(WelcomePageController());
  TextEditingController noteTitleController = TextEditingController();
  TextEditingController noteDescriptionController = TextEditingController();

  final formkey = GlobalKey<FormState>();

  Future<void> updateTodoDocument(
      String? docID, Map<String, dynamic> updatedData) async {
    try {
      final CollectionReference todoCollection = FirebaseFirestore.instance
          .collection("Notes Data for uid ${welcomePageController.uid.value}");
      final DocumentReference todoDocRef = todoCollection.doc(docID);
      await todoDocRef.update(updatedData);
      if (kDebugMode) {
        print('Document updated successfully.');
      }
    } catch (error) {
      if (kDebugMode) {
        print('Error updating document: $error');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
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

    ThemeData theme = Theme.of(context);

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
                          // UserCredential userCred =
                          // await auth.signInAnonymously();
                          // user = userCred.user;
                          // noteModalController.uid.value = user!.uid;
                          // if (context.mounted) {
                          //   sendNotesData(
                          //       context, noteController, descriptionController);
                          // }
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
                      controller: noteTitleController,
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
                        hintText: widget.noteTitle,
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
                    controller: noteDescriptionController,
                    keyboardType: TextInputType.multiline,
                    maxLines: 10,
                    cursorColor: theme.brightness == Brightness.dark
                        ? const Color(0XFFFFFFFF)
                        : const Color(0XFF000000),
                    autofocus: true,
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
                    decoration: InputDecoration(
                      hintText: widget.noteDescription,
                      hintStyle: TextStyle(
                        fontFamily: 'Alata',
                        fontSize: 26,
                        fontWeight: FontWeight.w500,
                        fontStyle: FontStyle.normal,
                        decoration: TextDecoration.none,
                        color: theme.brightness == Brightness.dark
                            ? const Color(0xFFFDEADE)
                            : const Color(0xFF282E34),
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
