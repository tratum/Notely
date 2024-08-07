import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../app/app.common.functions.dart';

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
  final String? docID;
  final String createdAt;
  final bool isBookmarked;

  const NoteCards({
    super.key,
    this.heading,
    required this.description,
    required this.backgroundColor,
    required this.docID,
    required this.createdAt,
    required this.isBookmarked,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onLongPress: () {
        contextMenu(
            context,
            getTheme(context).brightness == Brightness.dark
                ? Theme.of(context).colorScheme.surface
                : Theme.of(context).colorScheme.surface,
            getTheme(context).brightness == Brightness.dark
                ? const Color(0XFFFFFFFF)
                : const Color(0XFF000000),
            getTheme(context).brightness == Brightness.dark
                ? const Color(0XFFFFFFFF)
                : const Color(0XFF000000),
            isBookmarked);
      },
      child: Padding(
        padding: const EdgeInsets.only(left: 24, right: 24),
        child: Card(
          elevation: 4,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          color: backgroundColor,
          child: Row(
            children: [
              Expanded(
                child: heading!.isEmpty
                    ? SizedBox(
                        height: 130,
                        child: Padding(
                          padding: const EdgeInsets.only(
                              left: 16, right: 12, top: 22, bottom: 8),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                description,
                                style: TextStyle(
                                  color: getTheme(context).brightness ==
                                          Brightness.dark
                                      ? const Color(0xFF8ba9a7)
                                      : const Color(0xFF000000),
                                  fontFamily: 'Alata',
                                  fontWeight: FontWeight.w400,
                                  fontSize: 16,
                                  // overflow: TextOverflow.ellipsis,
                                ),
                                maxLines: 3,
                                overflow: TextOverflow.fade,
                              ),
                              const Spacer(),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
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
                                    createdAt,
                                    style: TextStyle(
                                      color: getTheme(context).brightness ==
                                              Brightness.dark
                                          ? const Color(0xFF8ba9a7)
                                          : const Color(0xFF000000),
                                      fontFamily: 'Alata',
                                      fontWeight: FontWeight.w400,
                                      fontSize: 10,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                  const Spacer(),
                                  isBookmarked == true
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
                              const SizedBox(
                                height: 8,
                              )
                            ],
                          ),
                        ),
                      )
                    : SizedBox(
                        height: 160,
                        child: Padding(
                          padding: const EdgeInsets.only(
                              left: 16, right: 12, top: 12, bottom: 8),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                '$heading',
                                maxLines: 1,
                                overflow: TextOverflow.fade,
                                style: TextStyle(
                                  color: getTheme(context).brightness ==
                                          Brightness.dark
                                      ? const Color(0xFFFDEADE)
                                      : const Color(0xFF000000),
                                  fontFamily: 'Alata',
                                  fontWeight: FontWeight.w700,
                                  fontSize: 24,
                                ),
                              ),
                              const SizedBox(
                                height: 18,
                              ),
                              Text(
                                description,
                                maxLines: 3,
                                overflow: TextOverflow.fade,
                                style: TextStyle(
                                  color: getTheme(context).brightness ==
                                          Brightness.dark
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
                                    createdAt,
                                    style: TextStyle(
                                      color: getTheme(context).brightness ==
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
                            ],
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

class ToDoCards extends StatelessWidget {
  final String? heading;
  final String? description;
  final Color backgroundColor;
  final String? docID;
  final bool isBookmarked;
  final int maxLines;
  final bool isChecked;

  const ToDoCards({
    this.heading,
    required this.description,
    required this.backgroundColor,
    required this.docID,
    required this.isBookmarked,
    this.maxLines = 2,
    this.isChecked = false,
    super.key,
  });

  void todoContextMenu(BuildContext context, Color backgroundColor,
      Color heartIcon, bool isBookmarked) async {
    final RenderObject? overlay =
        Overlay.of(context).context.findRenderObject();
    final RenderBox cardBox = context.findRenderObject() as RenderBox;
    final Offset cardCenter =
        cardBox.localToGlobal(cardBox.size.center(Offset.zero));

    const double yOffset = -150;
    const double xOffset = -150;

    Color getColor(Set<WidgetState> states) {
      const Set<WidgetState> interactiveStates = <WidgetState>{
        WidgetState.pressed,
        WidgetState.focused,
      };
      if (states.any(interactiveStates.contains)) {
        return const Color(0xFFea5370);
      }
      return const Color(0XFFFFFFFF);
    }

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
              width: 220,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Checkbox(
                    checkColor: const Color(0xFFFFFFFF),
                    fillColor: WidgetStateProperty.resolveWith(getColor),
                    side: const BorderSide(color: Color(0xFFea5370), width: 2),
                    value: isChecked,
                    onChanged: (bool? value) {
                      // Handle checkbox change if needed
                    },
                  ),
                  const Spacer(),
                  GestureDetector(
                    onTap: () {
                      // Handle open in new action if needed
                    },
                    child: const Icon(
                      Icons.open_in_new,
                      size: 27,
                      color: Color(0xFFea5370),
                    ),
                  ),
                  const Spacer(),
                  GestureDetector(
                    onTap: () {
                      // Handle delete action if needed
                    },
                    child: const Icon(
                      Icons.delete_forever_rounded,
                      size: 28,
                      color: Color(0xFFea5370),
                    ),
                  ),
                  const Spacer(),
                  GestureDetector(
                    child: Icon(
                      isBookmarked ? Icons.bookmark_rounded : Icons.bookmark_border_rounded,
                      size: 28,
                      color: const Color(0xFFea5370),
                    ),
                    onTap: () async {
                      // Handle favorite action if needed
                    },
                  ),
                  const Spacer(),
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
      onLongPress: () {
        todoContextMenu(
          context,
          Theme.of(context).brightness == Brightness.dark
              ? Theme.of(context).colorScheme.surface
              : Theme.of(context).colorScheme.surface,
          Theme.of(context).brightness == Brightness.dark
              ? const Color(0XFFFFFFFF)
              : const Color(0XFF000000),
          isBookmarked,
        );
      },
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
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '$heading',
                  style: TextStyle(
                    color: isChecked
                        ? const Color(0xFF808080)
                        : const Color(0xFF000000),
                    fontFamily: 'Alata',
                    fontWeight: FontWeight.w700,
                    fontSize: 24,
                    decoration: isChecked
                        ? TextDecoration.lineThrough
                        : TextDecoration.none,
                    decorationThickness: 2.5,
                    decorationColor: const Color(0xFFea5370),
                  ),
                  overflow: TextOverflow.fade,
                  maxLines: 1,
                ),
                const SizedBox(
                  height: 10,
                ),
                Text(
                  '$description',
                  style: TextStyle(
                    color: isChecked
                        ? const Color(0xFF808080)
                        : const Color(0xFF444444),
                    fontFamily: 'Alata',
                    fontWeight: FontWeight.w400,
                    fontSize: 16,
                    decoration: isChecked
                        ? TextDecoration.lineThrough
                        : TextDecoration.none,
                    decorationThickness: 2.5,
                    decorationColor: const Color(0xFFea5370),
                  ),
                  overflow: TextOverflow.fade,
                  maxLines: maxLines,
                ),
                const Spacer(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    isBookmarked
                        ? const Icon(
                            Icons.bookmark_rounded,
                            size: 18,
                            color: Color(0xFFea5370),
                          )
                        : Icon(
                            Icons.bookmark_border_rounded,
                            size: 18,
                            color: backgroundColor,
                          ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
