import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class NoteView extends StatefulWidget {
  const NoteView({super.key});

  @override
  State<NoteView> createState() => _NoteViewState();
}

class _NoteViewState extends State<NoteView> {
  @override
  Widget build(BuildContext context) {
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
                        onTap: () async {},
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
                      // controller: noteController,
                      keyboardType: TextInputType.multiline,
                      cursorColor: theme.brightness == Brightness.dark
                          ? const Color(0XFFFFFFFF)
                          : const Color(0XFF000000),
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
                    // controller: descriptionController,
                    keyboardType: TextInputType.multiline,
                    maxLines: 10,
                    cursorColor: theme.brightness == Brightness.dark
                        ? const Color(0XFFFFFFFF)
                        : const Color(0XFF000000),
                    autofocus: true,
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
