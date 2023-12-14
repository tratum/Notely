import 'package:flutter/material.dart';

class NoteDeleteDialog extends StatelessWidget {
  final Function onDeletePressed;

  const NoteDeleteDialog({super.key, required this.onDeletePressed});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Center(
          child: Text(
        "Deleting Your Note 🗑️",
        style: Theme.of(context).textTheme.titleLarge,
      )),
      content: Text(
        "It's just Text, but could be ideas, plans, or inspiration. Ready to let Go ?",
        style: Theme.of(context).textTheme.titleSmall,
      ),
      actions: <Widget>[
        TextButton(
          child: const Text(
            "Cancel",
            style: TextStyle(color: Colors.grey),
          ),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        TextButton(
          child: const Text(
            "Delete",
            style: TextStyle(color: Colors.red),
          ),
          onPressed: () {
            onDeletePressed();
            Navigator.of(context).pop();
          },
        ),
      ],
    );
  }
}
