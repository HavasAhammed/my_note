import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class NoteDelete extends StatelessWidget {
  const NoteDelete({super.key});

  @override
  Widget build(BuildContext context) {
    return CupertinoAlertDialog(
      title: const Text('Warning!'),
      content: const Text('Are you sure you want to delete this note?'),
      actions: [
        TextButton(
            onPressed: () {
              Navigator.of(context).pop(false);
            },
            child: const Text('Cancel')),
        TextButton(
            onPressed: () {
              Navigator.of(context).pop(true);
            },
            child: const Text(
              'Delete',
              style: TextStyle(color: Colors.red),
            )),
      ],
    );
  }
}
