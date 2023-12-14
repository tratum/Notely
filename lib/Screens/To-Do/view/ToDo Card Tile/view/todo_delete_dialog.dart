import 'package:flutter/material.dart';

class TodoDeleteDialog extends StatelessWidget {
  final Function onDeletePressed;

  const TodoDeleteDialog({super.key, required this.onDeletePressed});

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
