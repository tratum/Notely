import 'package:flutter/material.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);

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
                              color: theme.brightness == Brightness.dark
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
                                color: theme.brightness == Brightness.dark
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
}
