import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:notely/commons/Snackbar%20Messages/Error%20Message/error_sanckbar.dart';

import '../controller/todo_modal_controller.dart';

class ScheduleReminder extends StatefulWidget {
  const ScheduleReminder({super.key});

  @override
  State<ScheduleReminder> createState() => _ScheduleReminderState();
}

class _ScheduleReminderState extends State<ScheduleReminder> {
  TodoModalController todoModalController = Get.put(TodoModalController());
  DateTime currentdatetime = DateTime.now();
  TimeOfDay currenttime = TimeOfDay.now();

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime.now(),
        lastDate: DateTime(2101),
        builder: (BuildContext context, Widget? child) {
          return Theme(
              data: Theme.of(context).copyWith(
                  colorScheme: ColorScheme.fromSwatch(
                    primarySwatch: const MaterialColor(0xFFFBCEB1, {
                      50: Color(0xFFFDEADE),
                      100: Color(0xFFFDE7D8),
                      200: Color(0xFFFDE3D3),
                      300: Color(0xFFFCE0CD),
                      400: Color(0xFFFCDDC8),
                      500: Color(0xFFFCD9C2),
                      600: Color(0xFFFCD6BD),
                      700: Color(0xFFFBD2B7),
                      800: Color(0xFFFBCEB1),
                    }),
                    brightness: Brightness.dark,
                  ),
                  datePickerTheme: const DatePickerThemeData(
                    backgroundColor: Color(0XFF000000),
                  )),
              child: child!);
        });
    if (picked != null && picked != currentdatetime) {
      todoModalController.currentDateTime.value = picked;
      todoModalController.displayDate.value = DateFormat('dd-MM-yyyy')
          .format(todoModalController.currentDateTime.value);
      todoModalController.yearsDate.value = DateFormat('dd-MM-yyyy')
          .parse(todoModalController.displayDate.value)
          .year;
      todoModalController.monthsDate.value = DateFormat('dd-MM-yyyy')
          .parse(todoModalController.displayDate.value)
          .month;
      todoModalController.dayDate.value = DateFormat('dd-MM-yyyy')
          .parse(todoModalController.displayDate.value)
          .day;
    }
  }

  Future<void> _selectTime(BuildContext context) async {
    final TimeOfDay? timepicker = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
      builder: (BuildContext context, Widget? child) {
        return MediaQuery(
          data: MediaQuery.of(context).copyWith(alwaysUse24HourFormat: false),
          child: Theme(
              data: Theme.of(context).copyWith(
                colorScheme: ColorScheme.fromSwatch(
                  primarySwatch: const MaterialColor(0xFFFBCEB1, {
                    50: Color(0xFFFDEADE),
                    100: Color(0xFFFDE7D8),
                    200: Color(0xFFFDE3D3),
                    300: Color(0xFFFCE0CD),
                    400: Color(0xFFFCDDC8),
                    500: Color(0xFFFCD9C2),
                    600: Color(0xFFFCD6BD),
                    700: Color(0xFFFBD2B7),
                    800: Color(0xFFFBCEB1),
                  }),
                  brightness: Brightness.dark,
                ),
                timePickerTheme: const TimePickerThemeData(
                  backgroundColor: Color(0XFF000000),
                  helpTextStyle: TextStyle(
                      color: Color(0XFFFBCEB1),
                      fontFamily: "Alata",
                      fontSize: 16),
                  dayPeriodTextColor: Color(0XFFFFFFFF),
                ),
              ),
              child: child!),
        );
      },
    );
    if (timepicker != null) {
      todoModalController.displayTime.value = timepicker;
      todoModalController.hoursTime.value =
          todoModalController.displayTime.value.hour;
      todoModalController.minuteTime.value =
          todoModalController.displayTime.value.minute;
    }
  }

  @pragma('vm:entry-point')
  void alarmCallback() {
    if (kDebugMode) {
      print("------------Alarm Set");
    }
  }

  @override
  Widget build(BuildContext context) {
    todoModalController.displayTime.value = currenttime;
    todoModalController.displayDate.value =
        DateFormat('dd-MM-yyyy').format(DateTime.now());
    return AlertDialog(
      alignment: Alignment.center,
      elevation: 20,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(25),
      ),
      insetPadding: EdgeInsets.zero,
      contentPadding: EdgeInsets.zero,
      clipBehavior: Clip.antiAliasWithSaveLayer,
      backgroundColor: Theme.of(context).colorScheme.background,
      title: Padding(
        padding: const EdgeInsets.all(6),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            GestureDetector(
              child: const FaIcon(
                FontAwesomeIcons.xmark,
                size: 18,
                color: Color(0XFF111111),
              ),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            Text(
              'Schedule Reminder',
              style: Theme.of(context).textTheme.titleLarge,
              textAlign: TextAlign.center,
            ),
            GestureDetector(
              child: const FaIcon(
                FontAwesomeIcons.check,
                size: 18,
                color: Color(0XFF111111),
              ),
              onTap: () {
                if (todoModalController.displayTime.value != currenttime) {
                  Navigator.pop(context);
                } else {
                  errorSnackbar(
                      context, "Please Select an Appropriate Date and Time");
                }
              },
            ),
          ],
        ),
      ),
      content: SafeArea(
        child: SizedBox(
          width: MediaQuery.of(context).size.width - 58,
          height: MediaQuery.of(context).size.height / 2,
          child: Padding(
            padding: const EdgeInsets.all(30),
            child: Column(
              children: [
                const SizedBox(
                  height: 12,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      "Remind Me on",
                      style: Theme.of(context).textTheme.titleMedium,
                      textAlign: TextAlign.center,
                    ),
                    const Spacer(),
                    ElevatedButton(
                      onPressed: () {
                        _selectDate(context);
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0XFF111111),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.only(
                          left: 6,
                          right: 6,
                        ),
                        child: Obx(
                          () => Text(todoModalController.displayDate.value,
                              style: const TextStyle(
                                  fontFamily: 'Alata',
                                  fontSize: 14,
                                  fontWeight: FontWeight.w400,
                                  fontStyle: FontStyle.normal,
                                  decoration: TextDecoration.none,
                                  color: Color(0xFFFBCEB1))),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        _selectTime(context);
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0XFF111111),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.only(left: 20, right: 20),
                        child: Obx(
                          () => Text(
                              todoModalController.displayTime.value
                                  .format(context),
                              style: const TextStyle(
                                  fontFamily: 'Alata',
                                  fontSize: 14,
                                  fontWeight: FontWeight.w400,
                                  fontStyle: FontStyle.normal,
                                  decoration: TextDecoration.none,
                                  color: Color(0xFFFBCEB1))),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
