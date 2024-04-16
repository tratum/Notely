import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';
import 'package:notely/Screens/BottomNavBar/view/bottom_nav_bar.dart';
import 'package:notely/Screens/Favourites/view/fav_notes.dart';
import 'package:notely/Screens/Notes/view/notes_modal_sheet.dart';
import 'package:notely/commons/skeleton/note_skeleton.dart';

import '../../../themes/color_theme.dart';
import '../../Notes/view/Note Card Tile/controller/note_card_controller.dart';
import '../../Notes/view/Note Card Tile/view/note_card_tile.dart';
import '../../Profile Image Modal Sheet/controller/profile_image_controller.dart';
import '../../Profile Image Modal Sheet/profile_images_modal_sheet.dart';
import '../../SearchBar/view/search_screen.dart';
import '../../Welcome Page/controller/welcome_page_controller.dart';
import '../controller/home_screen_controller.dart';

// ignore: must_be_immutable
class NoteHomeScreen extends StatefulWidget {
  const NoteHomeScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<NoteHomeScreen> createState() => _NoteHomeScreenState();
}

class _NoteHomeScreenState extends State<NoteHomeScreen> {
  ProfileImageController profileImageController =
      Get.put(ProfileImageController());
  HomeScreenController homeScreenController = Get.put(HomeScreenController());
  WelcomePageController welcomePageController =
      Get.put(WelcomePageController());
  NoteCardController noteCardController = Get.put(NoteCardController());

  User? user;
  FirebaseAuth auth = FirebaseAuth.instance;

  Stream<QuerySnapshot<Map<String, dynamic>>> getNotes() {
    final notesCollection = FirebaseFirestore.instance
        .collection('Notes Data for uid ${welcomePageController.uid.value}')
        .orderBy('TimeStamp', descending: true);
    return notesCollection.snapshots();
  }

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
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

    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.secondary,
      appBar: AppBar(
        shadowColor: theme.brightness == Brightness.dark
            ? const Color(0XFFFFFFFF).withOpacity(0.28)
            : const Color(0XFF000000).withOpacity(0.8),
        backgroundColor: Theme.of(context).colorScheme.primary,
        title: Row(
          children: [
            Transform.scale(
              scale: 1.2,
              child: GestureDetector(
                child: Icon(
                  Icons.search_rounded,
                  color: theme.brightness == Brightness.dark
                      ? const Color(0XFFFFFFFF)
                      : const Color(0xFF000000),
                  size: 24,
                  weight: 3,
                ),
                onTap: () {
                  showDialog(
                      context: context,
                      barrierDismissible: false,
                      builder: (BuildContext context) => const SearchScreen());
                },
              ),
            ),
            const Spacer(),
            GestureDetector(
              child: Obx(
                () => profileImageController.img.value == null
                    ? CircleAvatar(
                        radius: 16,
                        backgroundColor: theme.brightness == Brightness.dark
                            ? const Color(0XFFFFFFFF)
                            : const Color(0XFF000000),
                        child: Icon(
                          Icons.person,
                          color: theme.brightness == Brightness.dark
                              ? const Color(0XFF000000)
                              : const Color(0XFFFFFFFF),
                        ),
                      )
                    : CircleAvatar(
                        radius: 16,
                        backgroundColor: const Color(0XFFFFFFFF),
                        backgroundImage:
                            FileImage(profileImageController.img.value!),
                      ),
              ),
              onTap: () {
                showModalBottomSheet(
                  context: context,
                  builder: (context) => const ProfileImageModal(),
                  backgroundColor: Theme.of(context).colorScheme.background,
                  elevation: 30,
                  enableDrag: true,
                  isDismissible: true,
                  isScrollControlled: true,
                  useSafeArea: true,
                );
              },
            ),
          ],
        ),
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
                    color: theme.brightness == Brightness.dark
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
                            builder: (context) => const BottomNavBar()),
                        (route) => false);
                  },
                ),
                const SizedBox(
                  height: 30,
                ),
                ListTile(
                  leading: Icon(
                    Icons.favorite_outlined,
                    size: 30,
                    color: theme.brightness == Brightness.dark
                        ? const Color(0XFFFFFFFF)
                        : const Color(0XFF000000),
                  ),
                  title: Text(
                    'Favourites',
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const FavNotes()));
                  },
                ),
                const SizedBox(
                  height: 30,
                ),
                // ListTile(
                //   leading: Icon(
                //     Icons.access_time_filled_sharp,
                //     size: 30,
                //     color: theme.brightness == Brightness.dark
                //         ? const Color(0XFFFFFFFF)
                //         : const Color(0XFF000000),
                //   ),
                //   title: Text(
                //     'Recents',
                //     style: Theme.of(context).textTheme.titleLarge,
                //   ),
                //   onTap: () {
                //     Navigator.pop(context);
                //   },
                // ),
                // const SizedBox(
                //   height: 30,
                // ),
                ListTile(
                  leading: Icon(
                    homeScreenController.isDarkmode.value
                        ? Icons.brightness_7_sharp
                        : Icons.brightness_4,
                    size: 30,
                    color: theme.brightness == Brightness.dark
                        ? const Color(0XFFFFFFFF)
                        : const Color(0XFF000000),
                  ),
                  title: Text(
                      homeScreenController.isDarkmode.value
                          ? 'Light Mode'
                          : 'Dark Mode',
                      style: Theme.of(context).textTheme.titleLarge),
                  onTap: () {
                    if (homeScreenController.isDarkmode.value) {
                      Get.changeTheme(lightTheme);
                    } else {
                      Get.changeTheme(darkTheme);
                    }
                    setState(() {
                      homeScreenController.isDarkmode.value =
                          !homeScreenController.isDarkmode.value;
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
                    color: theme.brightness == Brightness.dark
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
                    color: theme.brightness == Brightness.dark
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
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(bottom: 60, right: 2),
        child: SizedBox(
          height: 80.0,
          width: 80.0,
          child: FloatingActionButton(
            backgroundColor: theme.brightness == Brightness.dark
                ? Theme.of(context).colorScheme.background
                : Theme.of(context).colorScheme.background,
            elevation: 0,
            onPressed: () => showModalBottomSheet(
              context: context,
              builder: (BuildContext context) {
                return NoteModalSheet(
                  isFav: false,
                );
              },
              isScrollControlled: true,
            ),
            shape: const CircleBorder(),
            child: Icon(Icons.add,
                size: theme.brightness == Brightness.dark ? 50 : 40,
                weight: 0.2,
                color: theme.brightness == Brightness.dark
                    ? const Color(0xFFFFFFFF)
                    : const Color(0xFF000000)),
          ),
        ),
      ),
      body: SafeArea(
        child: RefreshIndicator(
          color: const Color(0xFF37BBE6),
          backgroundColor: const Color(0XFF000000),
          onRefresh: () async {
            setState(() {});
          },
          child: Column(
            children: [
              const SizedBox(
                height: 40,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 26),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text("All Notes",
                      style: TextStyle(
                        fontFamily: 'Alata',
                        fontSize: 44,
                        fontWeight: FontWeight.w500,
                        fontStyle: FontStyle.normal,
                        decoration: TextDecoration.none,
                        color: theme.brightness == Brightness.dark
                            ? const Color(0xFFFDEADE)
                            : const Color(0xFF000000),
                      )),
                ),
              ),
              const SizedBox(
                height: 6,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 26),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text("${homeScreenController.noteLength.value} notes",
                      style: TextStyle(
                        fontFamily: 'Alata',
                        fontSize: 18,
                        fontWeight: FontWeight.w400,
                        fontStyle: FontStyle.normal,
                        decoration: TextDecoration.none,
                        color: theme.brightness == Brightness.dark
                            ? const Color(0xFFFDEADE)
                            : const Color(0xFF000000),
                      )),
                ),
              ),
              const SizedBox(
                height: 50,
              ),
              Expanded(
                child: StreamBuilder(
                    stream: getNotes(),
                    builder: (context, snapshot) {
                      final notes = snapshot.data?.docs ?? [];
                      if (snapshot.hasError) {
                        return Text(
                            '-------------------------Error: ${snapshot.error}');
                      }
                      if (notes.isEmpty) {
                        return Container(
                          width: 580,
                          padding: const EdgeInsets.only(top: 30),
                          child: Align(
                            alignment: Alignment.topCenter,
                            child: Padding(
                              padding: const EdgeInsets.only(
                                  left: 18, right: 18, top: 20),
                              child: Lottie.asset(
                                  'asset/lottiefiles/no-notes-data.json',
                                  repeat: true,
                                  width: 530,
                                  addRepaintBoundary: true),
                            ),
                          ),
                        );
                      }
                      if (snapshot.hasError) {
                        return ListView.separated(
                          itemBuilder: (context, index) =>
                              const NotesSkeleton(),
                          separatorBuilder: (context, index) =>
                              const SizedBox(height: 16),
                          itemCount: 5,
                        );
                      }
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return ListView.separated(
                          itemBuilder: (context, index) =>
                              const NotesSkeleton(),
                          separatorBuilder: (context, index) =>
                              const SizedBox(height: 16),
                          itemCount: 5,
                        );
                        // FutureBuilder(
                        //   future: Future.delayed(const Duration(seconds: 2)),
                        //   builder: (context, snapshot) {
                        //     if (snapshot.connectionState == ConnectionState.done){
                        //       return ListView.separated(
                        //         itemBuilder: (context, index) => const NotesSkeleton(),
                        //         separatorBuilder: (context, index) => const SizedBox(height: 8),
                        //         itemCount: 5,
                        //       );
                        //     }
                        //     else {
                        //       return ListView.separated(
                        //         itemBuilder: (context, index) => const NotesSkeleton(),
                        //         separatorBuilder: (context, index) => const SizedBox(height: 8),
                        //         itemCount: 5,
                        //       );
                        //     }
                        //
                        //   });
                      }
                      return ListView.builder(
                        itemBuilder: (BuildContext context, int index) {
                          homeScreenController.noteLength.value = notes.length;
                          Map<String, dynamic>? data = notes[index].data();
                          return Column(
                            children: [
                              NoteCardTile(
                                noteTitle: data['Note_Title'] ?? '',
                                noteText: data['Note_Description'] ?? '',
                                backgroundColor:
                                    theme.brightness == Brightness.dark
                                        ? const Color(0XFF5B5B5B)
                                        : const Color(0XFFFFFFFF),
                                docID: data['docID'],
                                listIndex: index,
                                dateCreation: formatDate(
                                    (data['TimeStamp'] as Timestamp).toDate()),
                                isFav: data['isFav'],
                              ),
                              const SizedBox(
                                height: 16,
                              ),
                            ],
                          );
                        },
                        itemCount: notes.length,
                      );
                    }
                    ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
