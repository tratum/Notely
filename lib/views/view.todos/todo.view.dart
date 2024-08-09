import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

import '../../../services/firestore.service.dart';
import '../../app/app.common.functions.dart';
import '../../app/app.common.widgets.dart';
import '../../bottomsheets/bottomsheet.todo.dart';
import '../view.home/home.controller.dart';

class ToDoView extends StatefulWidget {
  const ToDoView({super.key});

  @override
  State<ToDoView> createState() => _ToDoViewState();
}

class _ToDoViewState extends State<ToDoView> {
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
  HomeController homeConn = Get.put(HomeController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.secondary,
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(bottom: 60, right: 2),
        child: SizedBox(
          height: 80.0,
          width: 80.0,
          child: FloatingActionButton(
            backgroundColor: getTheme(context).brightness == Brightness.dark
                ? Theme.of(context).colorScheme.surface
                : Theme.of(context).colorScheme.surface,
            elevation: 0,
            onPressed: () => showModalBottomSheet(
              context: context,
              builder: (context) => const ToDoBottomsheet(),
              backgroundColor: getTheme(context).brightness == Brightness.dark
                  ? Theme.of(context).colorScheme.surface
                  : Theme.of(context).colorScheme.surface,
              elevation: 30,
              useSafeArea: true,
              enableDrag: false,
              isDismissible: false,
            ),
            shape: const CircleBorder(),
            child: Icon(Icons.add,
                size: getTheme(context).brightness == Brightness.dark ? 50 : 40,
                weight: 0.2,
                color: getTheme(context).brightness == Brightness.dark
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
            mainAxisSize: MainAxisSize.min,
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
                        color: getTheme(context).brightness == Brightness.dark
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
                  child: Text("${homeConn.todoLength.value} todos",
                      style: TextStyle(
                        fontFamily: 'Alata',
                        fontSize: 18,
                        fontWeight: FontWeight.w400,
                        fontStyle: FontStyle.normal,
                        decoration: TextDecoration.none,
                        color: getTheme(context).brightness == Brightness.dark
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
                    stream: DatabaseHandler.todoStream(),
                    builder: (context, snapshot) {
                      final todoStream = snapshot.data?.docs ?? [];
                      if (snapshot.hasError) {
                        errorSnackbar(context, '${snapshot.error}');
                        throw Exception(
                            '-----------------Error: ${snapshot.error}');
                      }
                      if (todoStream.isEmpty) {
                        return Container(
                          width: 580,
                          padding: const EdgeInsets.only(top: 60),
                          child: Align(
                            alignment: Alignment.topCenter,
                            child: Padding(
                              padding: const EdgeInsets.only(
                                  left: 18, right: 18, top: 20),
                              child: Lottie.network(
                                  'https://tratum.github.io/cloud-asset-storage/lottie/search_empty.json',
                                  repeat: true,
                                  width: 530,
                                  addRepaintBoundary: true),
                            ),
                          ),
                        );
                      }
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return todoViewSkelton();
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
                          ],
                        ),
                        scrollDirection: Axis.vertical,
                        semanticChildCount: todoStream.length,
                        shrinkWrap: true,
                        childrenDelegate: SliverChildBuilderDelegate(
                          (context, index) {
                            homeConn.todoLength.value = todoStream.length;
                            return ToDoCards(
                              docID: todoStream[index].data()['docID'],
                              heading: todoStream[index].data()['context'],
                              maxLines: largeTileIdentifier(index) ? 7 : 1,
                              description:
                                  todoStream[index].data()['description'],
                              backgroundColor:
                                  cardColors[index % cardColors.length],
                              isBookmarked:
                                  todoStream[index].data()['isBookmarked'],
                              completionStatus:
                                  todoStream[index].data()['completionStatus'],
                            );
                          },
                          childCount: todoStream.length,
                        ),
                      );
                    }),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
