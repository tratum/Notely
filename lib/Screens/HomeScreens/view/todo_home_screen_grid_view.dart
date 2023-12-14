import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:notely/Screens/BottomNavBar/view/bottom_nav_bar.dart';
import 'package:notely/Screens/Favourites/view/fav_todo.dart';
import 'package:notely/Screens/Profile%20Image%20Modal%20Sheet/controller/profile_image_controller.dart';
import 'package:notely/Screens/Welcome%20Page/controller/welcome_page_controller.dart';
import 'package:notely/themes/color_theme.dart';
import '../../../commons/skeleton/todo_skeleton.dart';
import '../../Profile Image Modal Sheet/profile_images_modal_sheet.dart';
import '../../To-Do/controller/todo_modal_controller.dart';
import '../../To-Do/view/ToDo Card Tile/controller/todo_card_controller.dart';
import '../../To-Do/view/ToDo Card Tile/view/todo_card_tile_grid_view.dart';
import '../../To-Do/view/todo_modal_sheet.dart';
import '../controller/home_screen_controller.dart';

class TodoHomePageGridView extends StatefulWidget {
  const TodoHomePageGridView({Key? key}) : super(key: key);

  @override
  State<TodoHomePageGridView> createState() => _TodoHomePageGridViewState();
}

class _TodoHomePageGridViewState extends State<TodoHomePageGridView> {
  HomeScreenController homeScreenController = Get.put(HomeScreenController());
  TodoModalController todoModalController = Get.put(TodoModalController());
  TodoCardController todoCardController = Get.put(TodoCardController());
  WelcomePageController welcomePageController =
      Get.put(WelcomePageController());
  ProfileImageController profileImageController =
      Get.put(ProfileImageController());

  User? user;
  FirebaseAuth auth = FirebaseAuth.instance;

  Stream<QuerySnapshot<Map<String, dynamic>>> getNotes() {
    final notesCollection = FirebaseFirestore.instance
        .collection("ToDo Data for uid ${welcomePageController.uid.value}")
        .orderBy('TimeStamp', descending: true);
    return notesCollection.snapshots();
  }

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);

    final List<Color> cardColors = [
      const Color(0XFFfdffb6),
      const Color(0XFFcaffbf),
      const Color(0XFFffadad),
      const Color(0XFFffd6e0),
      const Color(0XFF9bf6ff),
      const Color(0XFFFFBC9B),
      const Color(0XFFe4c1f9),
      const Color(0XFFb3fbdf),
    ];

    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.secondary,
      appBar: AppBar(
        shadowColor: theme.brightness == Brightness.dark
            ? const Color(0XFFFFFFFF).withOpacity(0.28)
            : const Color(0XFF000000).withOpacity(0.8),
        backgroundColor: Theme.of(context).colorScheme.primary,
        title: Row(
          children: [
            // Transform.scale(
            //   scale: 1.2,
            //   child: GestureDetector(
            //     child: Icon(
            //       Icons.search_rounded,
            //       color: theme.brightness == Brightness.dark
            //           ? const Color(0XFFFFFFFF)
            //           : const Color(0xFF000000),
            //       size: 24,
            //       weight: 3,
            //     ),
            //     onTap: () {
            //       showDialog(
            //           context: context,
            //           barrierDismissible: false,
            //           builder: (BuildContext context) => const SearchScreen());
            //     },
            //   ),
            // ),
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
                            builder: (context) => const FavToDo()));
                  },
                ),
                const SizedBox(
                  height: 30,
                ),
                ListTile(
                  leading: Icon(
                    Icons.access_time_filled_sharp,
                    size: 30,
                    color: theme.brightness == Brightness.dark
                        ? const Color(0XFFFFFFFF)
                        : const Color(0XFF000000),
                  ),
                  title: Text(
                    'Recents',
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
              builder: (context) => ToDoModalSheet(
                isFav: false,
              ),
              backgroundColor: theme.brightness == Brightness.dark
                  ? Theme.of(context).colorScheme.background
                  : Theme.of(context).colorScheme.background,
              elevation: 30,
              enableDrag: true,
              isDismissible: false,
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
                  child: Text("All To-Dos",
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
                  child: Text("${homeScreenController.todoLength.value} To-Do",
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
                          padding: const EdgeInsets.only(top: 60),
                          child: Align(
                            alignment: Alignment.topCenter,
                            child: Padding(
                              padding: const EdgeInsets.only(
                                  left: 18, right: 18, top: 20),
                              child: Lottie.asset(
                                  'asset/lottiefiles/search_empty.json',
                                  repeat: true,
                                  width: 530,
                                  addRepaintBoundary: true),
                            ),
                          ),
                        );
                      }
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return ListView.separated(
                            itemBuilder: (context, index) =>
                                const TODOSkeleton(),
                            separatorBuilder: (context, index) =>
                                const SizedBox(
                                  height: 8,
                                ),
                            itemCount: 2);
                      }
                      return GridView.custom(
                        gridDelegate: SliverQuiltedGridDelegate(
                          crossAxisCount: 3,
                          repeatPattern: QuiltedGridRepeatPattern.inverted,
                          mainAxisSpacing: 10,
                          crossAxisSpacing: 0,
                          pattern: [
                            const QuiltedGridTile(2, 2),
                            const QuiltedGridTile(1, 1),
                            const QuiltedGridTile(1, 1),
                            // QuiltedGridTile(1, 2),
                          ],
                        ),
                        scrollDirection: Axis.vertical,
                        semanticChildCount: notes.length,
                        shrinkWrap: true,
                        childrenDelegate:
                            SliverChildBuilderDelegate((context, index) {
                          homeScreenController.todoLength.value = notes.length;
                          Map<String, dynamic>? data = notes[index].data();
                          String todoTitle = data['ToDo_Title'] ?? '';
                          String todoDescription =
                              data['ToDo_Description'] ?? '';
                          String docID = data['docID'] ?? '';
                          return ToDoCardTileGridView(
                            cardTitle: todoTitle,
                            cardText: todoDescription,
                            backgroundColor:
                                cardColors[index % cardColors.length],
                            docID: docID,
                            listIndex: index,
                            isFav: false,
                          );
                        }, childCount: notes.length),
                      );
                      //             )
                      //   GridView.custom(
                      //   childrenDelegate: SliverChildBuilderDelegate(
                      //         (context, index) {
                      //       if (index < notes.length) {
                      //         var colorIndex = index % cardColors.length;
                      //         homeScreenController.todoLength.value = notes.length;
                      //         return Column(
                      //           children: [
                      //             ToDoCardTile(
                      //               cardTitle: notes[index]['ToDo_Title'] ?? '',
                      //               cardText: notes[index]['ToDo_Description'] ?? '',
                      //               backgroundColor: cardColors[colorIndex],
                      //               docID: notes[index]['docID'],
                      //               listIndex: index,
                      //             ),
                      //           ],
                      //         );
                      //       } else {
                      //         // Handle the case where the index is out of bounds
                      //         return Container(); // or some other widget indicating an issue
                      //       }
                      //     },
                      //   ),
                      //   // )(BuildContext context, int index) {
                      //   //   var colorIndex = index % cardColors.length;
                      //   //   homeScreenController.todoLength.value = notes.length;
                      //   //   return Column(
                      //   //     children: [
                      //   //       ToDoCardTile(
                      //   //         cardTitle: notes[index]['ToDo_Title'] ?? '',
                      //   //         cardText:
                      //   //         notes[index]['ToDo_Description'] ?? '',
                      //   //         backgroundColor: cardColors[colorIndex],
                      //   //         docID: notes[index]['docID'],
                      //   //         listIndex: index,
                      //   //       ),
                      //   //     ],
                      //   //   );
                      //   // },
                      //   gridDelegate: SliverQuiltedGridDelegate(
                      //     crossAxisCount: 2,
                      //     mainAxisSpacing: 2,
                      //     crossAxisSpacing: 2,
                      //     repeatPattern: QuiltedGridRepeatPattern.inverted,
                      //     pattern: [
                      //       const QuiltedGridTile(2, 1),
                      //       const QuiltedGridTile(1, 1),
                      //       const QuiltedGridTile(1, 1),
                      //       const QuiltedGridTile(1, 2),
                      //     ],
                      //   ),
                      // );
                    }),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
