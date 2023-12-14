import 'package:get/get.dart';

class TodoCardController extends GetxController {
  RxBool isfav = false.obs;
  RxList<Map<String, dynamic>> favouriteTodo = <Map<String, dynamic>>[].obs;
}
