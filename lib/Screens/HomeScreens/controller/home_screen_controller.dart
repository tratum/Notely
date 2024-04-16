import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

class HomeScreenController extends GetxController {
  RxBool isDarkmode = false.obs;
  Rx<Stream<QuerySnapshot<Map<String, dynamic>>>> noteStream =
      Rx<Stream<QuerySnapshot<Map<String, dynamic>>>>(
          const Stream<QuerySnapshot<Map<String, dynamic>>>.empty());
  RxInt noteLength = 0.obs;
  RxInt todoLength = 0.obs;
}
