import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';

import '../../../commons/skeleton/note_skeleton.dart';
import '../../Notes/view/Note Card Tile/view/note_card_tile.dart';
import '../../Welcome Page/controller/welcome_page_controller.dart';

class FavNotes extends StatefulWidget {
  const FavNotes({super.key});

  @override
  State<FavNotes> createState() => _FavNotesState();
}

class _FavNotesState extends State<FavNotes> {
  WelcomePageController welcomePageController =
      Get.put(WelcomePageController());

  Stream<QuerySnapshot<Map<String, dynamic>>> getFavNotes() {
    final favNotesCollection = FirebaseFirestore.instance
        .collection('Notes Data for uid ${welcomePageController.uid.value}');
    final favQuery = favNotesCollection.where("isFav", isEqualTo: true);
    return favQuery.snapshots();
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
                  stream: getFavNotes(),
                  builder: (context, snapshot) {
                    final favNotes = snapshot.data?.docs ?? [];
                    if (snapshot.hasError) {
                      return Text(
                          '-------------------------Error: ${snapshot.error}');
                    }
                    if (favNotes.isEmpty) {
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
                        itemBuilder: (context, index) => const NotesSkeleton(),
                        separatorBuilder: (context, index) =>
                            const SizedBox(height: 16),
                        itemCount: 5,
                      );
                    }
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return ListView.separated(
                        itemBuilder: (context, index) => const NotesSkeleton(),
                        separatorBuilder: (context, index) =>
                            const SizedBox(height: 16),
                        itemCount: 5,
                      );
                    }
                    return ListView.builder(
                      itemBuilder: (BuildContext context, int index) {
                        Map<String, dynamic>? data = favNotes[index].data();
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
                      itemCount: favNotes.length,
                      itemExtent: 150,
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
