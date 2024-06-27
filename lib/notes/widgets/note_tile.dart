import 'package:flutter/material.dart';
import 'package:notes_manager/notes/models/note.dart';

class NoteTile extends StatelessWidget {
  final Note note;
  final VoidCallback onEdit;

  const NoteTile({super.key, required this.onEdit, required this.note});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15.0),
        color: note.isImportant ? Colors.amber : Colors.white,
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(note.title),
                ElevatedButton(onPressed: onEdit, child: const Text('Edit')),
              ],
            ),
            Text(note.description ?? ''),
            Text(note.isImportant.toString()),
            Text(note.isResolved.toString()),
          ],
        ),
      ),
    );
  }
}
