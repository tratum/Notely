import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../app/app.common.functions.dart';
import '../dialogs/dialog.schedule.reminder.dart';
import '../services/firestore.service.dart';

class UpdatedTodoBottomsheet extends StatelessWidget {
  final String? heading;
  final String description;
  final String docID;
  final bool isBookmarked;

  const UpdatedTodoBottomsheet({
    super.key,
    this.heading,
    required this.docID,
    required this.description,
    required this.isBookmarked,
  });

  @override
  Widget build(BuildContext context) {
    TextEditingController titleController = TextEditingController();
    TextEditingController descriptionController = TextEditingController();

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
                      color: getTheme(context).brightness == Brightness.dark
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
                        style: getTheme(context).textTheme.titleLarge,
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      GestureDetector(
                        child: Icon(
                          Icons.edit_calendar_rounded,
                          color: getTheme(context).brightness == Brightness.dark
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
                              body: ScheduleReminderDialog(),
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
                    autofocus: true,
                    controller: titleController,
                    keyboardType: TextInputType.multiline,
                    cursorColor: getTheme(context).brightness == Brightness.dark
                        ? const Color(0XFFFFFFFF)
                        : const Color(0XFF000000),
                    decoration: InputDecoration(
                      hintText: heading ?? 'Write Title',
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
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    controller: descriptionController,
                    keyboardType: TextInputType.multiline,
                    cursorColor: getTheme(context).brightness == Brightness.dark
                        ? const Color(0XFFFFFFFF)
                        : const Color(0XFF000000),
                    maxLines: 5,
                    decoration: InputDecoration(
                      hintText: description,
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
                  ),
                  const SizedBox(
                    height: 40,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      ElevatedButton(
                        onPressed: () async {
                          if (titleController.text.toString() == heading ||
                              descriptionController.text.toString() ==
                                  description) {
                            Navigator.pop(context);
                          } else if (titleController.text.toString() !=
                                  heading &&
                              descriptionController.text.toString() !=
                                  description) {
                            DatabaseHandler.updateUserTodos(
                              context,
                              titleController.text.toString().trim(),
                              descriptionController.text.toString().trim(),
                              docID,
                            ).whenComplete(() => Navigator.pop(context));
                          } else {}
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFFFDEADE),
                          padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
                          textStyle: Theme.of(context).textTheme.labelMedium,
                        ),
                        child: Text(
                          "Save",
                          style: getTheme(context).brightness == Brightness.dark
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
                          Navigator.pop(context);
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor:
                              Theme.of(context).colorScheme.surface,
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
            ],
          ),
        ),
      ),
    );
  }
}
