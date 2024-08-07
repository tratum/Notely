import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

import '../../app/app.common.functions.dart';
import '../../app/app.theme.dart';
import '../../views/view.bookmark/bookmark.view.dart';
import '../../views/view.notes/note.view.dart';
import '../../views/view.todos/todo.view.dart';
import 'home.controller.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  int _selectedIndex = 1;
  final List<Widget> _screens = [
    const NoteView(),
    const ToDoView(),
  ];
  HomeController homeConn = Get.put(HomeController());

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);

    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.secondary,
      appBar: _selectedIndex == 0
          ? AppBar(
              shadowColor: getTheme(context).brightness == Brightness.dark
                  ? const Color(0XFFFFFFFF).withOpacity(0.28)
                  : const Color(0XFF000000).withOpacity(0.8),
              backgroundColor: Theme.of(context).colorScheme.primary,
              title: SearchBar(
                backgroundColor: WidgetStateProperty.all(Colors.transparent),
                elevation: WidgetStateProperty.all(0.0),
                shadowColor: WidgetStateProperty.all(Colors.transparent),
                leading: Icon(Icons.search,
                    color: getTheme(context).brightness == Brightness.dark
                        ? const Color(0XFFFFFFFF)
                        : const Color(0XFF000000)),
                // Search icon
                hintText: '  Search',
                hintStyle: WidgetStateProperty.all(TextStyle(
                    color: getTheme(context).brightness == Brightness.dark
                        ? const Color(0XFFFFFFFF)
                        : const Color(0XFF000000))),
                padding: WidgetStateProperty.all(
                    const EdgeInsets.symmetric(horizontal: 4)),
                textStyle: WidgetStateProperty.all(TextStyle(
                    color: getTheme(context).brightness == Brightness.dark
                        ? const Color(0XFFFFFFFF)
                        : const Color(0XFF000000))),
                shape: WidgetStateProperty.all(RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.0),
                  side: BorderSide.none, // Remove border
                )),
              ),
            )
          : AppBar(
              shadowColor: getTheme(context).brightness == Brightness.dark
                  ? const Color(0XFFFFFFFF).withOpacity(0.28)
                  : const Color(0XFF000000).withOpacity(0.8),
              backgroundColor: Theme.of(context).colorScheme.primary,
            ),
      drawer: Obx(
        () => Drawer(
          width: MediaQuery.of(context).size.width / 1.6,
          backgroundColor: Theme.of(context).colorScheme.secondary,
          child: Padding(
            padding: const EdgeInsets.only(left: 24, right: 24),
            child: ListView(
              children: [
                const SizedBox(
                  height: 60,
                ),
                ListTile(
                  leading: Icon(
                    Icons.home_sharp,
                    size: 30,
                    color: getTheme(context).brightness == Brightness.dark
                        ? const Color(0XFFFFFFFF)
                        : const Color(0XFF000000),
                  ),
                  title: Text(
                    'Home',
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  onTap: () {
                    Navigator.pushAndRemoveUntil(
                        context,
                        CupertinoPageRoute(
                            builder: (context) => const HomeView()),
                        (route) => false);
                  },
                ),
                const SizedBox(
                  height: 30,
                ),
                ListTile(
                  leading: Icon(
                    Icons.bookmark_rounded,
                    size: 30,
                    color: getTheme(context).brightness == Brightness.dark
                        ? const Color(0XFFFFFFFF)
                        : const Color(0XFF000000),
                  ),
                  title: Text(
                    'Bookmarks',
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const BookmarkView()));
                  },
                ),
                const SizedBox(
                  height: 30,
                ),
                ListTile(
                  leading: Icon(
                    homeConn.isDarkMode.value
                        ? Icons.brightness_7_sharp
                        : Icons.brightness_4,
                    size: 30,
                    color: getTheme(context).brightness == Brightness.dark
                        ? const Color(0XFFFFFFFF)
                        : const Color(0XFF000000),
                  ),
                  title: Text(
                      homeConn.isDarkMode.value ? 'Light Mode' : 'Dark Mode',
                      style: getTheme(context).textTheme.titleLarge),
                  onTap: () {
                    if (homeConn.isDarkMode.value) {
                      Get.changeTheme(lightTheme);
                    } else {
                      Get.changeTheme(darkTheme);
                    }
                    setState(() {
                      homeConn.isDarkMode.value = !homeConn.isDarkMode.value;
                    });
                  },
                ),
                const SizedBox(
                  height: 30,
                ),
                ListTile(
                  leading: Icon(
                    Icons.info_sharp,
                    size: 30,
                    color: getTheme(context).brightness == Brightness.dark
                        ? const Color(0XFFFFFFFF)
                        : const Color(0XFF000000),
                  ),
                  title: Text(
                    'About',
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  onTap: () {
                    Navigator.pop(context);
                  },
                ),
                const SizedBox(
                  height: 30,
                ),
                ListTile(
                  leading: Icon(
                    Icons.recommend_sharp,
                    size: 30,
                    color: getTheme(context).brightness == Brightness.dark
                        ? const Color(0XFFFFFFFF)
                        : const Color(0XFF000000),
                  ),
                  title: Text(
                    'Support the Creator',
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  onTap: () {
                    Navigator.pop(context);
                  },
                ),
                const SizedBox(
                  height: 30,
                ),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: CurvedNavigationBar(
        backgroundColor: Theme.of(context).colorScheme.secondary,
        color: theme.brightness == Brightness.light
            ? const Color(0XFFFBF2E9)
            : const Color(0xFF121212),
        animationDuration: const Duration(milliseconds: 400),
        buttonBackgroundColor: Theme.of(context).colorScheme.secondary,
        items: [
          Padding(
            padding: const EdgeInsets.only(top: 12),
            child: FaIcon(
              FontAwesomeIcons.barsStaggered,
              size: 30,
              color: theme.brightness == Brightness.dark
                  ? const Color(0xFFFDEADE)
                  : const Color(0xFF353535),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 12),
            child: FaIcon(
              FontAwesomeIcons.solidNoteSticky,
              size: 30,
              color: theme.brightness == Brightness.dark
                  ? const Color(0xFFFDEADE)
                  : const Color(0xFF353535),
            ),
          ),
        ],
        index: _selectedIndex,
        onTap: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
      ),
      body: _screens[_selectedIndex],
    );
  }
}
