import 'package:get/get.dart';

class NoteCardController extends GetxController {
  RxBool isfav = true.obs;
  RxList<Map<String, dynamic>> favouriteNotes = <Map<String, dynamic>>[].obs;
}
