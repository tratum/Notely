import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

import '../../bottomsheets/bottomsheet.updated.note.dart';
import '../../bottomsheets/bottomsheet.updated.todo.dart';
import '../../dialogs/dialog.delete.note.dart';
import '../../views/view.notes/note.controller.dart';
import '../../views/view.todos/todo.controller.dart';
import '../app/app.common.functions.dart';
import '../dialogs/dialog.delete.todo.dart';

Widget noteViewSkelton() {
  return ListView.separated(
    itemBuilder: (context, index) => Padding(
        padding: const EdgeInsets.only(left: 24, bottom: 8, right: 24),
        child: Column(
          children: [
            Container(
              height: 100,
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                  color: Colors.black.withOpacity(0.04),
                  borderRadius: const BorderRadius.all(Radius.circular(16))),
            ),
          ],
        )),
    separatorBuilder: (context, index) => const SizedBox(height: 16),
    itemCount: 5,
  );
}

Widget todoViewSkelton() {
  return ListView.separated(
    itemBuilder: (context, index) => Padding(
      padding: const EdgeInsets.only(left: 8, bottom: 8),
      child: Row(children: [
        Container(
          height: 260,
          width: 246,
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
              color: Colors.black.withOpacity(0.04),
              borderRadius: const BorderRadius.all(Radius.circular(16))),
        ),
        const SizedBox(
          width: 8,
        ),
        Column(
          children: [
            Container(
              height: 123,
              width: 130,
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                  color: Colors.black.withOpacity(0.04),
                  borderRadius: const BorderRadius.all(Radius.circular(16))),
            ),
            const SizedBox(
              height: 8,
            ),
            Container(
              height: 123,
              width: 130,
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                  color: Colors.black.withOpacity(0.04),
                  borderRadius: const BorderRadius.all(Radius.circular(16))),
            ),
          ],
        )
      ]),
    ),
    separatorBuilder: (context, index) => const SizedBox(
      height: 8,
    ),
    itemCount: 2,
  );
}

Widget searchBar(BuildContext context) {
  return SafeArea(
    child: SizedBox(
      width: MediaQuery.of(context).size.width,
      child: AlertDialog(
        alignment: Alignment.topCenter,
        elevation: 1,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(0),
        ),
        insetPadding: EdgeInsets.zero,
        contentPadding: EdgeInsets.zero,
        clipBehavior: Clip.antiAliasWithSaveLayer,
        backgroundColor: Theme.of(context).colorScheme.primary,
        content: SafeArea(
          child: SizedBox(
            width: MediaQuery.of(context).size.width,
            height: 54,
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    autofocus: true,
                    cursorColor: const Color(0XFF000000),
                    cursorRadius: const Radius.circular(4),
                    textDirection: TextDirection.ltr,
                    style: Theme.of(context).textTheme.titleMedium,
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Theme.of(context).colorScheme.primary,
                      contentPadding: const EdgeInsets.only(
                        top: 12,
                        bottom: 14,
                        left: 20,
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30),
                        borderSide: const BorderSide(
                          color: Colors.transparent,
                        ),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30),
                        borderSide: const BorderSide(
                          color: Colors.transparent,
                        ),
                      ),
                      border: const OutlineInputBorder(
                        borderSide: BorderSide.none,
                      ),
                      hintText: 'Search Notes',
                      hintStyle: Theme.of(context).textTheme.titleMedium,
                      suffixIcon: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const SizedBox(width: 14),
                          Container(
                            width: 1,
                            height: 20,
                            color:
                                getTheme(context).brightness == Brightness.dark
                                    ? const Color(0xFFFDEADE)
                                    : const Color(0XFF808080),
                          ),
                          const SizedBox(width: 18),
                          GestureDetector(
                            onTap: () {
                              Navigator.pop(context);
                            },
                            child: Icon(
                              Icons.cancel,
                              color: getTheme(context).brightness ==
                                      Brightness.dark
                                  ? const Color(0xFFFDEADE)
                                  : const Color(0XFF808080),
                              size: 24,
                            ),
                          ),
                          const SizedBox(width: 14),
                        ],
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

class NoteCards extends StatelessWidget {
  final String? heading;
  final String description;
  final Color backgroundColor;
  final String docID;
  final String createdAt;
  final bool isBookmarked;

  NoteCards({
    super.key,
    this.heading,
    required this.description,
    required this.backgroundColor,
    required this.docID,
    required this.createdAt,
    required this.isBookmarked,
  });

  final NoteController noteConn = Get.put(NoteController());

  void noteContextMenu(BuildContext context) async {
    final RenderObject? overlay =
        Overlay.of(context).context.findRenderObject();
    final RenderBox cardBox = context.findRenderObject() as RenderBox;
    final Offset cardCenter =
        cardBox.localToGlobal(cardBox.size.center(Offset.zero));

    const double yOffset = -80;
    const double xOffset = -110;

    await showMenu(
      context: context,
      color: getTheme(context).colorScheme.surface,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
      position: RelativeRect.fromRect(
        Rect.fromPoints(
          Offset(
            cardCenter.dx + xOffset, // Adjust the x position
            cardCenter.dy + yOffset,
          ),
          Offset(
            cardCenter.dx + xOffset, // Adjust the x position
            cardCenter.dy + yOffset,
          ),
        ),
        Rect.fromLTWH(0, 0, overlay!.paintBounds.size.width,
            overlay.paintBounds.size.height),
      ),
      items: [
        PopupMenuItem<int>(
          value: 1,
          child: Center(
            child: SizedBox(
              width: 160,
              child: Row(
                children: [
                  const SizedBox(
                    width: 5,
                  ),
                  GestureDetector(
                    onTap: () => showModalBottomSheet(
                      context: context,
                      isScrollControlled: true,
                      builder: (BuildContext context) => UpdatedNoteBottomsheet(
                        heading: heading,
                        description: description,
                        docID: docID,
                        isBookmarked: isBookmarked,
                      ),
                      shape: const ContinuousRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(20))),
                      backgroundColor:
                          getTheme(context).brightness == Brightness.dark
                              ? Theme.of(context).colorScheme.surface
                              : Theme.of(context).colorScheme.surface,
                      useSafeArea: true,
                    ),
                    child: Icon(
                      Icons.open_in_new,
                      size: 27,
                      color: getTheme(context).brightness == Brightness.dark
                          ? const Color(0XFFFFFFFF)
                          : const Color(0XFF000000),
                    ),
                  ),
                  const Spacer(),
                  GestureDetector(
                    onTap: () {
                      showDialog(
                        context: context,
                        builder: (context) => NoteDeleteDialog(
                          docID: docID,
                        ),
                      );
                    },
                    child: const Icon(
                      Icons.delete_forever_rounded,
                      size: 28,
                      color: Color(0xFFea5370),
                    ),
                  ),
                  const Spacer(),
                  GestureDetector(
                    child: Obx(
                      () => Icon(
                        noteConn.bookmarks[docID]?.value ?? isBookmarked
                            ? Icons.bookmark_rounded
                            : Icons.bookmark_border_rounded,
                        size: 28,
                        color: const Color(0xFFea5370),
                      ),
                    ),
                    onTap: () async {
                      noteConn.toggleBookmark(docID);
                    },
                  ),
                  const SizedBox(
                    width: 5,
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onLongPress: () => noteContextMenu(context),
      child: Padding(
        padding: const EdgeInsets.only(left: 24, right: 24),
        child: Card(
          elevation: 4,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          color: backgroundColor,
          child: Obx(
            () => SizedBox(
              height: heading!.isEmpty ? 140 : 170,
              child: Padding(
                padding: EdgeInsets.only(
                    left: 16,
                    right: 12,
                    top: heading!.isEmpty ? 22 : 16,
                    bottom: 8),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if (heading!.isNotEmpty)
                      Text(
                        heading!,
                        maxLines: 2,
                        overflow: TextOverflow.fade,
                        style: TextStyle(
                          color: getTheme(context).brightness == Brightness.dark
                              ? const Color(0xFFFDEADE)
                              : const Color(0xFF000000),
                          fontFamily: 'Alata',
                          fontWeight: FontWeight.w700,
                          fontSize: 20,
                        ),
                      ),
                    if (heading!.isNotEmpty)
                      const SizedBox(
                        height: 18,
                      ),
                    Text(
                      description,
                      maxLines: 3,
                      overflow: TextOverflow.fade,
                      style: TextStyle(
                        color: getTheme(context).brightness == Brightness.dark
                            ? const Color(0xFF8ba9a7)
                            : const Color(0xFF000000),
                        fontFamily: 'Alata',
                        fontWeight: FontWeight.w400,
                        fontSize: 16,
                      ),
                    ),
                    const Spacer(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        const SizedBox(width: 2),
                        const FaIcon(
                          FontAwesomeIcons.rotate,
                          size: 10,
                          color: Color(0xFF555b6e),
                        ),
                        const SizedBox(width: 10),
                        Text(
                          createdAt,
                          style: TextStyle(
                            color:
                                getTheme(context).brightness == Brightness.dark
                                    ? const Color(0xFF8ba9a7)
                                    : const Color(0xFF000000),
                            fontFamily: 'Alata',
                            fontWeight: FontWeight.w400,
                            fontSize: 10,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        const Spacer(),
                        noteConn.bookmarks[docID]?.value ?? isBookmarked
                            ? const Icon(
                                Icons.bookmark_rounded,
                                size: 10,
                                color: Color(0xFFea5370),
                              )
                            : const Icon(
                                Icons.bookmark_border_rounded,
                                size: 10,
                                color: Color(0XFFFFFFFF),
                              ),
                      ],
                    ),
                    const SizedBox(height: 4),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class ToDoCards extends StatelessWidget {
  final String? heading;
  final String description;
  final Color backgroundColor;
  final String docID;
  final bool isBookmarked;
  final int maxLines;
  final bool completionStatus;

  ToDoCards({
    this.heading,
    this.maxLines = 2,
    required this.docID,
    required this.description,
    required this.isBookmarked,
    required this.backgroundColor,
    required this.completionStatus,
    super.key,
  });

  final ToDoController todoConn = Get.put(ToDoController());

  void todoContextMenu(BuildContext context) async {
    final RenderObject? overlay =
        Overlay.of(context).context.findRenderObject();
    final RenderBox cardBox = context.findRenderObject() as RenderBox;
    final Offset cardCenter =
        cardBox.localToGlobal(cardBox.size.center(Offset.zero));

    const double yOffset = -150;
    const double xOffset = -150;

    await showMenu(
      context: context,
      elevation: 20,
      color: Theme.of(context).brightness == Brightness.dark
          ? const Color(0XFF000000)
          : const Color(0XFFFFFFFF),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
      position: RelativeRect.fromRect(
        Rect.fromPoints(
          Offset(cardCenter.dx + xOffset, cardCenter.dy + yOffset),
          Offset(cardCenter.dx + xOffset, cardCenter.dy + yOffset),
        ),
        Rect.fromLTWH(0, 0, overlay!.paintBounds.size.width + 50,
            overlay.paintBounds.size.height),
      ),
      items: [
        PopupMenuItem<int>(
          value: 1,
          child: Center(
            child: SizedBox(
              width: 200,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(
                    width: 20,
                  ),
                  GestureDetector(
                    child: Obx(
                      () => Icon(
                        todoConn.completionStatus[docID]?.value ??
                                completionStatus
                            ? Icons.check_box_rounded
                            : Icons.check_box_outline_blank_rounded,
                        size: 26,
                        color: const Color(0xFFea5370),
                      ),
                    ),
                    onTap: () async {
                      todoConn.toggleCompletionStatus(docID);
                    },
                  ),
                  const Spacer(),
                  GestureDetector(
                    onTap: () => showModalBottomSheet(
                      context: context,
                      builder: (context) => UpdatedTodoBottomsheet(
                          docID: docID,
                          heading: heading,
                          description: description,
                          isBookmarked: isBookmarked),
                      backgroundColor: getTheme(context).colorScheme.surface,
                      elevation: 30,
                      useSafeArea: true,
                      enableDrag: false,
                      isDismissible: false,
                    ),
                    child: Icon(
                      Icons.open_in_new,
                      size: 22,
                      color: getTheme(context).brightness == Brightness.dark
                          ? const Color(0XFFFFFFFF)
                          : const Color(0XFF000000),
                    ),
                  ),
                  const Spacer(),
                  GestureDetector(
                    onTap: () {
                      showDialog(
                        context: context,
                        builder: (context) => ToDoDeleteDialog(
                          docID: docID,
                        ),
                      );
                    },
                    child: const Icon(
                      Icons.delete_forever_rounded,
                      size: 26,
                      color: Color(0xFFea5370),
                    ),
                  ),
                  const Spacer(),
                  GestureDetector(
                    child: Obx(
                      () => Icon(
                        todoConn.bookmarks[docID]?.value ?? isBookmarked
                            ? Icons.bookmark_rounded
                            : Icons.bookmark_border_rounded,
                        size: 26,
                        color: const Color(0xFFea5370),
                      ),
                    ),
                    onTap: () async {
                      todoConn.toggleBookmark(docID);
                    },
                  ),
                  const SizedBox(
                    width: 20,
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onLongPress: () => todoContextMenu(context),
      child: Container(
        constraints: const BoxConstraints(
          maxWidth: double.maxFinite,
          maxHeight: double.maxFinite,
        ),
        padding: const EdgeInsets.only(left: 8, right: 8),
        child: Card(
          elevation: 16,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          color: backgroundColor,
          margin: EdgeInsets.zero,
          child: Padding(
            padding: const EdgeInsets.all(22),
            child: heading!.isEmpty
                ? Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Obx(
                        () => Text(
                          description,
                          style: TextStyle(
                            color: todoConn.completionStatus[docID]?.value ??
                                    completionStatus
                                ? const Color(0xFF808080)
                                : const Color(0xFF444444),
                            fontFamily: 'Alata',
                            fontWeight: FontWeight.w400,
                            fontSize: 16,
                            decoration:
                                todoConn.completionStatus[docID]?.value ??
                                        completionStatus
                                    ? TextDecoration.lineThrough
                                    : TextDecoration.none,
                            decorationThickness: 2.5,
                            decorationColor: const Color(0xFFea5370),
                          ),
                          overflow: TextOverflow.fade,
                          maxLines: maxLines + 2,
                        ),
                      ),
                      const Spacer(),
                      Obx(
                        () => Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            todoConn.bookmarks[docID]?.value ?? isBookmarked
                                ? const Icon(
                                    Icons.bookmark_rounded,
                                    size: 14,
                                    color: Color(0xFFea5370),
                                  )
                                : Icon(
                                    Icons.bookmark_border_rounded,
                                    size: 14,
                                    color: backgroundColor,
                                  ),
                          ],
                        ),
                      ),
                    ],
                  )
                : Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Obx(
                        () => Text(
                          '$heading',
                          style: TextStyle(
                            color: todoConn.completionStatus[docID]?.value ??
                                    completionStatus
                                ? const Color(0xFF808080)
                                : const Color(0xFF000000),
                            fontFamily: 'Alata',
                            fontWeight: FontWeight.w700,
                            fontSize: 24,
                            decoration:
                                todoConn.completionStatus[docID]?.value ??
                                        completionStatus
                                    ? TextDecoration.lineThrough
                                    : TextDecoration.none,
                            decorationThickness: 2.5,
                            decorationColor: const Color(0xFFea5370),
                          ),
                          overflow: TextOverflow.fade,
                          maxLines: 1,
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Obx(
                        () => Text(
                          description,
                          style: TextStyle(
                            color: todoConn.completionStatus[docID]?.value ??
                                    completionStatus
                                ? const Color(0xFF808080)
                                : const Color(0xFF444444),
                            fontFamily: 'Alata',
                            fontWeight: FontWeight.w400,
                            fontSize: 16,
                            decoration:
                                todoConn.completionStatus[docID]?.value ??
                                        completionStatus
                                    ? TextDecoration.lineThrough
                                    : TextDecoration.none,
                            decorationThickness: 2.5,
                            decorationColor: const Color(0xFFea5370),
                          ),
                          overflow: TextOverflow.fade,
                          maxLines: maxLines,
                        ),
                      ),
                      const Spacer(),
                      Obx(
                        () => Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            todoConn.bookmarks[docID]?.value ?? isBookmarked
                                ? const Icon(
                                    Icons.bookmark_rounded,
                                    size: 14,
                                    color: Color(0xFFea5370),
                                  )
                                : Icon(
                                    Icons.bookmark_border_rounded,
                                    size: 14,
                                    color: backgroundColor,
                                  ),
                          ],
                        ),
                      ),
                    ],
                  ),
          ),
        ),
      ),
    );
  }
}
