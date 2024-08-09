import 'package:flutter/material.dart';

import '../app/app.common.functions.dart';
import '../services/firestore.service.dart';

class UpdatedNoteBottomsheet extends StatelessWidget {
  final String? heading;
  final String description;
  final String docID;
  final bool isBookmarked;

  const UpdatedNoteBottomsheet({
    super.key,
    this.heading,
    required this.description,
    required this.docID,
    required this.isBookmarked,
  });

  @override
  Widget build(BuildContext context) {
    TextEditingController titleController = TextEditingController();
    TextEditingController descriptionController = TextEditingController();

    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.98,
      width: double.infinity,
      child: Padding(
        padding:
            const EdgeInsets.only(top: 54, left: 24, right: 24, bottom: 24),
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  GestureDetector(
                    onTap: () => Navigator.pop(context),
                    child: Icon(
                      Icons.arrow_back,
                      size: 26,
                      color: getTheme(context).brightness == Brightness.dark
                          ? const Color(0xFFFDEADE)
                          : const Color(0xFF000000),
                    ),
                  ),
                  const Spacer(),
                  GestureDetector(
                    onTap: () async {
                      if (titleController.text.toString() == heading ||
                          descriptionController.text.toString() ==
                              description) {
                        Navigator.pop(context);
                      } else if (titleController.text.toString() != heading &&
                          descriptionController.text.toString() !=
                              description) {
                        DatabaseHandler.updateUserNotes(
                          context,
                          titleController.text.toString().trim(),
                          descriptionController.text.toString().trim(),
                          docID,
                        ).whenComplete(() => Navigator.pop(context));
                      } else {}
                    },
                    child: Icon(
                      Icons.check,
                      size: 25,
                      color: getTheme(context).brightness == Brightness.dark
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
                    "${formatDate(DateTime.now())},",
                    style: getTheme(context).textTheme.titleSmall,
                  ),
                  const SizedBox(
                    width: 5,
                  ),
                  Text(
                    TimeOfDay.now().format(context),
                    style: getTheme(context).textTheme.titleSmall,
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
                controller: titleController,
                keyboardType: TextInputType.multiline,
                cursorColor: getTheme(context).brightness == Brightness.dark
                    ? const Color(0XFFFFFFFF)
                    : const Color(0XFF000000),
                style: TextStyle(
                  fontFamily: 'Alata',
                  fontSize: 38,
                  fontWeight: FontWeight.w500,
                  fontStyle: FontStyle.normal,
                  decoration: TextDecoration.none,
                  color: getTheme(context).brightness == Brightness.dark
                      ? const Color(0xFFFDEADE)
                      : const Color(0xFF282E34),
                ),
                decoration: InputDecoration(
                  hintText: heading!.isEmpty ? 'Heading' : heading,
                  hintStyle: TextStyle(
                    fontFamily: 'Alata',
                    fontSize: 38,
                    fontWeight: FontWeight.w500,
                    fontStyle: FontStyle.normal,
                    decoration: TextDecoration.none,
                    color: getTheme(context).brightness == Brightness.dark
                        ? const Color(0xFFFDEADE)
                        : const Color(0xFF39424A),
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
              TextFormField(
                controller: descriptionController,
                keyboardType: TextInputType.multiline,
                autofocus: true,
                maxLines: 10,
                cursorColor: getTheme(context).brightness == Brightness.dark
                    ? const Color(0XFFFFFFFF)
                    : const Color(0XFF000000),
                // autofocus: true,
                style: TextStyle(
                  fontFamily: 'Alata',
                  fontSize: 26,
                  fontWeight: FontWeight.w500,
                  fontStyle: FontStyle.normal,
                  decoration: TextDecoration.none,
                  color: getTheme(context).brightness == Brightness.dark
                      ? const Color(0xFFFDEADE)
                      : const Color(0xFF282E34),
                ),
                decoration: InputDecoration(
                  contentPadding: const EdgeInsets.all(20.0),
                  hintText: description,
                  hintStyle: TextStyle(
                    fontFamily: 'Alata',
                    fontSize: 26,
                    fontWeight: FontWeight.w500,
                    fontStyle: FontStyle.normal,
                    decoration: TextDecoration.none,
                    color: getTheme(context).brightness == Brightness.dark
                        ? const Color(0xFFFDEADE)
                        : const Color(0xFF5C6A77),
                  ),
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
    );
  }
}
