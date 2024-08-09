import 'package:flutter/material.dart';

import '../../services/firestore.service.dart';

class ToDoDeleteDialog extends StatelessWidget {
  final String docID;

  const ToDoDeleteDialog({super.key, required this.docID});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Center(
          child: Text(
        "# Declutter And Conquer 🗑️",
        style: Theme.of(context).textTheme.titleLarge,
      )),
      content: Text(
        "Ready to trim your Task List? Snip away this To-do by hitting Delete.",
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
          onPressed: () => DatabaseHandler.deleteUserTodos(context, docID)
              .whenComplete(() => Navigator.pop(context)),
        ),
      ],
    );
  }
}
