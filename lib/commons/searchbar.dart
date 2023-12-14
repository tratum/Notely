import 'package:flutter/material.dart';

class SearchBarWidget extends StatefulWidget {
  const SearchBarWidget({Key? key}) : super(key: key);

  @override
  State<SearchBarWidget> createState() => _SearchBarWidgetState();
}

class _SearchBarWidgetState extends State<SearchBarWidget> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 60,
      child: Center(
        child: TextField(
          cursorColor: const Color(0XFF000000),
          cursorRadius: const Radius.circular(4),
          textDirection: TextDirection.ltr,
          style: Theme.of(context).textTheme.titleMedium,
          decoration: InputDecoration(
            filled: true,
            fillColor: Theme.of(context).colorScheme.background,
            contentPadding: const EdgeInsets.only(top: 20, bottom: 20),
            hintText: 'Search',
            hintStyle: Theme.of(context).textTheme.titleMedium,
            prefixIcon: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                const SizedBox(width: 18),
                const Icon(
                  Icons.search_outlined,
                  color: Color(0XFF45c2c9),
                  size: 26,
                ),
                const SizedBox(width: 14),
                Container(
                  width: 1,
                  height: 60,
                  color: const Color(
                      0XFF808080), // Customize the color of the vertical line here
                ),
                const SizedBox(width: 18),
              ],
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(40),
              borderSide: const BorderSide(color: Color(0XFF808080), width: 1),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(40),
              borderSide: const BorderSide(color: Color(0XFF808080), width: 1),
            ),
          ),
        ),
      ),
    );
  }
}
