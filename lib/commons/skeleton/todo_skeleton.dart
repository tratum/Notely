import 'package:flutter/material.dart';
import 'package:notely/commons/skeleton/skelton.dart';

class TODOSkeleton extends StatelessWidget {
  const TODOSkeleton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.only(left: 8, bottom: 8),
      child: Row(children: [
        Skelton(
          height: 260,
          width: 246,
        ),
        SizedBox(
          width: 8,
        ),
        Column(
          children: [
            Skelton(
              height: 123,
              width: 130,
            ),
            SizedBox(
              height: 8,
            ),
            Skelton(
              height: 123,
              width: 130,
            ),
          ],
        )
      ]),
    );
  }
}
