import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

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

ThemeData getTheme(BuildContext context) {
  return Theme.of(context);
}

bool largeTileIdentifier(int index) {
  int patternLength = 3; // Length of the pattern
  int cycleIndex = index ~/ patternLength; // Determine which cycle we're in
  int patternIndex =
      index % patternLength; // Determine the index within the cycle
  if (cycleIndex % 2 == 0) {
    // Normal pattern: [Large, Small, Small]
    return patternIndex == 0;
  } else {
    // Inverted pattern: [Small, Large, Small]
    return patternIndex == 1;
  }
}

void errorSnackbar(BuildContext context, String errorMessage) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      duration: const Duration(milliseconds: 3000),
      dismissDirection: DismissDirection.none,
      behavior: SnackBarBehavior.floating,
      backgroundColor: Colors.transparent,
      clipBehavior: Clip.antiAliasWithSaveLayer,
      content: GestureDetector(
        onTap: () {
          ScaffoldMessenger.of(context).hideCurrentSnackBar();
        },
        child: Stack(clipBehavior: Clip.none, children: [
          Container(
            padding: const EdgeInsets.all(24),
            height: 90,
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(20)),
              color: Color(0XFF800020),
              image: DecorationImage(
                image: NetworkImage(
                    'https://tratum.github.io/cloud-asset-storage/images/notely/skull.pattern.png'),
                fit: BoxFit.scaleDown,
                alignment: Alignment.center,
                repeat: ImageRepeat.repeat,
              ),
            ),
            child: Row(
              children: [
                const SizedBox(
                  width: 48,
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "Oh! Snap",
                        textAlign: TextAlign.start,
                        softWrap: true,
                        style: TextStyle(
                          fontFamily: 'Alata',
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                          fontStyle: FontStyle.normal,
                          decoration: TextDecoration.none,
                          color: Color(0xFFFFFFFF),
                        ),
                      ),
                      const SizedBox(
                        height: 4,
                      ),
                      Text(
                        // 'Blank Canvas, Ready to Be Filled with Your Productivity!',
                        errorMessage,
                        textAlign: TextAlign.start,
                        softWrap: true,
                        style: const TextStyle(
                          fontFamily: 'Alata',
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                          fontStyle: FontStyle.normal,
                          decoration: TextDecoration.none,
                          color: Color(0xFFFFFFFF),
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            top: -19,
            left: 0,
            child: Image.network(
              'https://tratum.github.io/cloud-asset-storage/images/notely/bubble.png',
              height: 40,
              width: 40,
            ),
          ),
        ]),
      ),
    ),
  );
}

void contextMenu(BuildContext context, Color backgroundColor, Color iconColor,
    Color bookmarkIcon, bool isBookmarked) async {
  final RenderObject? overlay = Overlay.of(context).context.findRenderObject();
  final RenderBox cardBox = context.findRenderObject() as RenderBox;
  final Offset cardCenter =
      cardBox.localToGlobal(cardBox.size.center(Offset.zero));

  const double yOffset = -80;
  const double xOffset = -110;

  await showMenu(
    context: context,
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
            width: 180,
            child: Row(
              children: [
                const SizedBox(
                  width: 10,
                ),
                GestureDetector(
                  onTap: () {
                    // showModalBottomSheet(
                    //   context: context,
                    //   builder: (BuildContext context) {
                    //     return UpdatedNoteView(
                    //       docID: widget.docID,
                    //       noteTitle: widget.noteTitle,
                    //       noteDescription: widget.noteText,
                    //     );
                    //   },
                    //   isScrollControlled: true,
                    // );
                  },
                  child: Icon(
                    Icons.open_in_new,
                    size: 27,
                    color: iconColor,
                  ),
                ),
                const SizedBox(
                  width: 30,
                ),
                GestureDetector(
                  onTap: () {
                    // showDialog(
                    //     context: context,
                    //     builder: (context) {
                    //       return NoteDeleteDialog(
                    //         onDeletePressed: () async {
                    //           try {
                    //             await FirebaseFirestore.instance
                    //                 .collection(
                    //                 'Notes Data for uid ${welcomePageController.uid.value}')
                    //                 .doc(widget.docID)
                    //                 .delete();
                    //           } catch (e) {
                    //             if (kDebugMode) {
                    //               print(
                    //                   "--------------------------------Error deleting document: ${e.toString()}");
                    //             }
                    //           }
                    //         },
                    //       );
                    //     }
                    //     );
                  },
                  child: const Icon(
                    Icons.delete_forever_rounded,
                    size: 28,
                    color: Color(0xFFea5370),
                  ),
                ),
                const SizedBox(
                  width: 30,
                ),
                GestureDetector(
                  child: Icon(
                    isBookmarked ? Icons.bookmark_rounded : Icons.bookmark_border_rounded,
                    size: 28,
                    color: const Color(0xFFea5370),
                  ),
                  onTap: () async {
                    // final CollectionReference notesCollection =
                    // FirebaseFirestore.instance.collection(
                    //     "Notes Data for uid ${welcomePageController.uid.value}");
                    // final DocumentReference noteDocRef =
                    // notesCollection.doc(widget.docID);
                    // widget.isFav = !widget.isFav;
                    // await noteDocRef.update({"isFav": widget.isFav});
                    // setState(() {});
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
