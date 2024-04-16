import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:notely/Screens/To-Do/controller/todo_modal_controller.dart';
import 'package:notely/Screens/To-Do/view/ToDo%20Card%20Tile/view/todo_delete_dialog.dart';
import 'package:notely/Screens/To-Do/view/updated_todo_view.dart';

import '../../../../Welcome Page/controller/welcome_page_controller.dart';
import '../controller/todo_card_controller.dart';

// ignore: must_be_immutable
class ToDoCardTileGridView extends StatefulWidget {
  String? cardTitle;
  String? cardText;
  Color backgroundColor;
  String? docID;
  int listIndex;
  bool isFav = false;

  ToDoCardTileGridView({
    Key? key,
    this.cardText,
    this.cardTitle,
    required this.backgroundColor,
    required this.docID,
    required this.listIndex,
    required this.isFav,
  }) : super(key: key);

  @override
  State<ToDoCardTileGridView> createState() => _ToDoCardTileGridViewState();
}

class _ToDoCardTileGridViewState extends State<ToDoCardTileGridView> {
  bool isChecked = false;
  FirebaseAuth auth = FirebaseAuth.instance;
  final db = FirebaseFirestore.instance;
  TodoCardController todoCardController = Get.put(TodoCardController());
  TodoModalController todoModalController = Get.put(TodoModalController());
  WelcomePageController welcomePageController =
      Get.put(WelcomePageController());

  Color getColor(Set<MaterialState> states) {
    const Set<MaterialState> interactiveStates = <MaterialState>{
      MaterialState.pressed,
      MaterialState.focused,
    };
    if (states.any(interactiveStates.contains)) {
      return const Color(0xFFea5370);
    }
    if (isChecked == false) {
      return const Color(0xFFFFFFFF);
    }
    return const Color(0xFFea5370);
  }

  void _contextMenu(
      BuildContext context, Color backgroundColor,
      Color iconColor, Color heartIcon
      ) async {
    final RenderObject? overlay =
        Overlay.of(context).context.findRenderObject();
    final RenderBox cardBox = context.findRenderObject() as RenderBox;
    final Offset cardCenter =
        cardBox.localToGlobal(cardBox.size.center(Offset.zero));

    const double yOffset = -150;
    const double xOffset = -150;

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
        Rect.fromLTWH(0, 0, overlay!.paintBounds.size.width + 50,
            overlay.paintBounds.size.height),
      ),
      items: [
        PopupMenuItem<int>(
          value: 1,
          child: Center(
            child: SizedBox(
              width: 231,
              // To change the width of the PopUp Menu make changes here
              child: Row(
                children: [
                  Checkbox(
                    checkColor: const Color(0xFFFFFFFF),
                    fillColor: MaterialStateProperty.resolveWith(getColor),
                    side: const BorderSide(color: Color(0xFFea5370), width: 2),
                    value: isChecked,
                    onChanged: (bool? value) {
                      setState(() {
                        isChecked = value!;
                      });
                    },
                  ),
                  const SizedBox(
                    width: 20,
                  ),
                  GestureDetector(
                    onTap: () {
                      showModalBottomSheet(
                        context: context,
                        builder: (context) => UpdatedTodoView(
                          todocardTitle: widget.cardTitle,
                          todocardDescription: widget.cardText,
                          docID: widget.docID,
                        ),
                        backgroundColor: backgroundColor,
                        elevation: 30,
                        enableDrag: true,
                        isDismissible: false,
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
                            return TodoDeleteDialog(
                              onDeletePressed: () async {
                                try {
                                  await FirebaseFirestore.instance
                                      .collection(
                                          'ToDo Data for uid ${welcomePageController.uid.value}')
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
                      final CollectionReference todoCollection =
                          FirebaseFirestore.instance.collection(
                              "ToDo Data for uid ${welcomePageController.uid.value}");
                      final DocumentReference todoDocRef =
                          todoCollection.doc(widget.docID);
                      widget.isFav = !widget.isFav;
                      await todoDocRef.update({"isFav": widget.isFav});
                      setState(() {});
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
              : const Color(0XFF000000),
        );
      },
      child: Padding(
        padding: const EdgeInsets.only(left: 8, right: 8),
        child: Card(
          elevation: 16,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          color: widget.backgroundColor,
          margin: EdgeInsets.zero,
          child: Padding(
            padding: const EdgeInsets.all(22),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '${widget.cardTitle?.capitalize}',
                  style: TextStyle(
                    color: isChecked
                        ? const Color(0xFF808080)
                        : const Color(0xFF000000),
                    fontFamily: 'Alata',
                    fontWeight: FontWeight.w700,
                    fontSize: 28,
                    decoration: isChecked
                        ? TextDecoration.lineThrough
                        : TextDecoration.none,
                    decorationThickness: 2.5,
                    decorationColor: const Color(0xFFea5370),
                    overflow: TextOverflow.ellipsis,
                  ),
                  maxLines: 1,
                ),
                const SizedBox(
                  height: 5,
                ),
                Text(
                  '${widget.cardText}',
                  style: TextStyle(
                    color: isChecked
                        ? const Color(0xFF808080)
                        : const Color(0xFF444444),
                    fontFamily: 'Alata',
                    fontWeight: FontWeight.w400,
                    fontSize: 22,
                    decoration: isChecked
                        ? TextDecoration.lineThrough
                        : TextDecoration.none,
                    decorationThickness: 2.5,
                    decorationColor: const Color(0xFFea5370),
                    overflow: TextOverflow.ellipsis,
                  ),
                  maxLines: 2,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
