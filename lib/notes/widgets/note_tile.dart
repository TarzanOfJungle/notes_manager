import 'package:flutter/material.dart';
import 'package:notes_manager/notes/models/note.dart';

class NoteTile extends StatelessWidget {
  final Note note;
  final VoidCallback onEdit;
  final VoidCallback onDelete;

  const NoteTile(
      {super.key,
      required this.onEdit,
      required this.note,
      required this.onDelete});

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
                ElevatedButton(onPressed: onDelete, child: const Text('Delete')),
              ],
            ),
            Text(note.description ?? ''),
          ],
        ),
      ),
    );
  }
}
