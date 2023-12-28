import 'package:flutter/material.dart';
import 'package:notely/Screens/To-Do/view/schedule_reminder.dart';

class NoteReader extends StatefulWidget {
  const NoteReader({super.key});

  @override
  State<NoteReader> createState() => _NoteReaderState();
}

class _NoteReaderState extends State<NoteReader> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: AlertDialog(
        alignment: Alignment.center,
        elevation: 20,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(25),
        ),
        insetPadding: EdgeInsets.zero,
        contentPadding: EdgeInsets.zero,
        clipBehavior: Clip.antiAliasWithSaveLayer,
        backgroundColor: Theme.of(context).colorScheme.secondary,
        title: Text(
          'New  To-Do',
          style: Theme.of(context).textTheme.titleMedium,
          textAlign: TextAlign.center,
        ),
        content: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(25.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    GestureDetector(
                      child: const Icon(
                        Icons.edit_calendar_rounded,
                        color: Color(0XFF2C2C2C),
                        size: 23,
                      ),
                      onTap: () {
                        showDialog(
                            context: context,
                            barrierDismissible: false,
                            builder: (BuildContext context) =>
                                const ScheduleReminder());
                      },
                    ),
                  ],
                ),
                TextField(
                  keyboardType: TextInputType.multiline,
                  decoration: InputDecoration(
                    hintText: 'Write Title',
                    hintStyle: Theme.of(context).textTheme.labelMedium,
                    contentPadding: const EdgeInsets.all(20.0),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                      borderSide: const BorderSide(
                        color: Colors.transparent,
                        width: 2,
                      ),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                      borderSide: const BorderSide(
                        color: Colors.transparent,
                        width: 2,
                      ),
                    ),
                  ),
                  textAlign: TextAlign.start,
                ),
                const SizedBox(
                  height: 20,
                ),
                TextField(
                  keyboardType: TextInputType.multiline,
                  maxLines: 5,
                  decoration: InputDecoration(
                    hintText: 'What To Do ?',
                    hintStyle: Theme.of(context).textTheme.labelMedium,
                    contentPadding: const EdgeInsets.all(20.0),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                      borderSide: const BorderSide(
                        color: Color(0XFF808080),
                        width: 2,
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                      borderSide: const BorderSide(
                        color: Color(0xFF414A4C),
                        width: 2,
                      ),
                    ),
                  ),
                  textAlign: TextAlign.start,
                ),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Theme.of(context).colorScheme.primary,
                        padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
                        textStyle: Theme.of(context).textTheme.labelMedium,
                      ),
                      child: Text(
                        "Save",
                        style: Theme.of(context).textTheme.labelSmall,
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
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
