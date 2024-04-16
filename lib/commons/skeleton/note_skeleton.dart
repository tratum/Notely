import 'package:flutter/cupertino.dart';
import 'package:notely/commons/skeleton/skelton.dart';

class NotesSkeleton extends StatelessWidget {
  const NotesSkeleton({super.key});

  @override
  Widget build(BuildContext context) {
    return const Padding(
        padding: EdgeInsets.only(left: 24, bottom: 8, right: 24),
        child: Column(
          children: [
            Skelton(
              height: 100,
            )
          ],
        ));
  }
}
