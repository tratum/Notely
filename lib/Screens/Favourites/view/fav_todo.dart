import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:notely/Screens/To-Do/view/ToDo%20Card%20Tile/view/todo_card_tile_grid_view.dart';

import '../../../commons/skeleton/todo_skeleton.dart';
import '../../Welcome Page/controller/welcome_page_controller.dart';

class FavToDo extends StatefulWidget {
  const FavToDo({super.key});

  @override
  State<FavToDo> createState() => _FavToDoState();
}

class _FavToDoState extends State<FavToDo> {
  WelcomePageController welcomePageController =
      Get.put(WelcomePageController());

  Stream<QuerySnapshot<Map<String, dynamic>>> getFavTODO() {
    final favTODOCollection = FirebaseFirestore.instance
        .collection("ToDo Data for uid ${welcomePageController.uid.value}");
    final favQuery = favTODOCollection.where("isFav", isEqualTo: true);
    return favQuery.snapshots();
  }

  final List<Color> cardColors = [
    const Color(0XFFb3fbdf),
    const Color(0XFFe4c1f9),
    const Color(0XFFFFBC9B),
    const Color(0XFF9bf6ff),
    const Color(0XFFffd6e0),
    const Color(0XFFffadad),
    const Color(0XFFcaffbf),
    const Color(0XFFfdffb6),
  ];

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    return Scaffold(
      body: SafeArea(
        child: RefreshIndicator(
          color: const Color(0xFF37BBE6),
          backgroundColor: const Color(0XFF000000),
          onRefresh: () async {
            setState(() {});
          },
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 28, left: 20),
                child: Align(
                  alignment: Alignment.topLeft,
                  child: GestureDetector(
                    child: const Icon(Icons.arrow_back_ios_new_sharp),
                    onTap: () {
                      Navigator.pop(context);
                    },
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 32, top: 24, bottom: 24),
                child: Row(
                  children: [
                    Text('All Favourites',
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
                    const SizedBox(
                      width: 20,
                    ),
                    const Icon(
                      Icons.favorite,
                      color: Color(0xFFEC0A70),
                      size: 44,
                    )
                  ],
                ),
              ),
              const SizedBox(
                height: 40,
              ),
              Expanded(
                child: StreamBuilder(
                  stream: getFavTODO(),
                  builder: (context, snapshot) {
                    final favTODO = snapshot.data?.docs ?? [];
                    if (snapshot.hasError) {
                      return Text(
                          '-------------------------Error: ${snapshot.error}');
                    }
                    if (favTODO.isEmpty) {
                      return Container(
                        width: 570,
                        padding: const EdgeInsets.only(top: 30),
                        child: Align(
                          alignment: Alignment.topCenter,
                          child: Padding(
                            padding: const EdgeInsets.only(
                                left: 18, right: 18, top: 20),
                            child: Lottie.asset(
                                'asset/lottiefiles/no-favourite.json',
                                repeat: true,
                                width: 530,
                                addRepaintBoundary: true),
                          ),
                        ),
                      );
                    }
                    if (snapshot.hasError) {
                      return ListView.separated(
                        itemBuilder: (context, index) => const TODOSkeleton(),
                        separatorBuilder: (context, index) =>
                            const SizedBox(height: 16),
                        itemCount: 3,
                      );
                    }
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return ListView.separated(
                        itemBuilder: (context, index) => const TODOSkeleton(),
                        separatorBuilder: (context, index) =>
                            const SizedBox(height: 16),
                        itemCount: 5,
                      );
                    }
                    return GridView.custom(
                      gridDelegate: SliverQuiltedGridDelegate(
                        crossAxisCount: 3,
                        repeatPattern: QuiltedGridRepeatPattern.inverted,
                        mainAxisSpacing: 12,
                        crossAxisSpacing: 0,
                        pattern: [
                          const QuiltedGridTile(2, 2),
                          const QuiltedGridTile(1, 1),
                          const QuiltedGridTile(1, 1),
                          // QuiltedGridTile(1, 2),
                        ],
                      ),
                      scrollDirection: Axis.vertical,
                      semanticChildCount: favTODO.length,
                      shrinkWrap: true,
                      childrenDelegate:
                          SliverChildBuilderDelegate((context, index) {
                        Map<String, dynamic>? data = favTODO[index].data();
                        String todoTitle = data['ToDo_Title'] ?? '';
                        String todoDescription = data['ToDo_Description'] ?? '';
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
                      }, childCount: favTODO.length),
                    );
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
