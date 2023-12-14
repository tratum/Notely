import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

class WelcomePageController extends GetxController {
  RxString uid = ''.obs;
  RxList<QueryDocumentSnapshot<Map<String, dynamic>>> noteData =
      <QueryDocumentSnapshot<Map<String, dynamic>>>[].obs;
  RxList<QueryDocumentSnapshot<Map<String, dynamic>>> todoData =
      <QueryDocumentSnapshot<Map<String, dynamic>>>[].obs;
}
