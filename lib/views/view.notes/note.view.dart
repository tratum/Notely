import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

import '../../../services/firestore.service.dart';
import '../../app/app.common.functions.dart';
import '../../app/app.common.widgets.dart';
import '../../bottomsheets/bottomsheet.note.dart';
import '../../views/view.home/home.controller.dart';

class NoteView extends StatefulWidget {
  const NoteView({super.key});

  @override
  State<NoteView> createState() => _NoteViewState();
}

class _NoteViewState extends State<NoteView> {
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
              isScrollControlled: true,
              builder: (BuildContext context) => const NoteBottomsheet(),
              shape: const ContinuousRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(20))),
              backgroundColor: getTheme(context).brightness == Brightness.dark
                  ? Theme.of(context).colorScheme.surface
                  : Theme.of(context).colorScheme.surface,
              useSafeArea: true,
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
                  child: Text("${homeConn.noteLength.value} notes",
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
                    stream: DatabaseHandler.noteStream(),
                    builder: (context, snapshot) {
                      final notes = snapshot.data?.docs ?? [];
                      if (notes.isEmpty) {
                        return Container(
                          width: 580,
                          padding: const EdgeInsets.only(top: 30),
                          child: Align(
                            alignment: Alignment.topCenter,
                            child: Padding(
                              padding: const EdgeInsets.only(
                                  left: 18, right: 18, top: 20),
                              child: Lottie.network(
                                  'https://tratum.github.io/cloud-asset-storage/lottie/no-notes-data.json',
                                  repeat: true,
                                  width: 530,
                                  addRepaintBoundary: true),
                            ),
                          ),
                        );
                      }
                      if (snapshot.hasError) {
                        errorSnackbar(context, '${snapshot.error}');
                        throw Exception(
                            '-------------------------Error: ${snapshot.error}');
                      }
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return noteViewSkelton();
                      }
                      return ListView.builder(
                        itemBuilder: (BuildContext context, int index) {
                          homeConn.noteLength.value = notes.length;
                          return Column(
                            children: [
                              NoteCards(
                                heading: notes[index].data()['context'],
                                description: notes[index].data()['description'],
                                backgroundColor: getTheme(context).brightness ==
                                        Brightness.dark
                                    ? const Color(0XFF5B5B5B)
                                    : const Color(0XFFFFFFFF),
                                docID: notes[index].data()['docID'],
                                createdAt: formatDate((notes[index]
                                        .data()['timestamp'] as Timestamp)
                                    .toDate()),
                                isBookmarked:
                                    notes[index].data()['isBookmarked'],
                              ),
                              const SizedBox(
                                height: 16,
                              ),
                            ],
                          );
                        },
                        itemCount: notes.length,
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
