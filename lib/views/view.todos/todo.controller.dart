import 'package:get/get.dart';

import '../../services/firestore.service.dart';

class ToDoController extends GetxController {
  var bookmarks = <String, RxBool>{}.obs;
  var completionStatus = <String, RxBool>{}.obs;

  void toggleBookmark(String docID) {
    if (bookmarks.containsKey(docID)) {
      bookmarks[docID]!.value = !bookmarks[docID]!.value;
    } else {
      bookmarks[docID] = RxBool(true);
    }
    DatabaseHandler.bookmarkTodos(Get.context!, docID, bookmarks[docID]!.value);
  }

  void toggleCompletionStatus(String docID) {
    if (completionStatus.containsKey(docID)) {
      completionStatus[docID]!.value = !completionStatus[docID]!.value;
    } else {
      completionStatus[docID] = RxBool(true);
    }
    DatabaseHandler.markToDoAsCompleted(
        Get.context!, docID, completionStatus[docID]!.value);
  }
}
