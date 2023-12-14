import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

import '../../../../Welcome Page/controller/welcome_page_controller.dart';
import '../../../controller/note_modal_controller.dart';
import '../../note_view_update.dart';
import '../controller/note_card_controller.dart';
import 'note_delete_dialog.dart';

// ignore: must_be_immutable
class NoteCardTile extends StatefulWidget {
  String? noteTitle;
  String? noteText;
  Color backgroundColor;
  String? docID;
  int listIndex;
  String dateCreation;
  bool isFav;

  NoteCardTile({
    Key? key,
    this.noteText,
    this.noteTitle,
    required this.backgroundColor,
    required this.docID,
    required this.listIndex,
    required this.dateCreation,
    required this.isFav,
  }) : super(key: key);

  @override
  State<NoteCardTile> createState() => _NoteCardTileState();
}

class _NoteCardTileState extends State<NoteCardTile> {
  NoteCardController noteCardController = Get.put(NoteCardController());
  NoteModalController noteModalController = Get.put(NoteModalController());
  WelcomePageController welcomePageController =
      Get.put(WelcomePageController());

  void _contextMenu(BuildContext context, Color backgroundColor,
      Color iconColor, Color heartIcon) async {
    final RenderObject? overlay =
        Overlay.of(context).context.findRenderObject();
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
                      showModalBottomSheet(
                        context: context,
                        builder: (BuildContext context) {
                          return UpdatedNoteView(
                            docID: widget.docID,
                            noteTitle: widget.noteTitle,
                            noteDescription: widget.noteText,
                          );
                        },
                        isScrollControlled: true,
                      );
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
                      showDialog(
                          context: context,
                          builder: (context) {
                            return NoteDeleteDialog(
                              onDeletePressed: () async {
                                try {
                                  await FirebaseFirestore.instance
                                      .collection(
                                          'Notes Data for uid ${welcomePageController.uid.value}')
                                      .doc(widget.docID)
                                      .delete();
                                } catch (e) {
                                  if (kDebugMode) {
                                    print(
                                        "--------------------------------Error deleting document: ${e.toString()}");
                                  }
                                }
                              },
                            );
                          });
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
                      widget.isFav ? Icons.favorite : Icons.favorite_border,
                      size: 28,
                      color: const Color(0xFFea5370),
                    ),
                    onTap: () async {
                      final CollectionReference notesCollection =
                          FirebaseFirestore.instance.collection(
                              "Notes Data for uid ${welcomePageController.uid.value}");
                      final DocumentReference noteDocRef =
                          notesCollection.doc(widget.docID);
                      widget.isFav = !widget.isFav;
                      await noteDocRef.update({"isFav": widget.isFav});
                      setState(() {});
                    },
                  ),
                  const SizedBox(
                    width: 20,
                  ),
                  // Obx(
                  //   () => GestureDetector(
                  //     onTap: () {
                  //       noteCardController.favouriteNotes[widget.listIndex]
                  //               ['favorite'] =
                  //           !noteCardController.favouriteNotes[widget.listIndex]
                  //               ['favorite'];
                  //     },
                  //     child: Icon(
                  //       noteCardController.favouriteNotes[widget.listIndex]
                  //               ['favorite']
                  //           ? Icons.favorite
                  //           : Icons.favorite_border,
                  //       size: 30,
                  //       color: noteCardController
                  //               .favouriteNotes[widget.listIndex]['favorite']
                  //           ? const Color(0xFFea5370)
                  //           : heartIcon,
                  //     ),
                  //   ),
                  // ),
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
    ThemeData theme = Theme.of(context);

    return GestureDetector(
      onLongPress: () {
        _contextMenu(
            context,
            theme.brightness == Brightness.dark
                ? Theme.of(context).colorScheme.background
                : Theme.of(context).colorScheme.background,
            theme.brightness == Brightness.dark
                ? const Color(0XFFFFFFFF)
                : const Color(0XFF000000),
            theme.brightness == Brightness.dark
                ? const Color(0XFFFFFFFF)
                : const Color(0XFF000000));
      },
      child: Padding(
        padding: const EdgeInsets.only(left: 24, right: 24),
        child: Card(
          elevation: 4,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          color: widget.backgroundColor,
          child: Row(
            children: [
              Expanded(
                child: widget.noteTitle!.isEmpty
                    ? SizedBox(
                        height: 90,
                        child: ScrollbarTheme(
                          data: ScrollbarThemeData(
                            thumbColor: MaterialStateProperty.all(
                              const Color(0xFF555b6e),
                            ),
                          ),
                          child: Scrollbar(
                            thumbVisibility: false,
                            thickness: 5.0,
                            radius: const Radius.circular(8.0),
                            child: Padding(
                              padding: const EdgeInsets.only(
                                  left: 16, right: 12, top: 12),
                              child: SingleChildScrollView(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      '${widget.noteText}',
                                      style: TextStyle(
                                        color:
                                            theme.brightness == Brightness.dark
                                                ? const Color(0xFF8ba9a7)
                                                : const Color(0xFF000000),
                                        fontFamily: 'Alata',
                                        fontWeight: FontWeight.w400,
                                        fontSize: 16,
                                        // overflow: TextOverflow.ellipsis,
                                      ),
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                    widget.noteText!.length >= 15
                                        ? const SizedBox(
                                            height: 20,
                                          )
                                        : const SizedBox(
                                            height: 10,
                                          ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        const SizedBox(
                                          width: 2,
                                        ),
                                        const FaIcon(
                                          FontAwesomeIcons.rotate,
                                          size: 10,
                                          color: Color(0xFF555b6e),
                                        ),
                                        const SizedBox(
                                          width: 10,
                                        ),
                                        Text(
                                          widget.dateCreation,
                                          style: TextStyle(
                                            color: theme.brightness ==
                                                    Brightness.dark
                                                ? const Color(0xFF8ba9a7)
                                                : const Color(0xFF000000),
                                            fontFamily: 'Alata',
                                            fontWeight: FontWeight.w400,
                                            fontSize: 10,
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(
                                      height: 8,
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      )
                    : SizedBox(
                        height: 125,
                        child: ScrollbarTheme(
                          data: ScrollbarThemeData(
                            thumbColor: MaterialStateProperty.all(
                              const Color(0xFF555b6e),
                            ),
                          ),
                          child: Scrollbar(
                            thumbVisibility: false,
                            thickness: 5.0,
                            radius: const Radius.circular(8.0),
                            child: SingleChildScrollView(
                              child: Padding(
                                padding: const EdgeInsets.only(
                                    left: 16, right: 12, top: 12),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      '${widget.noteTitle?.capitalize}',
                                      style: TextStyle(
                                        color:
                                            theme.brightness == Brightness.dark
                                                ? const Color(0xFFFDEADE)
                                                : const Color(0xFF000000),
                                        fontFamily: 'Alata',
                                        fontWeight: FontWeight.w700,
                                        fontSize: 24,
                                      ),
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                    const SizedBox(
                                      height: 6,
                                    ),
                                    Text(
                                      '${widget.noteText}',
                                      style: TextStyle(
                                        color:
                                            theme.brightness == Brightness.dark
                                                ? const Color(0xFF8ba9a7)
                                                : const Color(0xFF000000),
                                        fontFamily: 'Alata',
                                        fontWeight: FontWeight.w400,
                                        fontSize: 16,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                      maxLines: 2,
                                    ),
                                    widget.noteText!.length >= 15
                                        ? const SizedBox(
                                            height: 20,
                                          )
                                        : const SizedBox(
                                            height: 10,
                                          ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        const SizedBox(
                                          width: 2,
                                        ),
                                        const FaIcon(
                                          FontAwesomeIcons.rotate,
                                          size: 10,
                                          color: Color(0xFF555b6e),
                                        ),
                                        const SizedBox(
                                          width: 10,
                                        ),
                                        Text(
                                          widget.dateCreation,
                                          style: TextStyle(
                                            color: theme.brightness ==
                                                    Brightness.dark
                                                ? const Color(0xFF8ba9a7)
                                                : const Color(0xFF000000),
                                            fontFamily: 'Alata',
                                            fontWeight: FontWeight.w400,
                                            fontSize: 10,
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                        )
                                      ],
                                    ),
                                    const SizedBox(
                                      height: 8,
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
