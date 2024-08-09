import 'package:flutter/material.dart';

import '../services/firestore.service.dart';

class NoteDeleteDialog extends StatelessWidget {
  final String docID;

  const NoteDeleteDialog({
    super.key,
    required this.docID,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Center(
          child: Text(
        "# Clear the Clutter 📝",
        style: Theme.of(context).textTheme.titleLarge,
      )),
      content: Text(
        "Ready to free up some mental space? Erase this note by pressing Delete.",
        style: Theme.of(context).textTheme.titleSmall,
      ),
      actions: <Widget>[
        ElevatedButton(
          child: const Text(
            "Cancel",
            style: TextStyle(color: Colors.black),
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        TextButton(
          child: const Text(
            "Delete",
            style: TextStyle(color: Colors.red),
          ),
          onPressed: () =>
              DatabaseHandler.deleteUserNotes(context, docID).whenComplete(
            () => Navigator.pop(context),
          ),
        ),
      ],
    );
  }
}
