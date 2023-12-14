import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:notely/Screens/To-Do/view/schedule_reminder.dart';

import '../../Welcome Page/controller/welcome_page_controller.dart';

class UpdatedTodoView extends StatefulWidget {
  final String? todocardTitle;
  final String? todocardDescription;
  final String? docID;

  const UpdatedTodoView({
    super.key,
    required this.todocardTitle,
    required this.todocardDescription,
    required this.docID,
  });

  @override
  State<UpdatedTodoView> createState() => _UpdatedTodoViewState();
}

class _UpdatedTodoViewState extends State<UpdatedTodoView> {
  WelcomePageController welcomePageController =
      Get.put(WelcomePageController());

  TextEditingController todoTitleController = TextEditingController();
  TextEditingController todoDescriptionController = TextEditingController();

  final formkey = GlobalKey<FormState>();

  Future<void> updateTodoDocument(
      String? docID, Map<String, dynamic> updatedData) async {
    try {
      final CollectionReference todoCollection = FirebaseFirestore.instance
          .collection("ToDo Data for uid ${welcomePageController.uid.value}");
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
    ThemeData theme = Theme.of(context);

    return DraggableScrollableSheet(
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
                        'Update  To-Do',
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
                              builder: (BuildContext context) => const Scaffold(
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
                      controller: todoTitleController,
                      keyboardType: TextInputType.text,
                      cursorColor: theme.brightness == Brightness.dark
                          ? const Color(0XFFFFFFFF)
                          : const Color(0XFF000000),
                      style: Theme.of(context).textTheme.titleSmall,
                      decoration: InputDecoration(
                        hintText: widget.todocardTitle,
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
                      controller: todoDescriptionController,
                      keyboardType: TextInputType.multiline,
                      cursorColor: theme.brightness == Brightness.dark
                          ? const Color(0XFFFFFFFF)
                          : const Color(0XFF000000),
                      maxLines: 5,
                      style: Theme.of(context).textTheme.labelMedium,
                      decoration: InputDecoration(
                        hintText: widget.todocardDescription,
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
                            await updateTodoDocument(widget.docID, {
                              "ToDo_Title":
                                  todoTitleController.text.toString().trim(),
                              "ToDo_Description": todoDescriptionController.text
                                  .toString()
                                  .trim(),
                            });
                            Future.microtask(() {
                              Navigator.pop(context);
                            });
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFFFDEADE),
                            padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
                            textStyle: Theme.of(context).textTheme.labelMedium,
                          ),
                          child: Text(
                            "Update",
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
                            padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
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
    );
  }
}
