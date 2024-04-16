import 'package:flutter/material.dart';

// ignore: must_be_immutable
class ListTiles extends StatefulWidget {
  String? listtitle;
  String? listText;

  ListTiles({Key? key, this.listText, this.listtitle}) : super(key: key);

  @override
  State<ListTiles> createState() => _ListTilesState();
}

class _ListTilesState extends State<ListTiles> {
  bool isChecked = false;

  Color getColor(Set<MaterialState> states) {
    const Set<MaterialState> interactiveStates = <MaterialState>{
      MaterialState.pressed,
      MaterialState.focused,
    };
    if (states.any(interactiveStates.contains)) {
      return const Color(0xFFea5370);
    }
    return const Color(0xFFea5370);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 22, right: 22),
      child: ListTile(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(40)),
        tileColor: Theme.of(context).colorScheme.background,
        leading: Checkbox(
          checkColor: const Color(0xFFFFFFFF),
          fillColor: MaterialStateProperty.resolveWith(getColor),
          side: const BorderSide(color: Color(0xFF309FA5), width: 2.0),
          value: isChecked,
          onChanged: (bool? value) {
            setState(() {
              isChecked = value!;
            });
          },
        ),
        title: GestureDetector(
          onTap: () {
            setState(() {
              isChecked = true;
            });
          },
          child: SizedBox(
            height: 74,
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
                      top: 12,
                    ),
                    child: Text(
                      '${widget.listText}',
                      style: TextStyle(
                        color: isChecked
                            ? const Color(0xFF000000)
                            : const Color(0xFF309FA5),
                        fontFamily: 'Exo2',
                        fontWeight: FontWeight.w800,
                        fontSize: 18,
                        decoration: isChecked
                            ? TextDecoration.lineThrough
                            : TextDecoration.none,
                        decorationThickness: 2.5,
                        decorationColor: const Color(0xFFea5370),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
