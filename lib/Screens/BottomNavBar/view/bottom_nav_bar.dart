import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:notely/Screens/BottomNavBar/controller/bottom_nav_bar_controller.dart';
import 'package:notely/Screens/HomeScreens/view/todo_home_screen_grid_view.dart';

import '../../HomeScreens/view/notes_home_screen.dart';

class BottomNavBar extends StatefulWidget {
  const BottomNavBar({super.key});

  @override
  State<BottomNavBar> createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  BottomNavBarController bottomNavBarController =
      Get.put(BottomNavBarController());

  List screens = [
    const NoteHomeScreen(),
    const TodoHomePageGridView(),
  ];

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);

    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.secondary,
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
              FontAwesomeIcons.solidNoteSticky,
              size: 30,
              color: theme.brightness == Brightness.dark
                  ? const Color(0xFFFDEADE)
                  : const Color(0xFF353535),
            ),
          ),
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
        ],
        index: bottomNavBarController.selectedIndex.value,
        onTap: (index) {
          setState(() {
            bottomNavBarController.selectedIndex.value = index;
          });
        },
      ),
      body: screens[bottomNavBarController.selectedIndex.value],
    );
  }
}
