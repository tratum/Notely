import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class TodoModalController extends GetxController {
  Rx<DateTime> currentDateTime = DateTime.now().obs;
  RxString displayDate = DateFormat('dd-MM-yyyy').format(DateTime.now()).obs;
  Rx<TimeOfDay> displayTime = TimeOfDay.now().obs;
  RxString timeFormatted = ''.obs;
  RxBool isTitleValid = true.obs;
  RxBool isDescriptionValid = true.obs;
  RxString uid = ''.obs;
  RxInt hoursTime = 0.obs;
  RxInt minuteTime = 0.obs;
  RxInt yearsDate = 0.obs;
  RxInt monthsDate = 0.obs;
  RxInt dayDate = 0.obs;

  @override
  void onInit() {
    super.onInit();
    ever(currentDateTime, (dateTime) {
      displayDate.value = DateFormat('dd-MM-yyyy').format(dateTime);
      yearsDate.value = dateTime.year;
      monthsDate.value = dateTime.month;
      dayDate.value = dateTime.day;
    });
  }
}
