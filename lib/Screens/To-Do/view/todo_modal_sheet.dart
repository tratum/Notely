import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:notely/Screens/To-Do/view/schedule_reminder.dart';

import '../../BottomNavBar/view/custom_bottom_nav_bar.dart';
import '../controller/todo_modal_controller.dart';

// ignore: must_be_immutable
class ToDoModalSheet extends StatefulWidget {
  bool isFav = false;

  ToDoModalSheet({Key? key, required this.isFav}) : super(key: key);

  @override
  State<ToDoModalSheet> createState() => _ToDoModalSheetState();
}

class _ToDoModalSheetState extends State<ToDoModalSheet> {
  final FocusNode _titleFocusNode = FocusNode();
  final FocusNode _descriptionFocusNode = FocusNode();
  TodoModalController todoModalController = Get.put(TodoModalController());
  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  final formkey = GlobalKey<FormState>();

  FirebaseAuth auth = FirebaseAuth.instance;
  final db = FirebaseFirestore.instance;
  User? user;

  @override
  void dispose() {
    _titleFocusNode.dispose();
    _descriptionFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);

    void sendToDoData(BuildContext context, TextEditingController controllerOne,
        TextEditingController controllerTwo) async {
      if (user != null) {
        final uerdata = <String, dynamic>{
          "Uid": todoModalController.uid.value,
          "ToDo_Title": controllerOne.text.toString().trim(),
          "ToDo_Description": controllerTwo.text.toString().trim(),
          "TimeStamp": Timestamp.now(),
          "Date-Set": todoModalController.displayDate.value.toString().trim(),
          "Time-Set": todoModalController.displayTime.value
              .format(context)
              .toString()
              .trim(),
          "isFav": widget.isFav,
        };
        DocumentReference docRef = await db
            .collection('ToDo Data for uid ${todoModalController.uid.value}')
            .add(uerdata);
        String docID = docRef.id;
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

    return GestureDetector(
      onTap: () {
        _titleFocusNode.unfocus();
        _descriptionFocusNode.unfocus();
      },
      child: DraggableScrollableSheet(
        initialChildSize: 0.97,
        minChildSize: 0.97,
        maxChildSize: 0.98,
        builder: (_, controller) => Container(
          padding: EdgeInsets.fromLTRB(
              24, 28, 24, MediaQuery.of(context).viewInsets.bottom),
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
          ),
          child: SingleChildScrollView(
            controller: controller,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(
                      child: FaIcon(
                        FontAwesomeIcons.xmark,
                        size: 24,
                        color: theme.brightness == Brightness.dark
                            ? const Color(0xFFFDEADE)
                            : const Color(0XFF111111),
                      ),
                      onTap: () {
                        Navigator.pop(context);
                      },
                    ),
                    Expanded(
                      child: Align(
                        alignment: Alignment.center,
                        child: Text(
                          'New  To-Do',
                          style: Theme.of(context).textTheme.titleLarge,
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                Form(
                  key: formkey,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          GestureDetector(
                            child: Icon(
                              Icons.edit_calendar_rounded,
                              color: theme.brightness == Brightness.dark
                                  ? const Color(0xFFFDEADE)
                                  : const Color(0XFF2C2C2C),
                              size: 23,
                            ),
                            onTap: () {
                              showDialog(
                                context: context,
                                barrierDismissible: false,
                                builder: (BuildContext context) =>
                                    const Scaffold(
                                  backgroundColor: Colors.transparent,
                                  body: ScheduleReminder(),
                                ),
                              );
                            },
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      TextFormField(
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        controller: titleController,
                        keyboardType: TextInputType.multiline,
                        cursorColor: theme.brightness == Brightness.dark
                            ? const Color(0XFFFFFFFF)
                            : const Color(0XFF000000),
                        decoration: InputDecoration(
                          hintText: 'Write Title',
                          hintStyle: Theme.of(context).textTheme.labelMedium,
                          contentPadding: const EdgeInsets.all(20.0),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15),
                            borderSide: const BorderSide(
                              color: Color(0XFF808080),
                              width: 1.5,
                            ),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15),
                            borderSide: const BorderSide(
                              color: Color(0xFF414A4C),
                              width: 2,
                            ),
                          ),
                          errorBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15),
                            borderSide: const BorderSide(
                              color: Color(0XFFBF0000),
                              width: 2,
                            ),
                          ),
                          errorStyle: const TextStyle(
                            fontFamily: 'Alata',
                            fontSize: 12,
                            fontWeight: FontWeight.w400,
                            fontStyle: FontStyle.normal,
                            decoration: TextDecoration.none,
                            color: Color(0xFFBF0000),
                          ),
                        ),
                        textAlign: TextAlign.start,
                        validator: (value) {
                          if (value == null || value == '') {
                            return 'Enter Title';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      TextFormField(
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        controller: descriptionController,
                        keyboardType: TextInputType.multiline,
                        cursorColor: theme.brightness == Brightness.dark
                            ? const Color(0XFFFFFFFF)
                            : const Color(0XFF000000),
                        maxLines: 5,
                        decoration: InputDecoration(
                          hintText: 'What To Do ?',
                          hintStyle: Theme.of(context).textTheme.labelMedium,
                          contentPadding: const EdgeInsets.all(20.0),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15),
                            borderSide: const BorderSide(
                              color: Color(0XFF808080),
                              width: 1.5,
                            ),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15),
                            borderSide: const BorderSide(
                              color: Color(0xFF414A4C),
                              width: 2,
                            ),
                          ),
                          errorBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15),
                            borderSide: const BorderSide(
                              color: Color(0XFFBF0000),
                              width: 2,
                            ),
                          ),
                          errorStyle: const TextStyle(
                            fontFamily: 'Alata',
                            fontSize: 12,
                            fontWeight: FontWeight.w400,
                            fontStyle: FontStyle.normal,
                            decoration: TextDecoration.none,
                            color: Color(0xFFBF0000),
                          ),
                        ),
                        textAlign: TextAlign.start,
                        validator: (value) {
                          if (value == null || value == '') {
                            return 'Enter Description';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(
                        height: 40,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          ElevatedButton(
                            onPressed: () async {
                              UserCredential userCred =
                                  await auth.signInAnonymously();
                              user = userCred.user;
                              todoModalController.uid.value = user!.uid;
                              final isValidfrom =
                                  formkey.currentState!.validate();
                              if (isValidfrom) {
                                if (context.mounted) {
                                  sendToDoData(context, titleController,
                                      descriptionController);
                                  Navigator.pushAndRemoveUntil(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              const CustomBottomNavBar(
                                                  selectedIndex: 1)),
                                      (route) => false);
                                }
                              }
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xFFFDEADE),
                              padding:
                                  const EdgeInsets.fromLTRB(20, 10, 20, 10),
                              textStyle:
                                  Theme.of(context).textTheme.labelMedium,
                            ),
                            child: Text(
                              "Save",
                              style: theme.brightness == Brightness.dark
                                  ? const TextStyle(
                                      fontFamily: 'Alata',
                                      fontSize: 12,
                                      fontWeight: FontWeight.w600,
                                      fontStyle: FontStyle.normal,
                                      decoration: TextDecoration.none,
                                      color: Color(0xFF111111),
                                    )
                                  : const TextStyle(
                                      fontFamily: 'Alata',
                                      fontSize: 12,
                                      fontWeight: FontWeight.w600,
                                      fontStyle: FontStyle.normal,
                                      decoration: TextDecoration.none,
                                      color: Color(0xFF111111),
                                    ),
                            ),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          ElevatedButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor:
                                  Theme.of(context).colorScheme.background,
                              padding:
                                  const EdgeInsets.fromLTRB(20, 10, 20, 10),
                              textStyle: Theme.of(context).textTheme.labelSmall,
                            ),
                            child: Text(
                              "Cancel",
                              style: Theme.of(context).textTheme.labelMedium,
                            ),
                          ),
                        ],
                      ),
                    ],
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
