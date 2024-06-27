import 'package:flutter/material.dart';
import 'package:notes_manager/notes/models/note.dart';

class NoteTile extends StatelessWidget {
  final Note note;
  final VoidCallback onEdit;

  const NoteTile({super.key, required this.onEdit, required this.note});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: note.isImportant ? Colors.amber : Colors.white,
      child: Column(
        children: [
          Text(note.title),
          Text(note.isImportant.toString()),
          Text(note.isResolved.toString()),
        ],
      ),
    );
  }
}
