import 'package:get/get.dart';

import '../../services/firestore.service.dart';

class NoteController extends GetxController {
  var bookmarks = <String, RxBool>{}.obs;

  void toggleBookmark(String docID) {
    if (bookmarks.containsKey(docID)) {
      bookmarks[docID]!.value = !bookmarks[docID]!.value;
    } else {
      bookmarks[docID] = RxBool(true);
    }
    DatabaseHandler.bookmarkNotes(Get.context!, docID, bookmarks[docID]!.value);
  }
}
